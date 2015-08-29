#import "BMPSettingsViewController.h"

%subclass BMPSettingsViewController : BMPPrivateSettingsViewController

- (void)setupDataSource{
	NSMutableArray *mutableDataSource = [NSMutableArray array];
	[mutableDataSource addObject:[self switchSettingWithTitle:@"Enabled" propertyName:@"tweakIsEnabled"]];
	[mutableDataSource addObject:[self switchSettingWithTitle:@"Loop Bemes" propertyName:@"videosShouldLoop"]];
	[self setDataSource:[NSArray arrayWithArray:mutableDataSource]];
}

- (void)viewDidLoad{
	%orig;
	self.title = @"Beme+ Settings";
}

%end