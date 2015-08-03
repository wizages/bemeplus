#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Headers.h"
#import <Spex/Spex.h>

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

/**
 * You don't have to manually define the method signature, one will be generated at build time - nin9tyfour
 */
%new(v@:?)
-(void)convertVideo: (NSURL *) url
{
	/*
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
    */
}

%end

%hook BMPlayerViewController

/**
 * Whether or not playback should end and close the player view controller. This allows users to "tap to play" rather than tap and hold.
 * Obtain a reference to the last URL of the M3U8 playlist.
 * 
 * - nin9tyfour
 */
static BOOL shouldEndPlayback;
static NSURL *lastURL;

/**
 * Shows overlay, will hopefully include options to save, replay, etc.
 * 
 * - nin9tyfour
 */
%new
- (void)bmp_showOverlayControls{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
	[button setTitle:@"Save" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(replay) forControlEvents:UIControlEventTouchUpInside];
	button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
	[self.view addSubview:button];
}

/**
 * User has tapped the close button, now playing view will close.
 *
 * Thinking of having an option to tap to play/hold to play, having your finger on screen can obstruct the view
 * Depending on the users settings, these can be %grouped
 *
 * I try to use methods that will not be created in future, something like closeTapped may be implemented by the official developers
 * Which can result in somewhat strange behaviour.
 * 
 * - nin9tyfour
 */

%new
- (void)bmp_closeTapped{

}

- (void)onNoLongerTouching{
	/**
	 * Typical behaviour when this method is called is to close the playing view, we want to hinder this to allow the user to use the tweak single handedly.
	 *
	 * - nin9tyfour
	 */
	if (shouldEndPlayback)
	{
		%orig;
	}
}

- (void)playbackDidEnd{
	/**
	 * We're going to present the overlay controls now, since playback has ended, this will give the user the opportunity to save/replay/close the video
	 *
	 * We should discuss whether we want to have a UI that has overlay controls (like showing the save button all the time, as opposed to after the video has finished).
	 *
	 * Some users will prefer the unhindered viewing experience, whilst others will prefer to have the ability to quickly view multiple videos...not sure what to do there.
	 * 
	 * - nin9tyfour
	 */
	if (lastURL)
	{
		[self bmp_showOverlayControls];
	}
}

%end