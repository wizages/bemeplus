// Since we've got an additional include directory defined, we can import psuedo-locally.
// Local in the fact that the files are constrained to the tweak base directory, but they're
// not imported as most local headers would be.
#import <CoreGraphics/CoreGraphics.h>
#import <M3U8/M3U8.h>
#import "LoggingMacros.h"
#import <JGProgressHUD/JGProgressHUD.h>
#import "BMPResourceManager.h"



typedef enum {high, medium, low} Quality;

@interface BMClip : NSObject
@property(copy, nonatomic) NSURL *remoteURL; // @synthesize remoteURL=_remoteURL;
@property(copy, nonatomic) NSString *localIdentifier; // @synthesize localIdentifier=_localIdentifier;
@property(copy, nonatomic) NSString *localFilename; // @synthesize localFilename=_localFilename;
@property(copy, nonatomic) NSNumber *userIdentifier; // @synthesize userIdentifier=_userIdentifier;
@property(copy, nonatomic) NSDate *uploadURLExpirey; // @synthesize uploadURLExpirey=_uploadURLExpirey;
@property(copy, nonatomic) NSString *uploadURL; // @synthesize uploadURL=_uploadURL;
@property(copy, nonatomic) NSString *uploadToken; // @synthesize uploadToken=_uploadToken;
@property(nonatomic) unsigned long long state; // @synthesize state=_state;
@property(copy, nonatomic) NSDate *postedAt; // @synthesize postedAt=_postedAt;
@property(readonly, copy, nonatomic) NSNumber *longitude; // @synthesize longitude=_longitude;
@property(readonly, copy, nonatomic) NSNumber *latitude; // @synthesize latitude=_latitude;
@property(copy, nonatomic) NSDate *recordedAt; // @synthesize recordedAt=_recordedAt;
@property(copy, nonatomic) NSString *identifier; // @synthesize identifier=_identifier;
@end

@interface BMDockManager : NSObject
+ (int)publishClip2:(BMClip *)arg1;
- (int)publishClip:(BMClip *)arg1;
- (void)activate;
@end

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

@interface UIColor (BeMe)
+ (id)beme_greenColor;
+ (id)beme_blueColor;
+ (id)beme_dark_redColor;
+ (id)beme_redColor;
+ (id)beme_progressColor;
+ (id)beme_darkGray;
+ (id)beme_lightGray;
+ (id)beme_darkerBackgroundColor;
+ (id)beme_RGB929292Color;
+ (id)beme_RGB70greycolor;
+ (id)beme_RGB878787Color;
+ (id)beme_RGB646464Color;
+ (id)beme_RGB454545Color;
+ (id)beme_RGB10GreyColor;
+ (id)beme_RGB363636Color;
+ (id)beme_RGB222222Color;
+ (id)beme_RGB202020Color;
+ (id)beme_darkBackgroundColor;
+ (id)beme_backgroundColor;
@end

@interface UIView (BMP_Private)
@property (assign,nonatomic) BOOL deliversTouchesForGesturesToSuperview;
@end