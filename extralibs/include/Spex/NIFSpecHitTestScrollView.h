//
//  NIFHitTestScrollView.h
//  ColorPickerController
//
//  Created by Terry Lewis on 9/04/2015.
//  Copyright (c) 2015 nin9tyfour. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIFSpecHitTestScrollView;

@protocol NIFSpecHitTestScrollViewDelegate <NSObject>

@optional
- (UIView *)hitTestScrollViewExcusionView:(NIFSpecHitTestScrollView *)exclusionView;
- (NSArray *)hitTestScrollViewExcusionViews:(NIFSpecHitTestScrollView *)exclusionView;

@end

@interface NIFSpecHitTestScrollView : UIScrollView

@property (nonatomic, weak) NSArray *exclusionViews;
@property (nonatomic, weak) UIView *exclusionView;
@property (nonatomic, assign) id <NIFSpecHitTestScrollViewDelegate> hitTestdelegate;

@end
