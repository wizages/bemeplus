#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
//#import "Headers/BMClip.h"
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
	numberOfSection = numberOfSection + 2;
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
	NSAttributedString *uploadString = [[NSAttributedString alloc] initWithString:@"Upload video"];
	NSDictionary *uploadRow = [[NSDictionary alloc] initWithObjectsAndKeys:@"upload", @"action", uploadString, @"title", nil];
	[overideArray addObject:ourRow];
	[overideArray addObjectsFromArray:data];
	[overideArray addObject:uploadRow];
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
/*
<BMClip: 0x192d5ff0> {
	    identifier = "<null>";
	    latitude = "40.00284424154221";
	    localFilename = "../test.mov";
	    localIdentifier = "C15F62FC-40C5-4816-AF3C-AB19B7CCC929-6786-0000024FA1980987";
	    longitude = "-105.0982369811759";
	    postedAt = "<null>";
	    recordedAt = "2015-08-10 00:30:01 +0000";
	    remoteURL = "<null>";
	    state = 0;
	    uploadToken = "<null>";
	    uploadURL = "<null>";
	    uploadURLExpirey = "<null>";
	    userIdentifier = 229359;
	}}
*/
%new
-(void) upload {
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
       imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
       //imagePickerController.delegate = self;
       imagePickerController.allowsEditing = YES; //if you want to edit the image
       //self.RootViewController = imagePickerController;
       self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
       [self.view addSubview:imagePickerController.view];
}

%end