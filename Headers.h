// download iOS Console: http://lemonjar.com/iosconsole/ Set search field to "[bemeplus]:"
// OR 
// # deviceconsole -p beme | grep bemeplus

// Since we've got an additional include directory defined, we can import psuedo-locally.
// Local in the fact that the files are constrained to the tweak base directory, but they're
// not imported as most local headers would be.
#import <CoreGraphics/CoreGraphics.h>
#import <M3U8/M3U8.h>

// Acheive some kind of mutual compatibility between our theos setups.
// I would use hashbang's theos but I rather not have to link substrate
// and I rather NSLog as opposed to HBLogDebug, just what I'm used to.
#ifndef HBLogDebug
#ifdef __DEBUG__
	#define HB_LOG_FORMAT(color) "\e[1;3" #color "m[%s] %s:\e[m\e[0;3" #color "m%d\e[m \e[0;30;4" #color "m%s:\e[m %s"
#else
	#define HB_LOG_FORMAT(color) "[%s: %s:%d] %s: %s"
#endif

#define HB_LOG_INTERNAL(color, level, type, ...) syslog(level, HB_LOG_FORMAT(color), THEOS_INSTANCE_NAME, __FILE__, __LINE__, type, [NSString stringWithFormat:__VA_ARGS__].UTF8String);

#ifdef __DEBUG__
	#define HBLogDebug(...) HB_LOG_INTERNAL(6, LOG_NOTICE, "DEBUG", __VA_ARGS__)
#else
	#define HBLogDebug(...)
#endif

#define HBLogInfo(...) HB_LOG_INTERNAL(2, LOG_NOTICE, "INFO", __VA_ARGS__)
#define HBLogWarn(...) HB_LOG_INTERNAL(3, LOG_WARNING, "WARN", __VA_ARGS__)
#define HBLogError(...) HB_LOG_INTERNAL(1, LOG_ERR, "ERROR", __VA_ARGS__)
#endif
#ifdef HBLogDebug
#undef NSLog
#define NSLog(fmt, ...) NSLog((@"[bemeplus]: " fmt), ##__VA_ARGS__)
#endif

@interface BMPlayerViewController : UIViewController <UIGestureRecognizerDelegate>
@property(nonatomic, weak) BMStackModel *stack;
- (void)onNoLongerTouching;
- (void)playbackDidEnd;
- (void)playURL:(NSURL *)url;
- (void)viewDidLoad;

//new
- (void)bmp_toggleOverlayControls;
- (void)bmp_replay;
- (NSArray *)bmp_arrayOfURLSInDescendingQualityFromURL:(NSURL *)masterURL;
- (void)bmp_setupOverlayControls;
- (NSURL *)bmp_currentURL;
@end

@interface BMNetworkClient : NSObject
+ (id)BMNetS3Endpoint;
+ (id)BMNetAmazonUploadBucket;
+ (id)BMNetBaseURL;
+ (NSURL *)BMNetUpdateURL;
@end

@interface AFHTTPRequestOperation : NSOperation

@property (readonly, nonatomic, strong) NSHTTPURLResponse *response;

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest NS_DESIGNATED_INITIALIZER;
- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end