//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIPinchGestureRecognizer.h"

@interface BMAllTouchesGestureRecognizer : UIPinchGestureRecognizer
{
    _Bool _isTouching;
    id <BMTouchesContainerDelegate> _touchesEventDelegate;
}

+ (id)sharedInstance;
@property(nonatomic) _Bool isTouching; // @synthesize isTouching=_isTouching;
@property __weak id <BMTouchesContainerDelegate> touchesEventDelegate; // @synthesize touchesEventDelegate=_touchesEventDelegate;
- (void).cxx_destruct;
- (_Bool)isUserInteractionEnabled;
- (void)checkForGlobalTouchEvent:(id)arg1 withEvent:(id)arg2;
- (unsigned long long)numberOfTouchesRequired;
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2;
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2;
- (void)touchesMoved:(id)arg1 withEvent:(id)arg2;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2;
- (void)ignoreTouch:(id)arg1 forEvent:(id)arg2;
- (id)init;

@end
