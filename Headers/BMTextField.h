//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UITextField.h"

@class UIColor;

@interface BMTextField : UITextField
{
    double _inset;
    UIColor *_placeholderTextColor;
}

+ (id)textFieldWithStyle:(unsigned long long)arg1;
@property(retain, nonatomic) UIColor *placeholderTextColor; // @synthesize placeholderTextColor=_placeholderTextColor;
@property(nonatomic) double inset; // @synthesize inset=_inset;
- (void).cxx_destruct;
- (struct CGRect)editingRectForBounds:(struct CGRect)arg1;
- (struct CGRect)textRectForBounds:(struct CGRect)arg1;
- (struct CGSize)intrinsicContentSize;
- (void)setPlaceholderText:(id)arg1;
- (id)init;

@end
