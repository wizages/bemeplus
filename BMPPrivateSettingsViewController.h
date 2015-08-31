#import "Headers.h"

@interface BMPSideEffect : NSObject
+ (id)sideEffectWithTarget:(id)target selector:(SEL)selector;
+ (id)sideEffectWithTarget:(id)target selector:(SEL)selector;

- (void)execute;

@property (nonatomic, strong) id accessory;
@end

@interface BMPTableDataSource : NSObject
@property (nonatomic, retain) NSArray *sectionTitles, *sections;
@end

@interface BMPSwitch : UISwitch

@property (nonatomic) SEL settingSelector;
@property (nonatomic, strong) BMPSideEffect *sideEffect;

@end

@interface BMPPrivateSettingsViewController : BMViewController <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) BMPTableDataSource *dataSource;

- (void)setupDataSource;
- (NSDictionary *)switchSettingWithTitle:(NSString *)title propertyName:(NSString *)propertyName sideEffect:(BMPSideEffect *)sideEffect;
- (NSDictionary *)switchSettingWithTitle:(NSString *)title propertyName:(NSString *)propertyName;
- (NSDictionary *)cellWithTitle:(NSString *)title selector:(SEL)selector;
- (NSDictionary *)cellWithTitle:(NSString *)title selector:(SEL)selector accessoryType:(UITableViewCellAccessoryType)accessoryType;
- (NSDictionary *)cellWithTitle:(NSString *)title selector:(SEL)selector centred:(BOOL)centred;

@end