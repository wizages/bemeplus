//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "BMCaptureSessionDelegate.h"
#import "BMProximityControlDelegate.h"
#import "CLLocationManagerDelegate.h"

@class BMCaptureFeedbackController, BMSystemCameraCaptureSessionController, NSString;

@interface BMCaptureSessionManager : NSObject <BMProximityControlDelegate, BMCaptureSessionDelegate, CLLocationManagerDelegate>
{
    _Bool _disabled;
    _Bool _captureFinished;
    double _progress;
    BMSystemCameraCaptureSessionController *_localCamera;
    id <BMCaptureSessionProtocol> _captureSession;
    BMCaptureFeedbackController *_feedbackController;
    id <BMProximityControl> _proximityControl;
    double _captureDurationSeconds;
}

+ (id)sharedInstance;
@property(nonatomic) double captureDurationSeconds; // @synthesize captureDurationSeconds=_captureDurationSeconds;
@property(nonatomic, getter=isCaptureFinished) _Bool captureFinished; // @synthesize captureFinished=_captureFinished;
@property(retain, nonatomic) id <BMProximityControl> proximityControl; // @synthesize proximityControl=_proximityControl;
@property(retain, nonatomic) BMCaptureFeedbackController *feedbackController; // @synthesize feedbackController=_feedbackController;
@property(retain, nonatomic) id <BMCaptureSessionProtocol> captureSession; // @synthesize captureSession=_captureSession;
@property(retain, nonatomic) BMSystemCameraCaptureSessionController *localCamera; // @synthesize localCamera=_localCamera;
@property(nonatomic, getter=isDisabled) _Bool disabled; // @synthesize disabled=_disabled;
@property(nonatomic) double progress; // @synthesize progress=_progress;
- (void).cxx_destruct;
- (void)postProgressNotificationWithProgress:(id)arg1;
- (void)postCancelNotification;
- (void)postFinishedSavingNotificationWithMovieFileURL:(id)arg1;
- (void)postFinishedRecordingNotification;
- (void)postDidStartNotification;
- (void)postWillStartNotification;
- (void)captureSessionUnavailable:(id)arg1;
- (void)captureSessionAvailable:(id)arg1;
- (void)captureSessionProgress:(id)arg1 progress:(double)arg2;
- (void)captureSessionDidFinish:(id)arg1;
- (void)captureSessionDidCancel:(id)arg1;
- (void)captureSessionDidFinishSaving:(id)arg1 withVideoFileURL:(id)arg2;
- (void)captureSessionDidStart:(id)arg1;
- (void)fetchCurrentLocation;
- (void)proximityControlDidDisengage:(id)arg1;
- (void)proximityControlDidEngage:(id)arg1;
- (void)setupCaptureSession;
- (void)cancelCapture;
- (void)startCapture;
- (void)dealloc;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

