//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class TBSMState;

@interface TBSMTransition : NSObject
{
    TBSMState *_sourceState;
    TBSMState *_targetState;
    unsigned long long _kind;
    CDUnknownBlockType _action;
    CDUnknownBlockType _guard;
}

+ (id)transitionWithSourceState:(id)arg1 targetState:(id)arg2 kind:(unsigned long long)arg3 action:(CDUnknownBlockType)arg4 guard:(CDUnknownBlockType)arg5;
@property(copy, nonatomic) CDUnknownBlockType guard; // @synthesize guard=_guard;
@property(copy, nonatomic) CDUnknownBlockType action; // @synthesize action=_action;
@property(nonatomic) unsigned long long kind; // @synthesize kind=_kind;
@property(nonatomic) __weak TBSMState *targetState; // @synthesize targetState=_targetState;
@property(nonatomic) __weak TBSMState *sourceState; // @synthesize sourceState=_sourceState;
- (void).cxx_destruct;
- (_Bool)performTransitionWithData:(id)arg1;
- (id)findLeastCommonAncestor;
- (id)name;
- (id)initWithSourceState:(id)arg1 targetState:(id)arg2 kind:(unsigned long long)arg3 action:(CDUnknownBlockType)arg4 guard:(CDUnknownBlockType)arg5;

@end
