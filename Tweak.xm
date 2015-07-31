#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "KMMedia.h"

@interface BMStackModel : NSObject

@property(copy) NSURL * streamURL;

@end


%hook BMFeedViewController

-(BMStackModel *) currentPlayingStack {
    NSArray *m3u8Data; //contents of m3u8
    NSData *urlData; //actual data of m3u8 file or ts file
    NSInteger count; //count for the for loop
    NSString *directoryUrl; //file location url
    NSString *documentDirectory; //file location url string
    NSString *downloadUrlString; //m3u8 download url string
    NSString *tsDownloadUrlString; //ts download url string
    NSURL *downloadUrl; //m3u8 download url
    NSURL *tsDownloadUrl; //ts download url

    %orig;

    downloadUrl = %orig.streamURL;
    downloadUrlString = [downloadUrl absoluteString];

    //Here we changed the letter from A-C depending on what quality type we want. A being lowest and C being highest
    downloadUrlString = [downloadUrlString stringByReplacingOccurrencesOfString:@"master" withString:@"C"]; 
    downloadUrl = [NSURL URLWithString:downloadUrlString];

    urlData = [NSData dataWithContentsOfURL:downloadUrl];

    if (urlData)
    {
        documentDirectory = [NSTemporaryDirectory() stringByAppendingPathComponent:@"temp.txt" ]; // This will need to be removed now but being kept for debuging purposes.
        [urlData writeToFile:documentDirectory atomically:YES];
        m3u8Data = [[NSString stringWithContentsOfFile:documentDirectory
                                              encoding:NSUTF8StringEncoding
                                                 error:nil] componentsSeparatedByString:@"\n"];

        count = 6; //The offset for the .m3u8 file
        for (count = 6; count < [m3u8Data count]; count = count + 2)
        {
            tsDownloadUrlString = [m3u8Data objectAtIndex:count];
            tsDownloadUrl = [NSURL fileURLWithPath:tsDownloadUrlString];
            
            urlData = [NSData dataWithContentsOfURL:tsDownloadUrl];

            if (urlData)
            {
                directoryUrl = [NSTemporaryDirectory() stringByAppendingPathComponent:@"temp.ts" ];
                [urlData writeToFile:directoryUrl atomically:YES];
                /*
                * This is where the conversion function should be called!
                */

                SEL URLConvert = @selector(convertVideo:);
                [self performSelector:URLConvert withObject: tsDownloadUrl];
            }
        }
    }
    return %orig;
}


/*
Currently this is my try at converting videos but it seems really wrong haha :P go figures
-wizage
*/

%new(v@:?)
-(void)convertVideo: (NSURL *) url
{
    NSString *resultURLString;
    NSURL *resultURL;
    NSMutableArray *mtsAssets = nil;
    NSArray *tsAssets = [NSMutableArray arrayWithCapacity:1];
    KMMediaAsset *mp4Asset;

    [mtsAssets addObject:[KMMediaAsset assetWithURL:url withFormat:KMMediaFormatTS]];
    tsAssets = [mtsAssets copy];
    resultURLString = [NSTemporaryDirectory() stringByAppendingPathComponent:@"result.mp4" ];
    resultURL = [NSURL fileURLWithPath:resultURLString];
    mp4Asset = [KMMediaAsset assetWithURL:resultURL withFormat:KMMediaFormatMP4];
    KMMediaAssetExportSession *tsToMP4ExportSession = [[KMMediaAssetExportSession alloc] initWithInputAssets:tsAssets];
    tsToMP4ExportSession.outputAssets = @[mp4Asset];
}

%end
