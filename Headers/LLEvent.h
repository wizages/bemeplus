//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class LLAnalyticsDB, NSData, NSDictionary, NSMutableDictionary, NSString;

@interface LLEvent : NSObject
{
    LLAnalyticsDB *_db;
    NSString *_libraryVersion;
    NSString *_eventString;
    NSData *_eventData;
    NSDictionary *_eventDictionary;
    NSMutableDictionary *_mutableEventHeader;
    NSDictionary *_extensionInfo;
}

+ (id)eventWithDictionary:(id)arg1 extensionInfo:(id)arg2 andLibraryVersion:(id)arg3;
+ (id)eventWithDictionary:(id)arg1 andLibraryVersion:(id)arg2;
+ (id)eventWithJsonString:(id)arg1 andLibraryVersion:(id)arg2;
@property(retain, nonatomic) NSDictionary *extensionInfo; // @synthesize extensionInfo=_extensionInfo;
@property(retain, nonatomic) NSMutableDictionary *mutableEventHeader; // @synthesize mutableEventHeader=_mutableEventHeader;
@property(retain, nonatomic) NSDictionary *eventDictionary; // @synthesize eventDictionary=_eventDictionary;
@property(retain, nonatomic) NSData *eventData; // @synthesize eventData=_eventData;
@property(retain, nonatomic) NSString *eventString; // @synthesize eventString=_eventString;
@property(copy, nonatomic) NSString *libraryVersion; // @synthesize libraryVersion=_libraryVersion;
@property(nonatomic) __weak LLAnalyticsDB *db; // @synthesize db=_db;
- (void).cxx_destruct;
- (id)blobHeaderDictionary;
- (id)createEventDictionary;
- (id)createDataFromDictionary;
- (id)createDataFromString;
- (id)createEventString;
- (id)eventAndHeaderBlob;
- (void)setHeaderSequenceNumber:(unsigned long long)arg1;
- (_Bool)willCreateNewHeader;
@property(retain, nonatomic) NSDictionary *eventHeader;

@end

