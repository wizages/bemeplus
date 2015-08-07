//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "BMViewController.h"

#import "UITextFieldDelegate.h"

@class MASConstraint, NSString, UIActivityIndicatorView, UIButton, UILabel, UITextField, UIView;

@interface BMSMSValidateViewController : BMViewController <UITextFieldDelegate>
{
    UIView *_containerView;
    UIView *_topView;
    UIView *_bottomView;
    MASConstraint *_containerBottomConstraint;
    UILabel *_topLabel;
    UIView *_numberContainerView;
    UITextField *_numberInputField;
    UIButton *_submitButton;
    UIButton *_restartButton;
    UIActivityIndicatorView *_loadingIndicator;
    UIView *_bottomPolicyView;
    UIView *_bottomPolicyViewContainer;
}

@property(retain, nonatomic) UIView *bottomPolicyViewContainer; // @synthesize bottomPolicyViewContainer=_bottomPolicyViewContainer;
@property(retain, nonatomic) UIView *bottomPolicyView; // @synthesize bottomPolicyView=_bottomPolicyView;
@property(retain, nonatomic) UIActivityIndicatorView *loadingIndicator; // @synthesize loadingIndicator=_loadingIndicator;
@property(retain, nonatomic) UIButton *restartButton; // @synthesize restartButton=_restartButton;
@property(retain, nonatomic) UIButton *submitButton; // @synthesize submitButton=_submitButton;
@property(retain, nonatomic) UITextField *numberInputField; // @synthesize numberInputField=_numberInputField;
@property(retain, nonatomic) UIView *numberContainerView; // @synthesize numberContainerView=_numberContainerView;
@property(retain, nonatomic) UILabel *topLabel; // @synthesize topLabel=_topLabel;
@property(retain, nonatomic) MASConstraint *containerBottomConstraint; // @synthesize containerBottomConstraint=_containerBottomConstraint;
@property(retain, nonatomic) UIView *bottomView; // @synthesize bottomView=_bottomView;
@property(retain, nonatomic) UIView *topView; // @synthesize topView=_topView;
@property(retain, nonatomic) UIView *containerView; // @synthesize containerView=_containerView;
- (void).cxx_destruct;
- (_Bool)textField:(id)arg1 shouldChangeCharactersInRange:(struct _NSRange)arg2 replacementString:(id)arg3;
- (_Bool)textFieldShouldReturn:(id)arg1;
- (void)textFieldDidChange;
- (void)keyboardWillChangeFrame:(id)arg1;
- (void)resetLogin;
- (void)submit;
- (void)defineLayout;
- (void)setupSubview;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
