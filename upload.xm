#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
// #import "Headers/BMCurrentUserInfoViewController.h"
#import "Headers.h"
#import <objc/runtime.h>
#import "BMPSettingsViewController.h"
/*
This will upload a clip at the location of /Containers/Data/<MagicalNumber>/Library/Application Support/
*/



%hook BMDockManager

- (int)publishClip:(BMClip *)arg1 {
   %log;
   HBLogDebug(@"%@", arg1);
   %orig;
   return %orig;
}

%end

%hook BMCurrentUserInfoViewController

- (NSInteger)tableView:(id)arg1 numberOfRowsInSection:(NSInteger)arg2
{
	return %orig;
}

- (void)setDataSource:(NSArray *)dataSource{
	if ([[dataSource objectAtIndex:0] objectForKey:@"BMPSettings"])
	{
		%orig;
		return;
	}
	NSMutableArray *mutableArray = [dataSource mutableCopy];
	NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"Beme+ Settings"];
	[mutableArray insertObject:@{@"action" : @"bmp_displaySettings", @"title" : titleString, @"BMPSettings" : @(YES)} atIndex:0];
	%orig(mutableArray);
}

- (id)tableView:(id)tableView cellForRowAtIndexPath:(NSIndexPath *)arg2{
	// if (arg2.row == 0)
	// {
	// NSDictionary *mainDictionary = [self.dataSource objectAtIndex:0];
	// NSArray *data = [mainDictionary objectForKey:@"data"];
	// NSMutableArray *overideArray = [[NSMutableArray alloc] init];
	// NSAttributedString *ourString = [[NSAttributedString alloc] initWithString:@"Beme++"];
	// NSDictionary *ourRow = [[NSDictionary alloc] initWithObjectsAndKeys:@"bemePage", @"action", ourString, @"title", nil];
	// [overideArray addObject:ourRow];
	// [overideArray addObjectsFromArray:data];
	// data = [overideArray copy];
	// mainDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:data, @"data", @"Friends", @"title", nil];
	// self.dataSource = [[NSArray alloc] initWithObjects:mainDictionary, nil];
	// }
	
	return %orig;
}

%new
-(void)bmp_displaySettings {
	// UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
	// 	message:@"Hi nin9tyfour and wizage :)"
	// 	delegate:nil
	// 	cancelButtonTitle:@"Bye"
	// 	otherButtonTitles:nil];
	// [alert show];

	BMPSettingsViewController *settingsVC = [[%c(BMPSettingsViewController) alloc] init];
	[self.navigationController pushViewController:settingsVC animated:YES];
}
%end

%ctor{
	%init();
}