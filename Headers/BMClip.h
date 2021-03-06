//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MTLModel.h"

#import "BMClipProtocol.h"
#import "MTLJSONSerializing.h"

@class NSDate, NSNumber, NSString, NSURL;

@interface BMClip : MTLModel <MTLJSONSerializing, BMClipProtocol>
{
    NSString *_identifier;
    NSDate *_recordedAt;
    NSNumber *_latitude;
    NSNumber *_longitude;
    NSDate *_postedAt;
    unsigned long long _state;
    NSString *_uploadToken;
    NSString *_uploadURL;
    NSDate *_uploadURLExpirey;
    NSNumber *_userIdentifier;
    NSString *_localFilename;
    NSString *_localIdentifier;
    NSURL *_remoteURL;
}

+ (id)stateJSONTransformer;
+ (id)uploadURLExpireyJSONTransformer;
+ (id)recordedAtJSONTransformer;
+ (id)postedAtJSONTransformer;
+ (id)JSONKeyPathsByPropertyKey;
+ (id)dateFormatter;
@property(copy, nonatomic) NSURL *remoteURL; // @synthesize remoteURL=_remoteURL;
@property(copy, nonatomic) NSString *localIdentifier; // @synthesize localIdentifier=_localIdentifier;
@property(copy, nonatomic) NSString *localFilename; // @synthesize localFilename=_localFilename;
@property(copy, nonatomic) NSNumber *userIdentifier; // @synthesize userIdentifier=_userIdentifier;
@property(copy, nonatomic) NSDate *uploadURLExpirey; // @synthesize uploadURLExpirey=_uploadURLExpirey;
@property(copy, nonatomic) NSString *uploadURL; // @synthesize uploadURL=_uploadURL;
@property(copy, nonatomic) NSString *uploadToken; // @synthesize uploadToken=_uploadToken;
@property(nonatomic) unsigned long long state; // @synthesize state=_state;
@property(copy, nonatomic) NSDate *postedAt; // @synthesize postedAt=_postedAt;
@property(readonly, copy, nonatomic) NSNumber *longitude; // @synthesize longitude=_longitude;
@property(readonly, copy, nonatomic) NSNumber *latitude; // @synthesize latitude=_latitude;
@property(copy, nonatomic) NSDate *recordedAt; // @synthesize recordedAt=_recordedAt;
@property(copy, nonatomic) NSString *identifier; // @synthesize identifier=_identifier;
- (void).cxx_destruct;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

