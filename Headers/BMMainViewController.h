//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "BMViewController.h"

#import "BMFeedViewControllerDelegate.h"
#import "BMMainTopViewControllerDelegate.h"

@class BMFeedViewController, BMMainTopViewController, BMReaction, NSString, UIView;

@interface BMMainViewController : BMViewController <BMMainTopViewControllerDelegate, BMFeedViewControllerDelegate>
{
    BMMainTopViewController *_topViewController;
    BMFeedViewController *_feedViewController;
    BMReaction *_reaction;
    UIView *_topStatusBarView;
}

@property(retain, nonatomic) UIView *topStatusBarView; // @synthesize topStatusBarView=_topStatusBarView;
@property(retain, nonatomic) BMReaction *reaction; // @synthesize reaction=_reaction;
@property(retain, nonatomic) BMFeedViewController *feedViewController; // @synthesize feedViewController=_feedViewController;
@property(retain, nonatomic) BMMainTopViewController *topViewController; // @synthesize topViewController=_topViewController;
- (void).cxx_destruct;
- (void)displayTutorial;
- (void)displayUserInfoPanel;
- (void)displayRecording;
- (void)displayReactions;
- (void)showTutorial;
- (void)feedRefreshWasCalled;
- (void)reactionsButtonWasSelected;
- (void)settingsButtonWasSelected;
- (void)applyFollowUserLinkInfo:(id)arg1;
- (void)defineLayout;
- (void)setupSubviews;
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

