//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MTLModel.h"

#import "MTLJSONSerializing.h"

@class NSDate, NSString;

@interface BMUploadURLModel : MTLModel <MTLJSONSerializing>
{
    NSString *_reactionImage;
    NSDate *_reactionImageExpiration;
    NSString *_videoStillImage;
    NSString *_videoStillExpiration;
}

+ (id)videoStillExpirationJSONTransformer;
+ (id)reactionImageExpirationJSONTransformer;
+ (id)JSONKeyPathsByPropertyKey;
@property(copy, nonatomic) NSString *videoStillExpiration; // @synthesize videoStillExpiration=_videoStillExpiration;
@property(copy, nonatomic) NSString *videoStillImage; // @synthesize videoStillImage=_videoStillImage;
@property(copy, nonatomic) NSDate *reactionImageExpiration; // @synthesize reactionImageExpiration=_reactionImageExpiration;
@property(copy, nonatomic) NSString *reactionImage; // @synthesize reactionImage=_reactionImage;
- (void).cxx_destruct;

@end
