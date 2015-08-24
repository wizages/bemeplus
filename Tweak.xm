#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>
//#import <Spex/Spex.h>
#include "NSTask.h"
#include "BMFeedViewController.h"
#import "Headers.h"
#import "BMPAlertHandler.h"
#import "BMPResourceManager.h"

static void bmp_convertVideoAtPath(NSArray *fileNames, BMStackModel *stack);
static BOOL ffmpeg_installed(void);

static NSOperationQueue *downloadQueue;
static NSNumber *userID;

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
    return objc_getAssociatedObject(self, @selector(index));
}
 
%new
- (void)setIndex:(NSNumber *)value {
    objc_setAssociatedObject(self, @selector(index), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    streamURL = [[streamList extXStreamInfAtIndex:videoQuality] m3u8URL]; //Sets the video quality!
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
    if (ffmpeg_installed() == NO)
    {
        return;
    }
    countFiles = 0;
    NSString *basePath = [NSTemporaryDirectory() stringByAppendingPathComponent: directoryForStack(stack)];
    [[NSFileManager defaultManager] createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil]; 
    NSMutableArray *savedPaths = [NSMutableArray array];

    NSMutableArray *mutableOperations = [NSMutableArray array];
    [sharedAlertController prepareForProgress];
    for (NSURL* currentURL in urlArray)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:currentURL];
        NSInteger index = [urlArray indexOfObject:currentURL];

        BMPHTTPRequestOperation *operation = [[%c(BMPHTTPRequestOperation) alloc] initWithRequest:request];
        __weak BMPHTTPRequestOperation *weakOperation = operation;
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *filename = [operation.response suggestedFilename];
            NSString *savePath = [basePath stringByAppendingPathComponent:filename];
            [responseObject writeToFile:savePath  atomically:YES];
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
        // NSLog(@"%lu of %lu complete", (unsigned long)numberOfFinishedOperations, (unsigned long)totalNumberOfOperations);

        [sharedAlertController setHUDMessage:[NSString stringWithFormat:@"%li/%li", (long)numberOfFinishedOperations, (long)totalNumberOfOperations]];
        float progress = (float)numberOfFinishedOperations/(float)totalNumberOfOperations;
        [sharedAlertController setHUDProgress:progress];
    } completionBlock:^(NSArray *operations) {
        NSLog(@"All downloads are complete.");
        NSMutableArray *savePaths = [NSMutableArray array];
        for (BMPHTTPRequestOperation *op in operations){
            [savePaths addObject:op.savePath.lastPathComponent];
            // NSLog(@"%@\t\t%li", op.savePath, (long int)[[op index] intValue]);
        }
        [sharedAlertController prepareForIndeterminate];
        [sharedAlertController setHUDTitle:@"Saving"];
        [sharedAlertController setHUDMessage:@"Remuxing"];
        bmp_convertVideoAtPath(savePaths, stack);
    }];

    downloadQueue = [[NSOperationQueue alloc] init];
    downloadQueue.name = @"Download Queue";
    downloadQueue.maxConcurrentOperationCount = 3;
    [downloadQueue addOperations:operations waitUntilFinished:NO];
}


static NSString *ffmpegPath = @"/usr/bin/ffmpeg";

static BOOL ffmpeg_installed(void){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:ffmpegPath isDirectory:NULL])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Information"
            message: @"ffmpeg is required in order to save videos."
            delegate: nil
            cancelButtonTitle:@"Cancel"
            otherButtonTitles:@"Install ffmpeg", nil];
        alert.tag = BMPAlertTypeFFMpeg;
        alert.delegate = [BMPAlertHandler sharedInstance];
        [alert show];
        return NO;
    }
    return YES;
}

