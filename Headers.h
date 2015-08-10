// Since we've got an additional include directory defined, we can import psuedo-locally.
// Local in the fact that the files are constrained to the tweak base directory, but they're
// not imported as most local headers would be.
#import <CoreGraphics/CoreGraphics.h>
#import <M3U8/M3U8.h>
#import "LoggingMacros.h"
#import <JGProgressHUD/JGProgressHUD.h>


typedef enum {high, medium, low} Quality;
@class BMStackModel;

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

@interface BMFeedCell : UITableViewCell
- (void)setHighlighted:(_Bool)arg1 animated:(_Bool)arg2;
- (void)press:(_Bool)arg1;
@end

@interface AFURLConnectionOperation : NSOperation
+ (NSArray *)batchOfRequestOperations:(NSArray *)operations
                        progressBlock:(void (^)(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations))progressBlock
                      completionBlock:(void (^)(NSArray *operations))completionBlock;
@end

@interface BMPHTTPRequestOperation : AFHTTPRequestOperation
@property (nonatomic, strong) NSString *savePath;
@property (nonatomic, strong) NSNumber *index;
- (NSString *)savePath;
- (void)setSavePath:(NSString *)value;
@end