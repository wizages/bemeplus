//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "BMUploadOperationDelegate.h"

@class AFNetworkReachabilityManager, BMCleanupOperation, BMClipOperation, BMFinishOperation, BMNotifyOperation, BMTranscoderOperation, BMUploadOperation, NSString, PMKPromise;

@interface BMDockManager : NSObject <BMUploadOperationDelegate>
{
    _Bool _announcedProcessing;
    _Bool _reachabilityPrimed;
    _Bool _processing;
    _Bool _active;
    PMKPromise *_currentDockTask;
    AFNetworkReachabilityManager *_networkReachabilityManager;
    BMTranscoderOperation *_transcoderOperation;
    BMNotifyOperation *_notifyOperation;
    BMUploadOperation *_uploadOperation;
    BMFinishOperation *_finishOperation;
    BMCleanupOperation *_cleanupOperation;
    BMClipOperation *_currentOperation;
}

+ (id)sharedInstance;
@property(nonatomic) __weak BMClipOperation *currentOperation; // @synthesize currentOperation=_currentOperation;
@property(retain, nonatomic) BMCleanupOperation *cleanupOperation; // @synthesize cleanupOperation=_cleanupOperation;
@property(retain, nonatomic) BMFinishOperation *finishOperation; // @synthesize finishOperation=_finishOperation;
@property(retain, nonatomic) BMUploadOperation *uploadOperation; // @synthesize uploadOperation=_uploadOperation;
@property(retain, nonatomic) BMNotifyOperation *notifyOperation; // @synthesize notifyOperation=_notifyOperation;
@property(retain, nonatomic) BMTranscoderOperation *transcoderOperation; // @synthesize transcoderOperation=_transcoderOperation;
@property(retain, nonatomic) AFNetworkReachabilityManager *networkReachabilityManager; // @synthesize networkReachabilityManager=_networkReachabilityManager;
@property(retain) PMKPromise *currentDockTask; // @synthesize currentDockTask=_currentDockTask;
@property(nonatomic, getter=isActive) _Bool active; // @synthesize active=_active;
@property(nonatomic, getter=isProcessing) _Bool processing; // @synthesize processing=_processing;
@property(nonatomic) _Bool reachabilityPrimed; // @synthesize reachabilityPrimed=_reachabilityPrimed;
@property(nonatomic, getter=hasAnnouncedProcessing) _Bool announcedProcessing; // @synthesize announcedProcessing=_announcedProcessing;
- (void).cxx_destruct;
- (void)dealloc;
- (id)init;
- (id)notificationUserInfoForClip:(id)arg1;
- (void)postDidCompleteNotificationForOperation:(id)arg1 withClip:(id)arg2 error:(id)arg3;
- (void)postDidStartNotificationForOperation:(id)arg1 withClip:(id)arg2;
- (id)performOperation:(id)arg1;
- (void)processingComplete;
- (void)processClip:(id)arg1;
- (void)uploadProgress:(double)arg1 remainingBytes:(long long)arg2 totalBytes:(long long)arg3 forClip:(id)arg4;
- (void)announceProcessingComplete;
- (void)announceProcessing;
- (void)processRemainingClips;
- (void)publishClip:(id)arg1;
- (void)deactivate;
- (void)activate;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