static void bmp_convertVideoAtPath(NSArray *fileNames, BMStackModel *stack)
{
    NSLog(@"Start converting.");
    static NSString *outputName = @"converted.mov";

    NSString *basePath = [NSTemporaryDirectory() stringByAppendingPathComponent: directoryForStack(stack)];
    NSString *filesConcat = [fileNames componentsJoinedByString: @"|"];
    NSArray *arguments = [[NSArray alloc] initWithObjects:@"-i", [NSString stringWithFormat:@"concat:%@", filesConcat] , @"-acodec", @"copy", @"-vcodec", @"copy", @"-max_alloc", @"50000000", outputName, @"-n", nil];

    NSPipe *error = [NSPipe pipe];
    NSFileHandle *errorFileHandle = [error fileHandleForReading];

    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: ffmpegPath];
    [task setCurrentDirectoryPath: basePath];
    [task setArguments: arguments];
    [task setStandardError:error];

    [task launch];
    [task waitUntilExit];

    NSData *errorOutput = [errorFileHandle readDataToEndOfFile];
    NSString *errorStringOutput = [[NSString alloc] initWithData:errorOutput encoding:NSUTF8StringEncoding];
    NSLog(@"Output: %@", errorStringOutput);

    if ([errorStringOutput rangeOfString:@"Cannot allocate memory"].location != NSNotFound)
    {
        NSLog(@"Not enough memory allocated to convert. TODO: Prompt user to adjust memory allocation settings, or adjust for this case and retry command.");
    }

    NSLog(@"Done");
    [sharedAlertController setHUDMessage:@"Importing"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *outputPath = [basePath stringByAppendingPathComponent:outputName];
    if ([fileManager fileExistsAtPath:outputPath  isDirectory:NULL])
    {
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (outputPath))
        {
           UISaveVideoAtPathToSavedPhotosAlbum (outputPath, [BMPAlertHandler sharedInstance], @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }else{
        NSLog(@"The file does not exist :/");
    }
}

/**
 * Whether or not playback should end and close the player view controller. This allows users to "tap to play" rather than tap and hold.
 * Obtain a reference to the last URL of the M3U8 playlist.
 * 
 * - nin9tyfour
 */
static BOOL shouldEndPlayback;
static UIToolbar *nowPlayingOverlayToolbar;
static UIButton *watched;
static UIButton *download;
static UIButton *return_button;
static UIButton *replay_button;
static BOOL hidden_bar;
static NSURL *current_url;


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

- (void)playURL:(NSURL *)url{
    %orig;
    current_url = url;
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:nowPlayingOverlayToolbar]) {
        return NO;
    }
    return YES;
}

