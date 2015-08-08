#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//#import <Spex/Spex.h>
#include "NSTask.h"
#include "BMFeedViewController.h"
#include "TSInfo.h"
#import "Headers.h"
/*

*/
/*
%hook BMFeedViewController

-(BMStackModel *) currentPlayingStack {
    NSArray *m3u8Data; //contents of m3u8
    NSMutableArray *tsArray;
    NSData *urlData; //actual data of m3u8 file or ts file
    int count; //count for the for loop
    //NSString *directoryUrl; //file location url
    NSString *downloadUrlString; //m3u8 download url string
    NSString *tsDownloadUrlString; //ts download url string
    NSURL *downloadUrl; //m3u8 download url
    BMUserModel *userInfo;
    TSInfo *tsInfo;
    %orig;

    /*
    Initialize variables;
    
    tsArray = [[NSMutableArray alloc] init];
    downloadUrl = %orig.streamURL;
    userInfo = %orig.user;
    downloadUrlString = [downloadUrl absoluteString];
    videoQuality = high;

    /*
    Here we changed the letter from A-C depending on what quality type we want. A being lowest and C being highest
    
    if (videoQuality == high){
        downloadUrlString = [downloadUrlString stringByReplacingOccurrencesOfString:@"master" withString:@"C"]; 
    }
    else if (videoQuality == medium){
        downloadUrlString = [downloadUrlString stringByReplacingOccurrencesOfString:@"master" withString:@"B"]; 
    }
    else {
        downloadUrlString = [downloadUrlString stringByReplacingOccurrencesOfString:@"master" withString:@"A"]; 
    }

    //HBLogDebug(@"%@", downloadUrlString);
    downloadUrl = [NSURL URLWithString:downloadUrlString];
    urlData = [NSData dataWithContentsOfURL:downloadUrl];

    if (urlData)
    {
        m3u8Data = [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding] componentsSeparatedByString:@"\n"];

        HBLogDebug(@"Testing shit, : %@", m3u8Data);
        for (count = 6; count < [m3u8Data count]; count = count + 2)
        {
            tsDownloadUrlString = [m3u8Data objectAtIndex:count];
            tsInfo = [[TSInfo alloc] initWithURL:tsDownloadUrlString];
            tsInfo.fileName = [NSString stringWithFormat:@"%@_%ld%ld",userInfo.displayName, (long)%orig.identifier, (long)[tsArray count]];
            tsInfo.shouldDownload = YES; // This will allows us to select which videos to download.
            [tsArray addObject:tsInfo];
            HBLogDebug(@"tsInfo contains: %@, %d, %@", tsInfo.fileName, tsInfo.shouldDownload, tsInfo.tsURL);
        }

        /*
        * Created this array so that you can make the display UI here.
        * and then populate saying chose which videos from the count
        * of the size of the tsArray size. And then if they say yes
        * or no you would set the tsInfo.shouldDownload flag.
        
        HBLogDebug(@"tsArray contains: %@", tsArray);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSUInteger count;
            TSInfo *tsInfo;
            NSData *urlData;
            NSString *directoryUrl;
            HBLogDebug(@"Array count: %ld", (long) [tsArray count]);
        for (count = 0; count < [tsArray count]; count++)
        {
            tsInfo = [tsArray objectAtIndex:count];
            if ( tsInfo.shouldDownload )
            {
                urlData = [NSData dataWithContentsOfURL:tsInfo.tsURL];
                if (urlData)
                {
                    HBLogDebug(@"Testing shit");
                    directoryUrl = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.ts", tsInfo.fileName]];
                    //[urlData writeToFile:directoryUrl atomically:YES];
                    //[self convertVideo:tsInfo.fileName];
                    //[[NSFileManager defaultManager] removeItemAtPath:directoryUrl error:NULL]; //Clean up the .ts file you dont need it no more
                }
            }
        }
        });
    }
    return %orig;
}

/*
* This is a new fuction that will convert the video from .ts to .mov


%new(v@:?)
-(void)convertVideo: (NSString *) fileName{
    convertVideoAtPath(fileName);
    [self importToPhotoAlbum:fileName];
}

/*
* This is a new fuction that will import the new .mov video to
* the photo album and then delete the tmp file. Later we can
* also create a phantom like vault.

%new(v@:?)
-(void) importToPhotoAlbum: (NSString *) fileName
{
    //NSString *directoryUrl;
    UISaveVideoAtPathToSavedPhotosAlbum([NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov", fileName]], nil, nil, nil);
    //directoryUrl = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.ts", fileName]];
    //[[NSFileManager defaultManager] removeItemAtPath:directoryUrl error:NULL];
    //directoryUrl = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov", fileName]];
    //[[NSFileManager defaultManager] removeItemAtPath:directoryUrl error:NULL];
}

%end
*/

