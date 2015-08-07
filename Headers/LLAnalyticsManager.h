//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "LLManagerBase.h"

@class LLAnalyticsDB, LLAnalyticsUploader, NSDate, NSMutableArray, NSString;

@interface LLAnalyticsManager : LLManagerBase
{
    _Bool _autoUpload;
    _Bool _isSessionOpen;
    _Bool _sessionHasBeenOpen;
    _Bool _hasInitialized;
    _Bool _isFirstRun;
    _Bool _isUpgradeRun;
    NSString *_customerId;
    LLAnalyticsDB *_db;
    LLAnalyticsUploader *_networkHandler;
    NSString *_installId;
    double _sessionTimeoutInterval;
    NSString *_applicationKey;
    unsigned long long _sessionNumber;
    double _sessionStartTimeInterval;
    NSDate *_sessionResumeTime;
    NSDate *_sessionCloseTime;
    double _sessionActiveDuration;
    NSString *_sessionUUID;
    NSMutableArray *_screens;
}

+ (_Bool)appKeyIsValid:(id)arg1;
@property(nonatomic) _Bool isUpgradeRun; // @synthesize isUpgradeRun=_isUpgradeRun;
@property(nonatomic) _Bool isFirstRun; // @synthesize isFirstRun=_isFirstRun;
@property(retain, nonatomic) NSMutableArray *screens; // @synthesize screens=_screens;
@property(retain, nonatomic) NSString *sessionUUID; // @synthesize sessionUUID=_sessionUUID;
@property(nonatomic) double sessionActiveDuration; // @synthesize sessionActiveDuration=_sessionActiveDuration;
@property(retain, nonatomic) NSDate *sessionCloseTime; // @synthesize sessionCloseTime=_sessionCloseTime;
@property(retain, nonatomic) NSDate *sessionResumeTime; // @synthesize sessionResumeTime=_sessionResumeTime;
@property(nonatomic) _Bool hasInitialized; // @synthesize hasInitialized=_hasInitialized;
@property(nonatomic) _Bool sessionHasBeenOpen; // @synthesize sessionHasBeenOpen=_sessionHasBeenOpen;
@property(nonatomic) _Bool isSessionOpen; // @synthesize isSessionOpen=_isSessionOpen;
@property(nonatomic) double sessionStartTimeInterval; // @synthesize sessionStartTimeInterval=_sessionStartTimeInterval;
@property(nonatomic) unsigned long long sessionNumber; // @synthesize sessionNumber=_sessionNumber;
@property(retain, nonatomic) NSString *applicationKey; // @synthesize applicationKey=_applicationKey;
@property(retain, nonatomic) LLAnalyticsUploader *networkHandler; // @synthesize networkHandler=_networkHandler;
@property(retain, nonatomic) LLAnalyticsDB *db; // @synthesize db=_db;
- (void).cxx_destruct;
- (id)toHexString:(id)arg1;
- (id)hashString:(id)arg1;
- (double)currentTimestamp;
- (void)appendLocationDimensionsToEventDictionary:(id)arg1;
- (void)appendCustomDimensionsToEventDictionary:(id)arg1;
- (void)appendCustomIdentifiersToEventDictionary:(id)arg1;
- (void)appendCustomerIdentifierToEventDictionary:(id)arg1;
- (void)clearFirstRunUpgradeRunFlags;
- (void)refreshFirstRunUpgradeRun;
- (void)updateFirstAdidIfNeeded;
- (void)openNewSession;
- (void)reopenPreviousSession;
- (void)tagScreen:(id)arg1;
- (void)uploadWithCustomerId:(id)arg1;
- (id)identifiers;
- (id)valueForIdentifier:(id)arg1;
- (void)setValue:(id)arg1 forIdentifier:(id)arg2;
- (void)setCustomDimension:(unsigned long long)arg1 value:(id)arg2;
- (id)customDimensions;
- (id)customDimension:(unsigned long long)arg1;
- (void)tagEvent:(id)arg1 attributes:(id)arg2 customerValueIncrease:(id)arg3 extensionInfo:(id)arg4;
- (void)close;
- (void)open;
- (void)integrateLocalytics:(id)arg1;
- (void)setLocation:(CDStruct_c3b9c2ee)arg1;
- (void)removeDelegate:(id)arg1;
- (void)addDelegate:(id)arg1;
- (id)customerIdSemaphore;
- (void)prepare;
- (id)initWithDelegate:(id)arg1;
@property(nonatomic, getter=isOptedOut) _Bool optedOut;
- (void)setPushToken:(id)arg1;
- (id)pushToken;
@property(nonatomic) double sessionTimeoutInterval; // @synthesize sessionTimeoutInterval=_sessionTimeoutInterval;
@property(nonatomic) _Bool autoUpload; // @synthesize autoUpload=_autoUpload;
@property(readonly, nonatomic) NSString *installId; // @synthesize installId=_installId;
@property(copy) NSString *customerId; // @synthesize customerId=_customerId;

@end
