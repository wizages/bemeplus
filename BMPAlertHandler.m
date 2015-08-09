#import "BMPAlertHandler.h"

/**
	BMPAlertTypeVersion,
	BMPAlertTypeFFMpeg
	BMPAlertType;
 */

@implementation BMPAlertHandler

+ (instancetype)sharedInstance{
	static dispatch_once_t once;
	static BMPAlertHandler *sharedInstance = nil;
	dispatch_once(&once, ^{
		sharedInstance = [[BMPAlertHandler alloc] init];
	});
	return sharedInstance;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
     
    if([title isEqualToString:@"Cancel"] || [title isEqualToString:@"OK"])
    {
        return;
    }else if(alertView.tag == BMPAlertTypeFFMpeg && [title isEqualToString:@"Install ffmpeg"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.nin9tyfour.ffmpeg"]];
    }
}

@end