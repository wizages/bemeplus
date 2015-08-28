#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
// #import "Headers/BMCurrentUserInfoViewController.h"
#import "Headers.h"
/*
This will upload a clip at the location of /Containers/Data/<MagicalNumber>/Library/Application Support/
*/

@interface BMViewController : UIViewController
@end

@interface BMPSettingsViewController : BMViewController <UITableViewDelegate, UITableViewDataSource>
@property (setter=_setTableView:, getter=_tableView, nonatomic, retain) UITableView *_tableView;
@end

@interface BMCurrentUserInfoViewController : BMViewController
@property (retain, nonatomic) NSArray *dataSource;
@end

%subclass BMPSettingsViewController : BMViewController

%new
- (id)_tableView {
	return objc_getAssociatedObject(self, @selector(_tableView));
}
 
%new
- (void)_setTableView:(id)tableView {
	objc_setAssociatedObject(self, @selector(_tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)loadView{
	%orig;
}

- (void)viewDidLoad{
	%orig;
	self.title = @"Beme+ Settings";
	[self _setTableView: [[UITableView alloc] initWithFrame:self.view.frame]];
	// [self _tableView].translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:[self _tableView]];

	// NSDictionary *views = @{@"_tableView" : [self _tableView]};
	// [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:[_tableView]|" options:0 metrics:nil views:views]];
 //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[_tableView]|" options:0 metrics:nil views:views]];
}

%end

%hook BMDockManager

- (int)publishClip:(BMClip *)arg1 {
   %log;
   HBLogDebug(@"%@", arg1);
   %orig;
   return %orig;
}

%end

%hook BMCurrentUserInfoViewController

- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2
{
	long long numberOfSection = %orig;
	numberOfSection = numberOfSection + 1;
	return numberOfSection;
}

- (id)tableView:(id)tableView cellForRowAtIndexPath:(NSIndexPath *)arg2 
{
	if (arg2.row == 0)
	{
	NSDictionary *mainDictionary = [self.dataSource objectAtIndex:0];
	NSArray *data = [mainDictionary objectForKey:@"data"];
	NSMutableArray *overideArray = [[NSMutableArray alloc] init];
	NSAttributedString *ourString = [[NSAttributedString alloc] initWithString:@"Beme++"];
	NSDictionary *ourRow = [[NSDictionary alloc] initWithObjectsAndKeys:@"bemePage", @"action", ourString, @"title", nil];
	[overideArray addObject:ourRow];
	[overideArray addObjectsFromArray:data];
	data = [overideArray copy];
	mainDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:data, @"data", @"Friends", @"title", nil];
	self.dataSource = [[NSArray alloc] initWithObjects:mainDictionary, nil];
	}
	
	%orig;
	return %orig;
}

%new
-(void) bemePage {
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