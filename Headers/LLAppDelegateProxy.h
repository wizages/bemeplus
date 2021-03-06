//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSProxy.h"

#import "UIApplicationDelegate.h"

@class LLAppDelegate, NSArray, NSObject<UIApplicationDelegate>, NSString, UIWindow;

@interface LLAppDelegateProxy : NSProxy <UIApplicationDelegate>
{
    LLAppDelegate *_localyticsAppDelegate;
    NSObject<UIApplicationDelegate> *_originalAppDelegate;
    NSArray *_selectorRules;
}

@property(readonly, nonatomic) NSArray *selectorRules; // @synthesize selectorRules=_selectorRules;
@property(retain, nonatomic) NSObject<UIApplicationDelegate> *originalAppDelegate; // @synthesize originalAppDelegate=_originalAppDelegate;
@property(retain, nonatomic) LLAppDelegate *localyticsAppDelegate; // @synthesize localyticsAppDelegate=_localyticsAppDelegate;
- (void).cxx_destruct;
- (id)pairForSelector:(SEL)arg1;
- (id)methodSignatureForSelector:(SEL)arg1;
- (_Bool)respondsToSelector:(SEL)arg1;
- (_Bool)localyticsDelegateRespondsToSelector:(SEL)arg1;
- (void)forwardInvocation:(id)arg1;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;
@property(retain, nonatomic) UIWindow *window;

@end

