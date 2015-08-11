#import "BMPAlertHandler.h"
#import <JGProgressHUD/JGProgressHUD.h>
#import "BMPJGProgressHUDCompletionIndicatorView.h"

/**
	BMPAlertTypeVersion,
	BMPAlertTypeFFMpeg
	BMPAlertType;
 */

@interface BMPAlertHandler ()
@property (nonatomic, strong) JGProgressHUD *progressHUD;
@end

@implementation BMPAlertHandler

+ (instancetype)sharedInstance{
	static dispatch_once_t once;
	static BMPAlertHandler *sharedInstance = nil;
	dispatch_once(&once, ^{
		sharedInstance = [[BMPAlertHandler alloc] init];
	});
	return sharedInstance;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
     
    if([title isEqualToString:@"Cancel"] || [title isEqualToString:@"OK"])
    {
        return;
    }else if(alertView.tag == BMPAlertTypeFFMpeg && [title isEqualToString:@"Install ffmpeg"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.nin9tyfour.ffmpeg"]];
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
	[self setHUDMessage:nil];
	if (error == nil) 
	{
		[self showHUDCompletionWithSuccess];
	} 
	else 
	{
		[self showHUDCompletionWithFailure];
	}
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager removeItemAtPath:[videoPath stringByDeletingLastPathComponent] error:NULL];
	[self hideHUD];
}

- (void)createProgressHUDInView:(UIView *)view title:(NSString *)title message:(NSString *)message{
	dispatch_async(dispatch_get_main_queue(), ^{
		_progressHUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
		_progressHUD.interactionType = JGProgressHUDInteractionTypeBlockTouchesOnHUDView;
		_progressHUD.layoutChangeAnimationDuration = 0.0f;
	    [_progressHUD showInView:view];

		[self setHUDTitle:title];
		[self setHUDMessage:message];
	});
}

- (void)setHUDMessage:(NSString *)message{
	dispatch_async(dispatch_get_main_queue(), ^{
		_progressHUD.detailTextLabel.text = message;
	});
}

- (void)setHUDTitle:(NSString *)title{
	dispatch_async(dispatch_get_main_queue(), ^{
		_progressHUD.textLabel.text = title;
	});
}

- (void)prepareForProgress{
	dispatch_async(dispatch_get_main_queue(), ^{
		_progressHUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc] initWithHUDStyle:_progressHUD.style];
	});
}

- (void)prepareForIndeterminate{
	dispatch_async(dispatch_get_main_queue(), ^{
		_progressHUD.indicatorView = [[JGProgressHUDIndeterminateIndicatorView alloc] initWithHUDStyle:_progressHUD.style];
	});
}

- (void)setHUDProgress:(CGFloat)progress{
	dispatch_async(dispatch_get_main_queue(), ^{
		[_progressHUD setProgress:progress animated:YES];
	});
}

- (void)hideHUD{
	dispatch_async(dispatch_get_main_queue(), ^{
		[_progressHUD dismissAfterDelay:1.5f animated:YES];
	});
}

- (void)showHUDCompletionWithSuccess{
	_progressHUD.indicatorView = [[BMPJGProgressHUDCompletionIndicatorView alloc] initWithType:BMPCompletionTypeSuccess];
	[self setHUDTitle:@"Success"];
}

- (void)showHUDCompletionWithFailure{
	_progressHUD.indicatorView = [[BMPJGProgressHUDCompletionIndicatorView alloc] initWithType:BMPCompletionTypeFailure];
	[self setHUDTitle:@"Failed"];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
        message: message
        delegate: nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    [alert show];
}

@end