#import "BMPPrivateSettingsViewController.h"

@implementation BMPSwitch
@end

@interface BMPPrivateSettingsViewController ()
@property (setter=_setTableView:, getter=_tableView, nonatomic, retain) UITableView *_tableView;
- (id)configuredAccessoryViewOfClass:(Class)accessoryClass withDictionary:(NSDictionary *)dictionary;
- (NSString *)selectorNameFromGetter:(NSString *)getterName;
@end

%subclass BMPPrivateSettingsViewController : BMViewController

static UIColor *tableBG, *cellBG, *cellText;
static UIFont *cellFont;

%new
- (UITableView *)_tableView {
	return objc_getAssociatedObject(self, @selector(_tableView));
}
 
%new
- (void)_setTableView:(UITableView *)tableView {
	objc_setAssociatedObject(self, @selector(_tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%new
- (NSArray *)dataSource {
	return objc_getAssociatedObject(self, @selector(dataSource));
}
 
%new
- (void)setDataSource:(NSArray *)tableView {
	objc_setAssociatedObject(self, @selector(dataSource), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)loadView{
	%orig;
}

- (void)viewDidLoad{
	%orig;
	cellBG = [[UIColor class] respondsToSelector:@selector(beme_RGB454545Color)] ? [UIColor beme_RGB454545Color] : [UIColor colorWithWhite:0.18 alpha:1.0f];
	tableBG = [[UIColor class] respondsToSelector:@selector(beme_darkBackgroundColor)] ? [UIColor beme_darkBackgroundColor] : [UIColor colorWithWhite:0.09 alpha:1.0f];
	cellText = [UIColor whiteColor];
	cellFont = [UIFont fontWithName:@"AkkuratStd-Light" size:19];

	[self _setTableView: [[UITableView alloc] initWithFrame:self.view.frame]];
	// [self _tableView].translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:[self _tableView]];
	[self _tableView].delegate = self;
	[self _tableView].dataSource = self;
	[self _tableView].backgroundColor = tableBG;

	[self setupDataSource];
	// NSDictionary *views = @{@"_tableView" : [self _tableView]};
	// [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:[_tableView]|" options:0 metrics:nil views:views]];
 //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[_tableView]|" options:0 metrics:nil views:views]];


}

static NSString *SettingsCell = @"BMPSettingsCell";

%new
- (void)setupDataSource{
	// stub
}

%new
- (NSString *)selectorNameFromGetter:(NSString *)getterName{
	NSMutableString *setterName = [[getterName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[getterName substringToIndex:1] capitalizedString]] mutableCopy];
	[setterName insertString:@"set" atIndex:0];
	[setterName appendString:@":"];
	return setterName;
}

%new
- (NSDictionary *)switchSettingWithTitle:(NSString *)title propertyName:(NSString *)propertyName{
	// obtain getter and setter names
	const char *propName = [propertyName UTF8String];
	objc_property_t property = class_getProperty([BMPSettingsManager class], propName);

	// check for non-default setter name
	char *setterStr = property_copyAttributeValue(property, "S");
	NSString *setter = nil;
	if (setterStr != NULL)
	{
		setter = [NSString stringWithUTF8String:setterStr];
	}else{
		setter = [self selectorNameFromGetter:propertyName];
	}

	// check for non-default getter name
	char *getterStr = property_copyAttributeValue(property, "G");
	NSString *getter = nil;
	if (getterStr != NULL)
	{
		getter = [NSString stringWithUTF8String:getterStr];
	}else{
		getter = propertyName;
	}

	return @{@"title" : title, @"setter" : setter, @"getter" : getter, @"class" : NSStringFromClass([BMPSwitch class])};
}

%new
- (NSInteger)tableView:(UITableView *)arg1 numberOfRowsInSection:(NSInteger)section{
	return [self dataSource].count;
}

%new
- (id)configuredAccessoryViewOfClass:(Class)accessoryClass withDictionary:(NSDictionary *)dictionary{
	id accessoryView = [[accessoryClass alloc] init];
	if ([accessoryView isKindOfClass:[BMPSwitch class]])
	{
		[(BMPSwitch *)accessoryView addTarget:self action:@selector(simpleSwitchSetting:) forControlEvents:UIControlEventValueChanged];
		SEL settingSetter = NSSelectorFromString([dictionary objectForKey:@"setter"]);
		[(BMPSwitch *)accessoryView setSettingSelector:settingSetter];

		SEL settingGetter = NSSelectorFromString([dictionary objectForKey:@"getter"]);

		NSMethodSignature* signature = [BMPSharedSettingsManager methodSignatureForSelector:settingGetter];
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
	    [invocation setSelector:settingGetter];
	    [invocation setTarget:BMPSharedSettingsManager];
	    [invocation invoke];
	    BOOL returnValue;
	    [invocation getReturnValue:&returnValue];
	    [((BMPSwitch *)accessoryView) setOn:returnValue];
	}
	return accessoryView;
}

%new
- (void)simpleSwitchSetting:(BMPSwitch *)switchSettings{
	NSMethodSignature* signature = [BMPSharedSettingsManager methodSignatureForSelector: switchSettings.settingSelector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature: signature];
    [invocation setTarget:BMPSharedSettingsManager];
    [invocation setSelector:switchSettings.settingSelector];
    BOOL isOn = switchSettings.isOn;
    [invocation setArgument:&isOn atIndex:2];
    [invocation invoke];
}

%new
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingsCell];
	if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettingsCell];
	}
	// ;
	cell.backgroundColor = cellBG;
	NSDictionary *cellDictionary = [self dataSource][indexPath.row];
	cell.textLabel.text = cellDictionary[@"title"];
	cell.textLabel.textColor = cellText;
	cell.textLabel.font = cellFont;
	Class accessoryClass = NSClassFromString(cellDictionary[@"class"]);
	if (accessoryClass)
	{
		cell.accessoryView = [self configuredAccessoryViewOfClass:accessoryClass withDictionary:cellDictionary];
	}
	return cell;
}

%new
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}

%end