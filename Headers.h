// download iOS Console: http://lemonjar.com/iosconsole/ Set search field to "[bemeplus]:"
// OR 
// # deviceconsole -p beme | grep bemeplus
#define NSLog(fmt, ...) NSLog((@"[bemeplus]: " fmt), ##__VA_ARGS__)

@interface BMPlayerViewController : UIViewController
- (void)onNoLongerTouching;
- (void)playbackDidEnd;
- (void)playURL:(NSURL *)url;
- (void)viewDidLoad;

//new
- (void)bmp_showOverlayControls;
- (void)bmp_replay;
@end

@interface BMNetworkClient : NSObject
+ (id)BMNetS3Endpoint;
+ (id)BMNetAmazonUploadBucket;
+ (id)BMNetBaseURL;
+ (NSURL *)BMNetUpdateURL;
@end