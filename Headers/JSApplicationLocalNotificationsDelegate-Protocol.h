//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSString, UIApplication, UILocalNotification;

@protocol JSApplicationLocalNotificationsDelegate <NSObject>
- (void)application:(UIApplication *)arg1 handleActionWithIdentifier:(NSString *)arg2 forLocalNotification:(UILocalNotification *)arg3 completionHandler:(void (^)(void))arg4;
- (void)application:(UIApplication *)arg1 didReceiveLocalNotification:(UILocalNotification *)arg2;
@end

