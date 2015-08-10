typedef enum{
	BMPAlertTypeVersion,
	BMPAlertTypeFFMpeg
} BMPAlertType;

@interface BMPAlertHandler : NSObject <UIAlertViewDelegate>
#define sharedAlertController [BMPAlertHandler sharedInstance]
+ (instancetype)sharedInstance;

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

- (void)createProgressHUDInView:(UIView *)view title:(NSString *)title message:(NSString *)message;
- (void)setHUDMessage:(NSString *)message;
- (void)setHUDTitle:(NSString *)title;
- (void)setHUDProgress:(CGFloat)progress;

- (void)prepareForProgress;
- (void)prepareForIndeterminate;

- (void)hideHUD;
@end