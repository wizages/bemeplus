#import <Foundation/Foundation.h>

@interface TSInfo : NSObject

@property(copy, nonatomic) NSURL * tsURL;
@property(copy, nonatomic) NSString * fileName;
@property(assign, nonatomic) BOOL shouldDownload;

-(id) initWithURL: (NSString *) url;

@end