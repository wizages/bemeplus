#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "Headers/BMCurrentUserInfoViewController.h"
#import "Headers.h"
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
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
		message:@"Hi nin9tyfour and wizage :)"
		delegate:nil
		cancelButtonTitle:@"Bye"
		otherButtonTitles:nil];
	[alert show];
}
%end