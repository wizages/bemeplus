#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//#import <Spex/Spex.h>
#include "NSTask.h"
#include "BMFeedViewController.h"
#include "TSInfo.h"
#import "Headers.h"


%hook BMFeedViewController

-(BMStackModel *) currentPlayingStack {
    NSArray *m3u8Data; //contents of m3u8
    NSMutableArray *tsArray;
    NSData *urlData; //actual data of m3u8 file or ts file
    int count; //count for the for loop
    NSString *directoryUrl; //file location url
    NSString *downloadUrlString; //m3u8 download url string
    NSString *tsDownloadUrlString; //ts download url string
    NSURL *downloadUrl; //m3u8 download url
    BMUserModel *userInfo;
    Quality videoQuality;
    TSInfo *tsInfo;
    %orig;

    /*
    Initialize variables;
    */
    tsArray = [[NSMutableArray alloc] init];
    downloadUrl = %orig.streamURL;
    userInfo = %orig.user;
    downloadUrlString = [downloadUrl absoluteString];
    videoQuality = high;

    /*
    Here we changed the letter from A-C depending on what quality type we want. A being lowest and C being highest
    */
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
        */
        HBLogDebug(@"tsArray contains: %@", tsArray);
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
                    [urlData writeToFile:directoryUrl atomically:YES];
                    [self convertVideo:tsInfo.fileName];
                    //[[NSFileManager defaultManager] removeItemAtPath:directoryUrl error:NULL]; //Clean up the .ts file you dont need it no more
                }
            }
        }
    }
    return %orig;
}

/*
* This is a new fuction that will convert the video from .ts to .mov
*/
%new(v@:?)
-(void)convertVideo: (NSString *) fileName
{
        HBLogDebug(@"Start generating task");
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/bin/ffmpeg"];
    [task setCurrentDirectoryPath: NSTemporaryDirectory()];
    [task setArguments: [[NSArray alloc] initWithObjects:@"-i", [NSString stringWithFormat:@"%@.ts", fileName] , @"-acodec", @"copy", @"-vcodec", @"copy", [NSString stringWithFormat:@"%@.mov", fileName], nil]];
    [task launch];
    HBLogDebug(@"Done");
}

/*
* This is a new fuction that will import the new .mov video to
* the photo album and then delete the tmp file. Later we can
* also create a phantom like vault.
*/
%new(v@:?)
-(void) importToPhotoAlbum: (NSString *) fileName
{
    //To be added soon!
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
     %orig;
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
    %orig;
}

%end