%new
- (void)bmp_setupOverlayControls{
    nowPlayingOverlayToolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    nowPlayingOverlayToolbar.translatesAutoresizingMaskIntoConstraints = NO;

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(bmp_saveTapped:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *button2=[[UIBarButtonItem alloc] initWithImage:[BMPResourceManager resourceImageNamed:@"Watched"] style:UIBarButtonItemStylePlain target:self action:@selector(bmp_closeTapped:)];

    [nowPlayingOverlayToolbar setItems:@[saveButton, flex, button2]];
    //[self.view addSubview:nowPlayingOverlayToolbar];

    //NSDictionary *dict = NSDictionaryOfVariableBindings(nowPlayingOverlayToolbar);
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:[nowPlayingOverlayToolbar]|" options:0 metrics:nil views:dict]];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[nowPlayingOverlayToolbar]|" options:0 metrics:nil views:dict]];
    //nowPlayingOverlayToolbar.alpha = 0;
    CGRect frame = self.view.frame;

    watched = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *watched_logo = [[BMPResourceManager resourceImageNamed:@"Watched"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    watched.frame = CGRectMake(80, CGRectGetMaxY(frame), 80, 80);
    [watched addTarget:self action:@selector(bmp_closeTapped:) forControlEvents:UIControlEventTouchUpInside];
    [watched setImage:watched_logo forState:UIControlStateNormal];
    watched.tintColor = [UIColor whiteColor];

    download = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *download_logo = [[BMPResourceManager resourceImageNamed:@"Download"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    download.frame = CGRectMake(CGRectGetMaxX(frame)-80, CGRectGetMaxY(frame), 80, 80);
    [download addTarget:self action:@selector(bmp_saveTapped:) forControlEvents:UIControlEventTouchUpInside];
    [download setImage:download_logo forState:UIControlStateNormal];
    download.tintColor = [UIColor whiteColor];

    return_button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *return_logo = [[BMPResourceManager resourceImageNamed:@"Return"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return_button.frame = CGRectMake(0 , CGRectGetMaxY(frame), 80, 80);
    [return_button addTarget:self action:@selector(bmp_returnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [return_button setImage:return_logo forState:UIControlStateNormal];
    return_button.tintColor = [UIColor whiteColor];

    replay_button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *replay_logo = [[BMPResourceManager resourceImageNamed:@"Return"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    replay_button.frame = CGRectMake(160 , CGRectGetMaxY(frame), 80, 80);
    [replay_button addTarget:self action:@selector(bmp_replayTapped:) forControlEvents:UIControlEventTouchUpInside];
    [replay_button setImage:replay_logo forState:UIControlStateNormal];
    replay_button.tintColor = [UIColor whiteColor];

    hidden_bar = false;
    [self.view addSubview:return_button];
    [self.view addSubview:download];
    [self.view addSubview:watched];
    [self.view addSubview:replay_button];
}

/**
 * Shows overlay, will hopefully include options to save, replay, etc.
 * 
 * - nin9tyfour
 */
%new
- (void)bmp_toggleOverlayControls{
    CGRect frame = self.view.frame;
if (hidden_bar){

    [UIView animateWithDuration:0.3 animations:^{
        download.frame = CGRectMake(CGRectGetMaxX(frame)-80, CGRectGetMaxY(frame)-80, 80, 80);
        watched.frame = CGRectMake(80, CGRectGetMaxY(frame) - 80, 80, 80);
        return_button.frame = CGRectMake(0 , CGRectGetMaxY(frame) - 80, 80, 80);
        replay_button.frame = CGRectMake(160 , CGRectGetMaxY(frame) - 80, 80, 80);
    } completion:nil];
    hidden_bar = false;
}
else{

    [UIView animateWithDuration:0.3 animations:^{
        download.frame = CGRectMake(CGRectGetMaxX(frame)-80, CGRectGetMaxY(frame), 80, 80);
        watched.frame = CGRectMake(80, CGRectGetMaxY(frame), 80, 80);
        return_button.frame = CGRectMake(0 , CGRectGetMaxY(frame), 80, 80);
        replay_button.frame = CGRectMake(160 , CGRectGetMaxY(frame), 80, 80);
    } completion:nil];
    hidden_bar = true;
}
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
- (void)bmp_closeTapped:(UIButton *)button{
    [downloadQueue cancelAllOperations];
    shouldEndPlayback = YES;
    [self onNoLongerTouching];
}

%new
-(void)bmp_returnTapped:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

%new
- (void)bmp_saveTapped:(UIButton *)button{
    NSArray *urlArray = bmp_arrayOfURLSInDescendingQualityFromURL(self.bmp_currentURL);
    [sharedAlertController createProgressHUDInView:self.view title:@"Downloading" message:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        saveFilesWithStack(urlArray, self.stack);
    });
}

%new
-(void)bmp_replayTapped:(UIButton *)button{
    [self playURL:current_url];
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
    hidden_bar = true;
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
    //BMFeedCell *cell = (BMFeedCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self playVideoFromCellAtIndexPath:indexPath];
    //[cell setHighlighted:YES animated:false];
    //Causes issues when the using the return fuction
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

%hook BMFeedViewController

%new
- (void)bmp_createNewUpload:(UIBarButtonItem *)buttonItem{
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
       imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
       imagePickerController.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
       imagePickerController.delegate = self;
       imagePickerController.allowsEditing = YES; //if you want to edit the image
       [self presentViewController:imagePickerController animated:YES completion:nil];
}

%new
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion: NULL];
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    //Generating upload blob
    BMClip *videoUpload = [[%c(BMClip) alloc] init];
    BMDockManager *dock = [[%c(BMDockManager) alloc] init];
    [dock activate];
    videoUpload.userIdentifier = userID;
    videoUpload.recordedAt = [[NSDate alloc] init];
    videoUpload.localFilename = [NSString stringWithFormat:@"../../../tmp/%@", [videoURL lastPathComponent]];
    [dock publishClip:videoUpload];
}
%new
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion: NULL];
}

%new
- (void)bmp_openSavedVault:(UIBarButtonItem *)buttonItem{
    [BMPAlertHandler showAlertWithTitle:@"Information" message:@"Not implemented yet!"];
}

%new
- (void)bmp_setupToolbar{
    UIToolbar *toolbar = self.navigationController.toolbar;

    /**
     * This is a private method, but it prevents touches in the toolbar from going through to the cells below it.
     *
     * Reason: perhaps there is a gesture window that is present that is intercepting touches and applying them to the
     * cell at the touch location, maybe?
     *
     * - nin9tyfour
     */
    toolbar.deliversTouchesForGesturesToSuperview = NO;

    self.navigationController.toolbarHidden = NO;
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += toolbar.frame.size.height;
    self.tableView.contentInset = insets;
    toolbar.tintColor = [UIColor beme_greenColor];

    if (toolbar.items)
    {
        return;
    }

    toolbar.barTintColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1];
    toolbar.backgroundColor = toolbar.barTintColor;
    toolbar.translucent = NO;

    UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithImage:[BMPResourceManager resourceImageNamed:@"Upload"] style:UIBarButtonItemStylePlain target:self action:@selector(bmp_createNewUpload:)];
    UIBarButtonItem *vaultButton = [[UIBarButtonItem alloc] initWithImage:[BMPResourceManager resourceImageNamed:@"Vault"] style:UIBarButtonItemStylePlain target:self action:@selector(bmp_openSavedVault:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];

    toolbar.items = @[vaultButton, flex, uploadButton];
}

%new
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:nowPlayingOverlayToolbar]) {
        return NO;
    }
    return NO;
}

%group TB_ViewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    //First things first get the users id.
    BMCurrentUser *user = [[%c(BMCurrentUser) alloc] init];
    userID = user.identifier;

    %orig;
    [self bmp_setupToolbar];
}
%end
%group TB_NewViewDidAppear
%new
- (void)viewDidAppear:(BOOL)animated{
    [self bmp_setupToolbar];
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
        if ([%c(BMFeedViewController) instancesRespondToSelector:@selector(viewDidAppear:)])
        {
            %init(TB_ViewDidAppear)
        }else{
            %init(TB_NewViewDidAppear);
        }
    }
}