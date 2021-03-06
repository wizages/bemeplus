//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableArray, NSObject<OS_dispatch_queue>;

@interface PMKPromise : NSObject
{
    NSObject<OS_dispatch_queue> *_promiseQueue;
    NSMutableArray *_handlers;
    id _result;
}

+ (id)promiseWithBooleanAdapter:(CDUnknownBlockType)arg1;
+ (id)promiseWithIntegerAdapter:(CDUnknownBlockType)arg1;
+ (id)promiseWithAdapter:(CDUnknownBlockType)arg1;
+ (id)new:(CDUnknownBlockType)arg1;
+ (id)promiseWithResolver:(CDUnknownBlockType)arg1;
+ (id)promiseWithValue:(id)arg1;
- (void).cxx_destruct;
- (id)description;
- (id)value;
- (_Bool)rejected;
- (_Bool)fulfilled;
- (_Bool)resolved;
- (_Bool)pending;
- (CDUnknownBlockType)finallyOn;
- (CDUnknownBlockType)catchOn;
- (CDUnknownBlockType)thenOn;
- (id)resolved:(CDUnknownBlockType)arg1 pending:(CDUnknownBlockType)arg2;
- (CDUnknownBlockType)finally;
- (CDUnknownBlockType)catch;
- (CDUnknownBlockType)thenInBackground;
- (CDUnknownBlockType)then;
- (id)init;

@end

