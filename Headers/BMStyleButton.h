//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIButton.h"

@interface BMStyleButton : UIButton
{
    CDUnknownBlockType _action;
}

+ (id)buttonWithText:(id)arg1 withAction:(CDUnknownBlockType)arg2;
+ (id)buttonWithText:(id)arg1;
@property(copy, nonatomic) CDUnknownBlockType action; // @synthesize action=_action;
- (void).cxx_destruct;
- (void)onTouchUpInside:(id)arg1;
- (void)updateButtonText:(id)arg1 forState:(unsigned long long)arg2;
- (void)setup;
- (id)init;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;

@end