%subclass BMPHTTPRequestOperation : AFHTTPRequestOperation

%new
- (NSString *)savePath {
    return objc_getAssociatedObject(self, @selector(savePath));
}
 
%new
- (void)setSavePath:(NSString *)value {
    objc_setAssociatedObject(self, @selector(savePath), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%new
- (NSNumber *)index {
    return objc_getAssociatedObject(self, @selector(savePath));
}
 
%new
- (void)setIndex:(NSNumber *)value {
    objc_setAssociatedObject(self, @selector(savePath), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%end

%hook BMPlayerViewController

static Quality videoQuality;
static NSUInteger countFiles;

static NSArray *bmp_arrayOfURLSInDescendingQualityFromURL(NSURL *masterURL){
    M3U8MasterPlaylist *masterPlaylist = [[M3U8MasterPlaylist alloc] initWithContentOfURL:masterURL error:nil];

    M3U8ExtXStreamInfList *streamList = masterPlaylist.xStreamList;
    [streamList sortByBandwidthInOrder:NSOrderedDescending];
    NSURL *streamURL;
    streamURL = [[streamList extXStreamInfAtIndex:videoQuality] m3u8URL];
    M3U8MediaPlaylist *playList = [[M3U8MediaPlaylist alloc] initWithContentOfURL:streamURL error:nil];
    M3U8SegmentInfoList *segments = [playList segmentList];

    NSMutableArray *mediaURLS = [NSMutableArray array];
    for (int i = 0; i < segments.count; ++i)
    {
        M3U8SegmentInfo *segment = [segments segmentInfoAtIndex:i];
        NSURL *url = segment.mediaURL;
        if (url)
        {
            [mediaURLS addObject:url];
        }
    }

    return mediaURLS;
}

static NSString *directoryForStack(BMStackModel *stack){
    return [NSString stringWithFormat:@"%li", (long)[stack identifier]];
}

static void saveFilesWithStack(NSArray *urlArray, BMStackModel *stack){
    countFiles = 0;
    NSString *basePath = [NSTemporaryDirectory() stringByAppendingPathComponent: directoryForStack(stack)];
    [[NSFileManager defaultManager] createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil]; 
    NSMutableArray *savedPaths = [NSMutableArray array];

    NSMutableArray *mutableOperations = [NSMutableArray array];

    for (NSURL* currentURL in urlArray)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:currentURL];
        NSInteger index = [urlArray indexOfObject:currentURL];

        BMPHTTPRequestOperation *operation = [[%c(BMPHTTPRequestOperation) alloc] initWithRequest:request];
        __weak BMPHTTPRequestOperation *weakOperation = operation;
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *filename = [operation.response suggestedFilename];
            NSString *savePath = [basePath stringByAppendingPathComponent:filename];
            // NSLog(@"Savepath: %@", savePath);
            [responseObject writeToFile:savePath  atomically:YES];
            // NSLog(@"Downloaded: %@", filename);
            [savedPaths addObject:filename];
            [weakOperation setSavePath:savePath];
            [weakOperation setIndex:@(index)];
            countFiles++;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

        [mutableOperations addObject:operation];
    }

    NSArray *operations = [%c(AFURLConnectionOperation) batchOfRequestOperations:mutableOperations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        NSLog(@"%lu of %lu complete", (unsigned long)numberOfFinishedOperations, (unsigned long)totalNumberOfOperations);
    } completionBlock:^(NSArray *operations) {
        NSLog(@"All downloads are complete.");
        NSMutableArray *savePaths = [NSMutableArray array];
        for (BMPHTTPRequestOperation *op in operations){
            [savePaths addObject:op.savePath];
            // NSLog(@"%@\t\t%li", op.savePath, (long int)[[op index] intValue]);
        }
        bmp_convertVideoAtPath(savePaths, stack);
    }];

    NSOperationQueue *downloadQueue = [[NSOperationQueue alloc] init];
    downloadQueue.name = @"Download Queue";
    downloadQueue.maxConcurrentOperationCount = 4;
    [downloadQueue addOperations:operations waitUntilFinished:NO];
}

static void bmp_convertVideoAtPath(NSArray *fileNames, BMStackModel *stack)
{
    HBLogDebug(@"Start generating task");
    HBLogDebug(@"fileNames: %@", fileNames);
    NSString *filesConcat = [fileNames componentsJoinedByString: @"|"];
    NSString *basePath = [NSTemporaryDirectory() stringByAppendingPathComponent: directoryForStack(stack)];
    NSTask *task = [[NSTask alloc] init];
    NSArray *arguments = [[NSArray alloc] initWithObjects:@"-i", [NSString stringWithFormat:@"\"concat:%@\"", filesConcat] , @"-acodec", @"copy", @"-vcodec", @"copy", @"name.mov", nil];
    HBLogDebug(@"Arguments : %@ \n basePath : %@", arguments, basePath);
    [task setLaunchPath: @"/usr/bin/ffmpeg"];
    [task setCurrentDirectoryPath: basePath];
    [task setArguments: arguments];
    [task launch];
    HBLogDebug(@"Done");
}

/**
 * Whether or not playback should end and close the player view controller. This allows users to "tap to play" rather than tap and hold.
 * Obtain a reference to the last URL of the M3U8 playlist.
 * 
 * - nin9tyfour
 */
static BOOL shouldEndPlayback;
static UIToolbar *toolBar;


- (void)viewDidLoad{
    %orig;
    shouldEndPlayback = NO;
    videoQuality = high;
    [self bmp_setupOverlayControls];


    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bmp_tapped)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // UIToolBar and it's buttons are subclasses of UIControl
    NSLog(@"TOUCH! %@", touch.view);
    if ([touch.view isDescendantOfView:toolBar]) {
        NSLog(@"IS A DESCENDANT!");
        return NO;
    }
    return YES;
}

