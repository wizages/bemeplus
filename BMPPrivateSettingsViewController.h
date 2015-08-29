#import "Headers.h"

@interface BMPSwitch : UISwitch

@property (nonatomic) SEL settingSelector;

@end

@interface BMPPrivateSettingsViewController : BMViewController <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) NSArray *dataSource;

- (void)setupDataSource;
- (NSDictionary *)switchSettingWithTitle:(NSString *)title propertyName:(NSString *)propertyName;

@end