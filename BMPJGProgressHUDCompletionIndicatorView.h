#import <JGProgressHUD/JGProgressHUDImageIndicatorView.h>

typedef enum{
	BMPCompletionTypeSuccess,
	BMPCompletionTypeFailure
}BMPCompletionType;

@interface BMPJGProgressHUDCompletionIndicatorView : JGProgressHUDImageIndicatorView

- (instancetype)initWithType:(BMPCompletionType)type;

@end