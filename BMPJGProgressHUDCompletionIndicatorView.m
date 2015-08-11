#import "BMPJGProgressHUDCompletionIndicatorView.h"
#import "BMPResourceManager.h"

@implementation BMPJGProgressHUDCompletionIndicatorView

- (NSString *)resourceNameFromType:(BMPCompletionType)type{
	switch (type){
		case BMPCompletionTypeSuccess:
			return @"jg_hud_success";
		case BMPCompletionTypeFailure:
			return @"jg_hud_error";
	}
	return @"jg_hud_success";
}

- (instancetype)initWithContentView:(UIView *__unused)contentView type:(BMPCompletionType)type{
    UIImage *image = [BMPResourceManager resourceImageNamed:[self resourceNameFromType:type]];
    
    self = [super initWithImage:image];
    
    return self;
}

- (instancetype)initWithType:(BMPCompletionType)type{
    return [self initWithContentView:nil type:type];
}

- (void)updateAccessibility {
    self.accessibilityLabel = NSLocalizedString(@"Success",);
}

@end