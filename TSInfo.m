#import "TSInfo.h"

@implementation TSInfo



-(id) initWithURL: (NSString *) url
{
    TSInfo *temp = [super init];
    temp.tsURL = [NSURL URLWithString:url];
    return temp;
}

@end