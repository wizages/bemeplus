//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MTLModel.h"

#import "MTLJSONSerializing.h"

@class BMUserModel, NSDate, NSNumber, NSString, NSURL;

@interface BMReactionItemModel : MTLModel <MTLJSONSerializing>
{
    NSDate *_createdAt;
    NSNumber *_identifier;
    NSNumber *_clipIdentifier;
    NSString *_location;
    NSURL *_reactionImage;
    NSURL *_videoStillImage;
    BMUserModel *_sender;
}

+ (id)senderJSONTransformer;
+ (id)videoStillImageJSONTransformer;
+ (id)reactionImageJSONTransformer;
+ (id)createdAtJSONTransformer;
+ (id)JSONKeyPathsByPropertyKey;
@property(readonly, nonatomic) BMUserModel *sender; // @synthesize sender=_sender;
@property(readonly, copy, nonatomic) NSURL *videoStillImage; // @synthesize videoStillImage=_videoStillImage;
@property(readonly, copy, nonatomic) NSURL *reactionImage; // @synthesize reactionImage=_reactionImage;
@property(readonly, copy, nonatomic) NSString *location; // @synthesize location=_location;
@property(readonly, copy, nonatomic) NSNumber *clipIdentifier; // @synthesize clipIdentifier=_clipIdentifier;
@property(readonly, copy, nonatomic) NSNumber *identifier; // @synthesize identifier=_identifier;
@property(readonly, copy, nonatomic) NSDate *createdAt; // @synthesize createdAt=_createdAt;
- (void).cxx_destruct;

@end

