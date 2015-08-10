typedef enum{
	BMPAlertTypeVersion,
	BMPAlertTypeFFMpeg
} BMPAlertType;

@interface BMPAlertHandler : NSObject <UIAlertViewDelegate>
+ (instancetype)sharedInstance;

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@end