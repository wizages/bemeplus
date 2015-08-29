//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSSet, UIEvent, UITouch;

@protocol BMTouchesContainerDelegate <NSObject>

@optional
- (void)touchingEndedWithTouch:(UITouch *)arg1 withEvent:(UIEvent *)arg2;
- (void)touchingBeganWithTouch:(UITouch *)arg1 withEvent:(UIEvent *)arg2;
- (void)touchesCancelled:(NSSet *)arg1 withEvent:(UIEvent *)arg2;
- (void)touchesEnded:(NSSet *)arg1 withEvent:(UIEvent *)arg2;
- (void)touchesMoved:(NSSet *)arg1 withEvent:(UIEvent *)arg2;
- (void)touchesBegan:(NSSet *)arg1 withEvent:(UIEvent *)arg2;
@end

