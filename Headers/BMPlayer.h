//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "AVPlayer.h"

@interface BMPlayer : AVPlayer
{
    CDUnknownBlockType _updateProgressBlock;
    CDUnknownBlockType _reachedEndBlock;
    CDUnknownBlockType _currentItemStatusChangedBlock;
    id _timeObserver;
    double _elapseTime;
}

@property(nonatomic) double elapseTime; // @synthesize elapseTime=_elapseTime;
@property(retain, nonatomic) id timeObserver; // @synthesize timeObserver=_timeObserver;
@property(copy, nonatomic) CDUnknownBlockType currentItemStatusChangedBlock; // @synthesize currentItemStatusChangedBlock=_currentItemStatusChangedBlock;
@property(copy, nonatomic) CDUnknownBlockType reachedEndBlock; // @synthesize reachedEndBlock=_reachedEndBlock;
@property(copy, nonatomic) CDUnknownBlockType updateProgressBlock; // @synthesize updateProgressBlock=_updateProgressBlock;
- (void).cxx_destruct;
- (void)replaceCurrentItemWithPlayerItem:(id)arg1;
- (void)itemDidReachEnd:(id)arg1;
- (void)dealloc;

@end
