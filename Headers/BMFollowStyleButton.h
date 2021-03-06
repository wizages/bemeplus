//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "BMStyleButton.h"

@interface BMFollowStyleButton : BMStyleButton
{
    _Bool _isFollowing;
    CDUnknownBlockType _followAction;
    CDUnknownBlockType _unfollowAction;
}

+ (id)followButtonWithFollowAction:(CDUnknownBlockType)arg1 unFollowAction:(CDUnknownBlockType)arg2 startingState:(_Bool)arg3;
+ (id)followButtonWithStartingState:(_Bool)arg1;
@property(nonatomic) _Bool isFollowing; // @synthesize isFollowing=_isFollowing;
@property(copy, nonatomic) CDUnknownBlockType unfollowAction; // @synthesize unfollowAction=_unfollowAction;
@property(copy, nonatomic) CDUnknownBlockType followAction; // @synthesize followAction=_followAction;
- (void).cxx_destruct;

@end

