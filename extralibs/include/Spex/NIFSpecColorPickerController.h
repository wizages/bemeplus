#import "RSColorPicker/RSColorPickerView.h"

@class RSBrightnessSlider, RSOpacitySlider, NIFSpecColorPickerController, NIFColorPickerView;

@protocol NIFSpecColorPickerControllerDelegate <NSObject>
-(void)colorPickerController:(NIFSpecColorPickerController *)colorPickerController didPickColor:(UIColor *)color;
@end

@interface NIFSpecColorPickerController : UIViewController <RSColorPickerViewDelegate>

-(id)initWithSettingsKey:(NSString *)settingsKey;

@property (nonatomic, retain) NIFColorPickerView *colorPicker;
@property (nonatomic, retain) RSBrightnessSlider *brightnessSlider;
@property (nonatomic, retain) RSOpacitySlider *opacitySlider;
@property (nonatomic, retain) UIView *selectedColorView;
@property (nonatomic, retain) UIButton *hexButton;
@property (nonatomic, retain) UILabel *detailLabel;
@property (nonatomic, retain) NSString *settingsKey;
@property (nonatomic, assign) UIColor *startingColor;
@property (nonatomic) BOOL useAlpha;

@property (nonatomic, assign) id <NIFSpecColorPickerControllerDelegate> delegate;



@end