%new
- (void)bmp_setupOverlayControls{
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.translatesAutoresizingMaskIntoConstraints = NO;

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(bmp_saveTapped)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *button2=[[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(bmp_closeTapped)];

    [toolBar setItems:@[saveButton, flex, button2]];
    [self.view addSubview:toolBar];

    NSDictionary *dict = NSDictionaryOfVariableBindings(toolBar);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:[toolBar]|" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[toolBar]|" options:0 metrics:nil views:dict]];
    toolBar.alpha = 0;
}

/**
 * Shows overlay, will hopefully include options to save, replay, etc.
 * 
 * - nin9tyfour
 */
%new
- (void)bmp_toggleOverlayControls{
    [UIView animateWithDuration:0.3 animations:^{
        toolBar.alpha = toolBar.alpha ? 0.0f : 1.0f;
    } completion:nil];
}

%new
- (NSURL *)bmp_currentURL{
    return [self stack].streamURL;
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
- (void)bmp_tapped{
    [self bmp_toggleOverlayControls];
}

%new
- (void)bmp_closeTapped{
    shouldEndPlayback = YES;
    [self onNoLongerTouching];
}

%new
- (void)bmp_saveTapped{
    NSArray *urlArray = bmp_arrayOfURLSInDescendingQualityFromURL(self.bmp_currentURL);
    saveFilesWithStack(urlArray, self.stack);
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
    [self bmp_toggleOverlayControls];
    if (shouldEndPlayback){
        %orig;
    }
}

%end


%group TapToOpen
%hook BMFeedViewController

/**
 * Used to obtain a reference to feed view controller easily, using cycript.
 */
// - (void)viewDidLoad{
//     %orig;
//     feedVC = self;
// }
// static id feedVC;
// %new
// + (id)sharedInstance{
//     return feedVC;
// }

%new
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BMFeedCell *cell = (BMFeedCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self playVideoFromCellAtIndexPath:indexPath];
    [cell setHighlighted:YES animated:false];
}

%end

%hook BMHoldToWatchView

- (void)flashHoldAnimation{
    
}

%end

%end

static BOOL afnetworkingapi_supported(void){
    /**
     * It is useful to check if the AFNetworking API is still current/useful,
     * will prevent any crashes if they switch away from it.
     */
    return (%c(AFHTTPRequestOperation) &&
        [%c(AFHTTPRequestOperation) instancesRespondToSelector:@selector(setCompletionBlockWithSuccess:failure:)] &&
        %c(AFURLConnectionOperation) &&
        [%c(AFURLConnectionOperation) respondsToSelector:@selector(batchOfRequestOperations:progressBlock:completionBlock:)]
        );
}

static BOOL version_supported(void){
    return afnetworkingapi_supported();
}

%group UnsupportedVersionHooks

%hook BMFeedViewController

- (void)viewDidLoad{
    %orig;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Information"
        message: @"BemePlus is not currently supported on this application version."
        delegate: nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    [alert show];
}

%end

%end

%ctor{
    if (version_supported() == NO)
    {
        %init(UnsupportedVersionHooks);
    }else{
        %init();
        %init(TapToOpen);
    }
}