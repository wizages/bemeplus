//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIControl.h"

@class NSMutableDictionary, UIColor, UILabel;

@interface CTCheckbox : UIControl
{
    _Bool _checked;
    float _checkboxSideLength;
    UIColor *_checkboxColor;
    UILabel *_textLabel;
    NSMutableDictionary *_colorDictionary;
    NSMutableDictionary *_backgroundColorDictionary;
}

@property(retain, nonatomic) NSMutableDictionary *backgroundColorDictionary; // @synthesize backgroundColorDictionary=_backgroundColorDictionary;
@property(retain, nonatomic) NSMutableDictionary *colorDictionary; // @synthesize colorDictionary=_colorDictionary;
@property(retain, nonatomic) UILabel *textLabel; // @synthesize textLabel=_textLabel;
@property(nonatomic) float checkboxSideLength; // @synthesize checkboxSideLength=_checkboxSideLength;
@property(retain, nonatomic) UIColor *checkboxColor; // @synthesize checkboxColor=_checkboxColor;
@property(nonatomic) _Bool checked; // @synthesize checked=_checked;
- (void).cxx_destruct;
- (void)endTrackingWithTouch:(id)arg1 withEvent:(id)arg2;
- (void)layoutSubviews;
- (void)drawRect:(struct CGRect)arg1;
- (void)setBackgroundColor:(id)arg1 forControlState:(unsigned long long)arg2;
- (void)setColor:(id)arg1 forControlState:(unsigned long long)arg2;
- (void)changeBackgroundColorForState:(unsigned long long)arg1;
- (void)changeColorForState:(unsigned long long)arg1;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)dealloc;
- (void)setUp;
- (id)initWithCoder:(id)arg1;
- (id)initWithFrame:(struct CGRect)arg1;

@end

