//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UITableViewCell.h"

#import "BMTableViewCellProtocol.h"

@class BMFollowStyleButton, BMReportButton, NSString, UILabel, UIView;

@interface BMUserListCell : UITableViewCell <BMTableViewCellProtocol>
{
    UILabel *_nameLabel;
    UILabel *_detailLabel;
    BMFollowStyleButton *_followButton;
    BMReportButton *_reportButton;
    id <BMCellButtonPressDelegate> _delegate;
    UIView *_lineView;
}

@property(retain, nonatomic) UIView *lineView; // @synthesize lineView=_lineView;
@property(nonatomic) __weak id <BMCellButtonPressDelegate> delegate; // @synthesize delegate=_delegate;
@property(retain, nonatomic) BMReportButton *reportButton; // @synthesize reportButton=_reportButton;
@property(retain, nonatomic) BMFollowStyleButton *followButton; // @synthesize followButton=_followButton;
@property(retain, nonatomic) UILabel *detailLabel; // @synthesize detailLabel=_detailLabel;
@property(retain, nonatomic) UILabel *nameLabel; // @synthesize nameLabel=_nameLabel;
- (void).cxx_destruct;
- (void)setFollowing:(_Bool)arg1;
- (void)reportButtonTapped:(id)arg1;
- (void)followButtonTapped:(id)arg1;
- (void)setupWithDataObject:(id)arg1;
- (void)layoutSubviews;
- (void)setup;
- (id)init;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;
- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

