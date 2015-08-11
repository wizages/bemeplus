#import "BMPResourceManager.h"

@implementation BMPResourceManager

NSBundle *resourceBundle(void){
    static NSBundle *resourceBundleVar = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        resourceBundleVar = [NSBundle bundleWithPath:@"/Library/Application Support/BemePlus/BemePlus.bundle"];
    });
    return resourceBundleVar;
}

+ (NSString *)resourcePathForImageNamed:(NSString *)name{
	return [resourceBundle() pathForResource:name ofType:@"png"];
}

+ (UIImage *)resourceImageNamed:(NSString *)name{
	return [UIImage imageWithContentsOfFile:[BMPResourceManager resourcePathForImageNamed:name]];
}

@end