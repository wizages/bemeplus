//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MTLModel.h"

#import "MTLJSONSerializing.h"

@class BMReactionModel;

@interface BMReactionResultModel : MTLModel <MTLJSONSerializing>
{
    BMReactionModel *_reactionModel;
}

+ (id)reactionModelJSONTransformer;
+ (id)JSONKeyPathsByPropertyKey;
@property(readonly, nonatomic) BMReactionModel *reactionModel; // @synthesize reactionModel=_reactionModel;
- (void).cxx_destruct;

@end
