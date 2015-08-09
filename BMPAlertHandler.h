typedef enum{
	BMPAlertTypeVersion,
	BMPAlertTypeFFMpeg
} BMPAlertType;

@interface BMPAlertHandler : NSObject <UIAlertViewDelegate>
+ (instancetype)sharedInstance;
@end