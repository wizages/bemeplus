//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@interface BMUserDefaultDB : NSObject
{
}

+ (id)uniqueID;
- (void)performRetrivalSorting:(id)arg1;
- (id)performDBOperation:(unsigned long long)arg1 clip:(id)arg2 withDB:(id)arg3;
- (id)retreiveAllwithDB:(id)arg1;
- (void)delete:(id)arg1 withDB:(id)arg2;
- (void)update:(id)arg1 withDB:(id)arg2;
- (void)add:(id)arg1 withDB:(id)arg2;
- (id)init;

@end
