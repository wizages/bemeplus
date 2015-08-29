//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIResponder.h"

#import "UIApplicationDelegate.h"

@class NSString, UIWindow;

@interface JSDecoupledAppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *_window;
    id <JSApplicationStateDelegate> _appStateDelegate;
    id <JSApplicationDefaultOrientationDelegate> _appDefaultOrientationDelegate;
    id <JSApplicationBackgroundFetchDelegate> _backgroundFetchDelegate;
    id <JSApplicationRemoteNotificationsDelegate> _remoteNotificationsDelegate;
    id <JSApplicationLocalNotificationsDelegate> _localNotificationsDelegate;
    id <JSApplicationStateRestorationDelegate> _stateRestorationDelegate;
    id <JSApplicationURLResourceOpeningDelegate> _URLResourceOpeningDelegate;
    id <JSApplicationProtectedDataDelegate> _protectedDataDelegate;
    id <JSApplicationWatchInteractionDelegate> _watchInteractionDelegate;
    id <JSApplicationExtensionDelegate> _extensionDelegate;
    id <JSApplicationActivityContinuationDelegate> _activityContinuationDelegate;
}

+ (id)sharedAppDelegate;
+ (void)initialize;
@property(retain, nonatomic) id <JSApplicationActivityContinuationDelegate> activityContinuationDelegate; // @synthesize activityContinuationDelegate=_activityContinuationDelegate;
@property(retain, nonatomic) id <JSApplicationExtensionDelegate> extensionDelegate; // @synthesize extensionDelegate=_extensionDelegate;
@property(retain, nonatomic) id <JSApplicationWatchInteractionDelegate> watchInteractionDelegate; // @synthesize watchInteractionDelegate=_watchInteractionDelegate;
@property(retain, nonatomic) id <JSApplicationProtectedDataDelegate> protectedDataDelegate; // @synthesize protectedDataDelegate=_protectedDataDelegate;
@property(retain, nonatomic) id <JSApplicationURLResourceOpeningDelegate> URLResourceOpeningDelegate; // @synthesize URLResourceOpeningDelegate=_URLResourceOpeningDelegate;
@property(retain, nonatomic) id <JSApplicationStateRestorationDelegate> stateRestorationDelegate; // @synthesize stateRestorationDelegate=_stateRestorationDelegate;
@property(retain, nonatomic) id <JSApplicationLocalNotificationsDelegate> localNotificationsDelegate; // @synthesize localNotificationsDelegate=_localNotificationsDelegate;
@property(retain, nonatomic) id <JSApplicationRemoteNotificationsDelegate> remoteNotificationsDelegate; // @synthesize remoteNotificationsDelegate=_remoteNotificationsDelegate;
@property(retain, nonatomic) id <JSApplicationBackgroundFetchDelegate> backgroundFetchDelegate; // @synthesize backgroundFetchDelegate=_backgroundFetchDelegate;
@property(retain, nonatomic) id <JSApplicationDefaultOrientationDelegate> appDefaultOrientationDelegate; // @synthesize appDefaultOrientationDelegate=_appDefaultOrientationDelegate;
@property(retain, nonatomic) id <JSApplicationStateDelegate> appStateDelegate; // @synthesize appStateDelegate=_appStateDelegate;
@property(retain, nonatomic) UIWindow *window; // @synthesize window=_window;
- (void).cxx_destruct;
- (void)application:(id)arg1 didUpdateUserActivity:(id)arg2;
- (void)application:(id)arg1 didFailToContinueUserActivityWithType:(id)arg2 error:(id)arg3;
- (_Bool)application:(id)arg1 continueUserActivity:(id)arg2 restorationHandler:(CDUnknownBlockType)arg3;
- (_Bool)application:(id)arg1 willContinueUserActivityWithType:(id)arg2;
- (_Bool)application:(id)arg1 shouldAllowExtensionPointIdentifier:(id)arg2;
- (void)application:(id)arg1 handleWatchKitExtensionRequest:(id)arg2 reply:(CDUnknownBlockType)arg3;
- (void)applicationProtectedDataDidBecomeAvailable:(id)arg1;
- (void)applicationProtectedDataWillBecomeUnavailable:(id)arg1;
- (_Bool)application:(id)arg1 openURL:(id)arg2 sourceApplication:(id)arg3 annotation:(id)arg4;
- (void)application:(id)arg1 didDecodeRestorableStateWithCoder:(id)arg2;
- (void)application:(id)arg1 willEncodeRestorableStateWithCoder:(id)arg2;
- (_Bool)application:(id)arg1 shouldRestoreApplicationState:(id)arg2;
- (_Bool)application:(id)arg1 shouldSaveApplicationState:(id)arg2;
- (id)application:(id)arg1 viewControllerWithRestorationIdentifierPath:(id)arg2 coder:(id)arg3;
- (void)application:(id)arg1 handleActionWithIdentifier:(id)arg2 forLocalNotification:(id)arg3 completionHandler:(CDUnknownBlockType)arg4;
- (void)application:(id)arg1 didReceiveLocalNotification:(id)arg2;
- (void)application:(id)arg1 handleActionWithIdentifier:(id)arg2 forRemoteNotification:(id)arg3 completionHandler:(CDUnknownBlockType)arg4;
- (void)application:(id)arg1 didRegisterUserNotificationSettings:(id)arg2;
- (void)application:(id)arg1 didReceiveRemoteNotification:(id)arg2 fetchCompletionHandler:(CDUnknownBlockType)arg3;
- (void)application:(id)arg1 didReceiveRemoteNotification:(id)arg2;
- (void)application:(id)arg1 didFailToRegisterForRemoteNotificationsWithError:(id)arg2;
- (void)application:(id)arg1 didRegisterForRemoteNotificationsWithDeviceToken:(id)arg2;
- (void)application:(id)arg1 performFetchWithCompletionHandler:(CDUnknownBlockType)arg2;
- (unsigned long long)application:(id)arg1 supportedInterfaceOrientationsForWindow:(id)arg2;
- (void)applicationWillTerminate:(id)arg1;
- (void)applicationWillEnterForeground:(id)arg1;
- (void)applicationDidEnterBackground:(id)arg1;
- (void)applicationDidBecomeActive:(id)arg1;
- (void)applicationWillResignActive:(id)arg1;
- (void)applicationDidFinishLaunching:(id)arg1;
- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2;
- (_Bool)application:(id)arg1 willFinishLaunchingWithOptions:(id)arg2;
- (id)init;
- (_Bool)respondsToSelector:(SEL)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

