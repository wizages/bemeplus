//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIView.h"

@class NSLayoutConstraint;

@interface NPKeyboardLayoutGuide : UIView
{
    NSLayoutConstraint *_verticalPositionConstraint;
}

@property(nonatomic) __weak NSLayoutConstraint *verticalPositionConstraint; // @synthesize verticalPositionConstraint=_verticalPositionConstraint;
- (void).cxx_destruct;
- (void)keyboardWillChangeFrame:(id)arg1;
- (void)addToView:(id)arg1;
- (void)dealloc;
- (id)initWithFrame:(struct CGRect)arg1;

@end

