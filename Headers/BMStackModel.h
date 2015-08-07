//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MTLModel.h"

#import "MTLJSONSerializing.h"

@class BMUserModel, NSDate, NSNumber, NSString, NSURL;

@interface BMStackModel : MTLModel <MTLJSONSerializing>
{
    NSDate *_createdAt;
    NSNumber *_identifier;
    NSNumber *_lastClipIdentifier;
    NSString *_location;
    NSURL *_streamURL;
    NSURL *_oldStreamURL;
    BMUserModel *_user;
    NSNumber *_userIdentifier;
    NSString *_verb;
    NSNumber *_isWatched;
}

+ (id)userJSONTransformer;
+ (id)aStreamURLJSONTransformer;
+ (id)oldStreamURLJSONTransformer;
+ (id)streamURLJSONTransformer;
+ (id)createdAtJSONTransformer;
+ (id)JSONKeyPathsByPropertyKey;
@property(copy, nonatomic) NSNumber *isWatched; // @synthesize isWatched=_isWatched;
@property(readonly, copy, nonatomic) NSString *verb; // @synthesize verb=_verb;
@property(readonly, copy, nonatomic) NSNumber *userIdentifier; // @synthesize userIdentifier=_userIdentifier;
@property(readonly, nonatomic) BMUserModel *user; // @synthesize user=_user;
@property(readonly, copy, nonatomic) NSURL *oldStreamURL; // @synthesize oldStreamURL=_oldStreamURL;
@property(readonly, copy, nonatomic) NSURL *streamURL; // @synthesize streamURL=_streamURL;
@property(readonly, copy, nonatomic) NSString *location; // @synthesize location=_location;
@property(readonly, copy, nonatomic) NSNumber *lastClipIdentifier; // @synthesize lastClipIdentifier=_lastClipIdentifier;
@property(readonly, copy, nonatomic) NSNumber *identifier; // @synthesize identifier=_identifier;
@property(readonly, copy, nonatomic) NSDate *createdAt; // @synthesize createdAt=_createdAt;
- (void).cxx_destruct;
- (unsigned long long)hash;
- (_Bool)isEqual:(id)arg1;

@end
