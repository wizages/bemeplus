//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "TBSMNode.h"
#import "TBSMTransitionVertex.h"

@class NSDictionary, NSMutableDictionary, NSString;

@interface TBSMState : NSObject <TBSMNode, TBSMTransitionVertex>
{
    id <TBSMNode> _parentNode;
    CDUnknownBlockType _enterBlock;
    CDUnknownBlockType _exitBlock;
    NSString *_name;
    NSMutableDictionary *_priv_eventHandlers;
}

+ (id)stateWithName:(id)arg1;
@property(retain, nonatomic) NSMutableDictionary *priv_eventHandlers; // @synthesize priv_eventHandlers=_priv_eventHandlers;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
@property(copy, nonatomic) CDUnknownBlockType exitBlock; // @synthesize exitBlock=_exitBlock;
@property(copy, nonatomic) CDUnknownBlockType enterBlock; // @synthesize enterBlock=_enterBlock;
@property(nonatomic) __weak id <TBSMNode> parentNode; // @synthesize parentNode=_parentNode;
- (void).cxx_destruct;
- (id)path;
- (void)_postNotificationWithName:(id)arg1 sourceState:(id)arg2 targetState:(id)arg3 data:(id)arg4;
- (void)exit:(id)arg1 targetState:(id)arg2 data:(id)arg3;
- (void)enter:(id)arg1 targetState:(id)arg2 data:(id)arg3;
- (id)eventHandlersForEvent:(id)arg1;
- (_Bool)hasHandlerForEvent:(id)arg1;
- (void)addHandlerForEvent:(id)arg1 target:(id)arg2 kind:(unsigned long long)arg3 action:(CDUnknownBlockType)arg4 guard:(CDUnknownBlockType)arg5;
- (void)addHandlerForEvent:(id)arg1 target:(id)arg2 kind:(unsigned long long)arg3 action:(CDUnknownBlockType)arg4;
- (void)addHandlerForEvent:(id)arg1 target:(id)arg2 kind:(unsigned long long)arg3;
- (void)addHandlerForEvent:(id)arg1 target:(id)arg2;
@property(readonly, nonatomic) NSDictionary *eventHandlers;
- (id)initWithName:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

