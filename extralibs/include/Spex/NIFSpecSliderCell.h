#import <Preferences/Preferences.h>

extern NSString *const PSControlMinimumKey;
extern NSString *const PSControlMaximumKey;

@interface NIFSpecSliderCell : PSControlTableCell

@property(retain) UISlider *control;
@property(nonatomic) UILabel *settingNameLabel;

@property(retain) NSDictionary *sliderDict;

@property(nonatomic) NSString *saveKey;
@property(nonatomic) NSString *notificationName;

@end