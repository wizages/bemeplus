//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "BMTouchesContainerDelegate.h"

@class NSString, UIView;

@interface BMVideoTouchRecognizer : NSObject <BMTouchesContainerDelegate>
{
    _Bool _firstTouchisInZone;
    _Bool _secondTouchisInZone;
    id <BMVideoTouchEventDelegate> _touchDelegate;
    UIView *_buttonView;
    UIView *_captureView;
    UIView *_parentView;
    double _moveEnergy;
}

+ (id)touchViewWithDelegate:(id)arg1 withButton:(id)arg2 withCaptureView:(id)arg3;
+ (id)sharedInstance;
@property(nonatomic) double moveEnergy; // @synthesize moveEnergy=_moveEnergy;
@property(nonatomic) _Bool secondTouchisInZone; // @synthesize secondTouchisInZone=_secondTouchisInZone;
@property(nonatomic) _Bool firstTouchisInZone; // @synthesize firstTouchisInZone=_firstTouchisInZone;
@property(retain, nonatomic) UIView *parentView; // @synthesize parentView=_parentView;
@property(retain, nonatomic) UIView *captureView; // @synthesize captureView=_captureView;
@property(retain, nonatomic) UIView *buttonView; // @synthesize buttonView=_buttonView;
@property(nonatomic) __weak id <BMVideoTouchEventDelegate> touchDelegate; // @synthesize touchDelegate=_touchDelegate;
- (void).cxx_destruct;
- (void)setupWithDelegate:(id)arg1 withButton:(id)arg2 withCaptureView:(id)arg3 withParentView:(id)arg4;
- (double)distanceBetween:(struct CGPoint)arg1 and:(struct CGPoint)arg2;
- (void)onTouchButton;
- (void)onNoLongerTouching;
- (void)onStartedTouching;
- (void)onShowCaptureTriggered;
- (void)onTouchEnergyHigh;
- (void)onCaptureTriggered;
- (_Bool)checkDidTouchView:(id)arg1 withTouch:(id)arg2;
- (_Bool)touchedCapture:(id)arg1;
- (_Bool)touchedButton:(id)arg1;
- (_Bool)isHot:(id)arg1;
- (void)touchingEndedWithTouch:(id)arg1 withEvent:(id)arg2;
- (void)touchingBeganWithTouch:(id)arg1 withEvent:(id)arg2;
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2;
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2;
- (void)touchesMoved:(id)arg1 withEvent:(id)arg2;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
