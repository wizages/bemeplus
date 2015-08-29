//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIView.h"

@class UITapGestureRecognizer;

@interface BMCurrentUserInfoProfileImageGestureView : UIView
{
    _Bool _canSaveProfileImage;
    id <BMCurrentUserInfoProfileImageGestureView> _delegate;
    UITapGestureRecognizer *_tapGestureRecognizer;
}

@property(retain, nonatomic) UITapGestureRecognizer *tapGestureRecognizer; // @synthesize tapGestureRecognizer=_tapGestureRecognizer;
@property(nonatomic) _Bool canSaveProfileImage; // @synthesize canSaveProfileImage=_canSaveProfileImage;
@property(nonatomic) __weak id <BMCurrentUserInfoProfileImageGestureView> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)save:(id)arg1;
- (void)share:(id)arg1;
- (_Bool)canPerformAction:(SEL)arg1 withSender:(id)arg2;
- (_Bool)canBecomeFirstResponder;
- (void)tapWasSelected:(id)arg1;
- (id)init;

@end

