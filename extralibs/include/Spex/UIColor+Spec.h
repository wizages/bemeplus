#include <UIKit/UIKit.h>
#include <CoreGraphics/CoreGraphics.h>

@interface UIColor (Spec)
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (NSString *)hexStringFromRed:(int)red green:(int)green blue:(int)blue alpha:(int)alpha useAlpha:(BOOL)useAlpha;
+ (NSString *)hexStringFromColor:(UIColor *)color useAlpha:(BOOL)useAlpha;
+ (NSString *)colorStringForColor:(UIColor *)color useAlpha:(BOOL)useAlpha;
@end