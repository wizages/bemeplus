//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIView.h"

@class UIImageView, UILabel;

@interface BMPlayerInfoLabelView : UIView
{
    _Bool _isFollowable;
    UILabel *_locationLabel;
    UILabel *_nameLabel;
    UIImageView *_reportFlagImageView;
}

+ (double)getDefaultGutterPadding;
@property(retain, nonatomic) UIImageView *reportFlagImageView; // @synthesize reportFlagImageView=_reportFlagImageView;
@property(retain, nonatomic) UILabel *nameLabel; // @synthesize nameLabel=_nameLabel;
@property(retain, nonatomic) UILabel *locationLabel; // @synthesize locationLabel=_locationLabel;
@property(nonatomic) _Bool isFollowable; // @synthesize isFollowable=_isFollowable;
- (void).cxx_destruct;
- (void)setUsername:(id)arg1;
- (void)setLocation:(id)arg1;
- (void)layoutSubviews;
- (void)setup;
- (id)init;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;

@end

