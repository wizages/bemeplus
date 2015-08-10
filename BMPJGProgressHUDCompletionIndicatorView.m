#import "BMPJGProgressHUDCompletionIndicatorView.h"

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
    NSBundle *resourceBundle = [NSBundle bundleWithPath:@"/Library/Application Support/BemePlus/BemePlus.bundle"];
    
    NSString *imgPath = [resourceBundle pathForResource:[self resourceNameFromType:type] ofType:@"png"];
    
    self = [super initWithImage:[UIImage imageWithContentsOfFile:imgPath]];
    
    return self;
}

- (instancetype)initWithType:(BMPCompletionType)type{
    return [self initWithContentView:nil type:type];
}

- (void)updateAccessibility {
    self.accessibilityLabel = NSLocalizedString(@"Success",);
}

@end