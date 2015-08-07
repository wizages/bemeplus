//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class BMUserModel, UIView;

@interface BMReportSheet : NSObject
{
    id <BMReportActionDelegate> _delegate;
    BMUserModel *_user;
    UIView *_sourceView;
}

+ (id)showReportSheetWithUser:(id)arg1 fromView:(id)arg2 delegate:(id)arg3;
@property(nonatomic) __weak UIView *sourceView; // @synthesize sourceView=_sourceView;
@property(nonatomic) __weak BMUserModel *user; // @synthesize user=_user;
@property(nonatomic) __weak id <BMReportActionDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)cancelSelected;
- (void)blockConfirmed;
- (void)reportConfirmed;
- (void)blockPressed;
- (void)reportPressed;
- (id)initWithDelegate:(id)arg1;

@end
