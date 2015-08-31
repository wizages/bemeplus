#import "BMPSettingsViewController.h"

@interface BMSignUpViewController : BMViewController
@end

@interface BMUserManager : NSObject
#define BMSharedUserManager ((BMUserManager *)[%c(BMUserManager) sharedInstance])
+ (BMUserManager *)sharedInstance;
- (void)clearUser;
@end

%subclass BMPSettingsViewController : BMPPrivateSettingsViewController

- (void)setupDataSource{
	[[BMPSwitch appearance] setOnTintColor:[UIColor beme_greenColor]];
	NSMutableArray *switches = [NSMutableArray array];
	[switches addObject:[self switchSettingWithTitle:@"Enabled" propertyName:@"tweakIsEnabled"]];
	[switches addObject:[self switchSettingWithTitle:@"Loop Bemes" propertyName:@"videosShouldLoop"]];

	BMPSideEffect *proximitySideEffect = [BMPSideEffect sideEffectWithTarget:self selector:@selector(proximityToggled:)];
	[switches addObject:[self switchSettingWithTitle:@"User Sensor to Record" propertyName:@"proximityEnabled" sideEffect:proximitySideEffect]];

	NSArray *buttons = @[
						[self cellWithTitle:@"Logout" selector:@selector(logout) centred:YES]
						];
	//  accessoryType:UITableViewCellAccessoryDisclosureIndicator
	BMPTableDataSource *dataSource = [[BMPTableDataSource alloc] init];
	dataSource.sections = @[switches, buttons];
	// dataSource.sectionTitles = @[@"HI", @"THERE"];
	[self setDataSource:dataSource];
}

%new
- (void)logout{
	[BMSharedUserManager clearUser];
	[self dismissViewControllerAnimated:YES completion:nil];
}

%new
- (void)proximityToggled:(BMPSwitch *)aSwitch{
	[UIDevice currentDevice].proximityMonitoringEnabled = aSwitch.isOn;
}

- (void)viewDidLoad{
	%orig;
	self.title = @"Beme+ Settings";
}

%end