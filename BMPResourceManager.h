@interface BMPResourceManager : NSObject
+ (NSString *)resourcePathForImageNamed:(NSString *)name;
+ (UIImage *)resourceImageNamed:(NSString *)name;
@end