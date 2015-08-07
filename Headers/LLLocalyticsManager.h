//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "LLLocalyticsDelegate.h"

@class LLAnalyticsManager, LLAppDelegateProxy, LLInAppManager, LLProfilesManager, NSObject<OS_dispatch_group>, NSString;

@interface LLLocalyticsManager : NSObject <LLLocalyticsDelegate>
{
    _Bool _useSandbox;
    _Bool _httpsEnabled;
    NSObject<OS_dispatch_group> *_dispatchGroupCritical;
    NSString *_appKey;
    LLAnalyticsManager *_analytics;
    LLInAppManager *_marketing;
    LLProfilesManager *_profiles;
    LLAppDelegateProxy *_proxy;
    long long _lastState;
    NSString *_theAnalyticsHost;
    NSString *_theMarketingHost;
    NSString *_theProfilesHost;
}

+ (id)sharedInstance;
@property(copy) NSString *theProfilesHost; // @synthesize theProfilesHost=_theProfilesHost;
@property(copy) NSString *theMarketingHost; // @synthesize theMarketingHost=_theMarketingHost;
@property(copy) NSString *theAnalyticsHost; // @synthesize theAnalyticsHost=_theAnalyticsHost;
@property(nonatomic) long long lastState; // @synthesize lastState=_lastState;
@property(retain, nonatomic) LLAppDelegateProxy *proxy; // @synthesize proxy=_proxy;
@property(retain, nonatomic) LLProfilesManager *profiles; // @synthesize profiles=_profiles;
@property(retain, nonatomic) LLInAppManager *marketing; // @synthesize marketing=_marketing;
@property(retain, nonatomic) LLAnalyticsManager *analytics; // @synthesize analytics=_analytics;
@property(retain) NSString *appKey; // @synthesize appKey=_appKey;
@property(readonly, nonatomic) NSObject<OS_dispatch_group> *dispatchGroupCritical; // @synthesize dispatchGroupCritical=_dispatchGroupCritical;
@property(getter=isHttpsEnabled) _Bool httpsEnabled; // @synthesize httpsEnabled=_httpsEnabled;
@property _Bool useSandbox; // @synthesize useSandbox=_useSandbox;
- (void).cxx_destruct;
- (id)localyticsDirectoryPath;
- (id)customerIdInMemory;
- (void)setSpecialCustomerIdentifierAndAttribute:(id)arg1 forKey:(id)arg2;
- (void)setCustomerFullName:(id)arg1;
- (void)setCustomerLastName:(id)arg1;
- (void)setCustomerFirstName:(id)arg1;
- (void)setCustomerEmail:(id)arg1;
- (void)deleteProfileAttribute:(id)arg1;
- (void)deleteProfileAttribute:(id)arg1 withScope:(long long)arg2;
- (void)decrementValueBy:(long long)arg1 forProfileAttribute:(id)arg2;
- (void)decrementValueBy:(long long)arg1 forProfileAttribute:(id)arg2 withScope:(long long)arg3;
- (void)incrementValueBy:(long long)arg1 forProfileAttribute:(id)arg2;
- (void)incrementValueBy:(long long)arg1 forProfileAttribute:(id)arg2 withScope:(long long)arg3;
- (void)removeValues:(id)arg1 fromSetForProfileAttribute:(id)arg2;
- (void)removeValues:(id)arg1 fromSetForProfileAttribute:(id)arg2 withScope:(long long)arg3;
- (void)addValues:(id)arg1 toSetForProfileAttribute:(id)arg2;
- (void)addValues:(id)arg1 toSetForProfileAttribute:(id)arg2 withScope:(long long)arg3;
- (void)setValue:(id)arg1 forProfileAttribute:(id)arg2;
- (void)setValue:(id)arg1 forProfileAttribute:(id)arg2 withScope:(long long)arg3;
- (void)removeMessagingDelegate:(id)arg1;
- (void)addMessagingDelegate:(id)arg1;
- (unsigned long long)inAppMessageDismissButtonLocation;
- (void)setInAppMessageDismissButtonLocation:(unsigned long long)arg1;
- (void)setInAppMessageDismissButtonImageWithName:(id)arg1;
- (void)setInAppMessageDismissButtonImage:(id)arg1;
- (id)fetchAMPRules;
- (void)refreshInAppMessages;
- (void)dismissCurrentInAppMessage;
- (void)triggerInAppMessageWithRuleId:(unsigned long long)arg1;
- (void)triggerInAppMessage:(id)arg1 withAttributes:(id)arg2;
- (void)triggerInAppMessage:(id)arg1;
- (void)tagEvent:(id)arg1 attributes:(id)arg2 customerValueIncrease:(id)arg3 extensionInfo:(id)arg4;
- (void)tagEvent:(id)arg1 attributes:(id)arg2 customerValueIncrease:(id)arg3;
- (void)tagEvent:(id)arg1 attributes:(id)arg2;
- (void)tagEvent:(id)arg1;
- (void)removeAnalyticsDelegate:(id)arg1;
- (void)addAnalyticsDelegate:(id)arg1;
- (void)handlePushNotificationOpened:(id)arg1;
- (_Bool)handleTestModeURL:(id)arg1;
- (void)setProfilesHost:(id)arg1;
@property(readonly) NSString *profilesHost;
- (void)setMessagingHost:(id)arg1;
@property(readonly) NSString *messagingHost;
- (void)setAnalyticsHost:(id)arg1;
@property(readonly) NSString *analyticsHost;
- (void)setSessionTimeoutInterval:(double)arg1;
- (double)sessionTimeoutInterval;
- (void)setCollectAdvertisingIdentifier:(_Bool)arg1;
- (_Bool)isCollectingAdvertisingIdentifier;
- (void)setPushToken:(id)arg1;
- (id)pushToken;
- (void)setAutoUpload:(_Bool)arg1;
- (_Bool)autoUpload;
@property(readonly) NSString *libraryVersion;
@property(readonly) NSString *installId;
- (void)tagScreen:(id)arg1;
- (id)customerId;
- (void)setCustomerId:(id)arg1;
- (id)identifiers;
- (id)valueForIdentifier:(id)arg1;
- (void)setValue:(id)arg1 forIdentifier:(id)arg2;
- (id)customDimensions;
- (id)valueForCustomDimension:(unsigned long long)arg1;
- (void)setValue:(id)arg1 forCustomDimension:(unsigned long long)arg2;
- (double)lastSessionStartTimestamp;
- (unsigned long long)sessionNumber;
- (void)setLocation:(CDStruct_c3b9c2ee)arg1;
- (_Bool)isTestModeEnabled;
- (void)setTestModeEnabled:(_Bool)arg1;
- (_Bool)isOptedOut;
- (void)setOptedOut:(_Bool)arg1;
- (void)setLoggingEnabled:(_Bool)arg1;
- (_Bool)isLoggingEnabled;
- (void)upload;
- (void)closeSession;
- (void)openSession;
- (void)autoIntegrate:(id)arg1 launchOptions:(id)arg2;
- (void)integrate:(id)arg1;
- (void)startBackgroundTask;
- (void)applicationDidBecomeActive;
- (void)applicationDidEnterBackground:(id)arg1;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
