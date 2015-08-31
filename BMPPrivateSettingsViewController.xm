#import "BMPPrivateSettingsViewController.h"


// - (void)performSelector:(SEL)selector onTarget:(id)target withObject:(id)object{
// #pragma clang diagnostic push
// #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//     ForcePerformSelector(target, selector, object);
// #pragma clang diagnostic pop
// }

static void ForcePerformSelector(SEL selector, id target, id object){
	#pragma clang diagnostic push
	#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	    [target performSelector:selector withObject: object];
	#pragma clang diagnostic pop
}

@implementation BMPSwitch
@end

@implementation BMPTableDataSource
@end

@interface BMPSideEffect ()
@property (nonatomic, weak) id target;
@property (nonatomic, strong) id object;
@property (nonatomic) SEL selector;
@end

@implementation BMPSideEffect

+ (id)sideEffectWithTarget:(id)target selector:(SEL)selector{
	return [BMPSideEffect sideEffectWithTarget:target selector:selector object:nil];
}

+ (id)sideEffectWithTarget:(id)target selector:(SEL)selector object:(id)object{
	BMPSideEffect *sideEffect = [[BMPSideEffect alloc] init];
	if (sideEffect)
	{
		sideEffect.target = target;
		sideEffect.selector = selector;
		sideEffect.object = object;
	}
	return sideEffect;
}

- (void)execute{
	ForcePerformSelector(_selector, _target, _object ? : _accessory);
}

@end

@interface BMPPrivateSettingsViewController ()
@property (setter=_setTableView:, getter=_tableView, nonatomic, retain) UITableView *_tableView;
- (id)configuredAccessoryViewOfClass:(Class)accessoryClass withDictionary:(NSDictionary *)dictionary;
- (NSString *)selectorNameFromGetter:(NSString *)getterName;
// - (void)performSelector:(SEL)selector onTarget:(id)target withObject:(id)object;
@end

@interface BMCurrentUserInfoTableViewCell : UITableViewCell
@end

%subclass BMPPrivateSettingsViewController : BMViewController

static UIColor *tableBG, *cellBG, *cellText;
static UIFont *cellFont;
static UIView *cellSelectionView;
static Class cellClass;
static NSString *SettingsCell = @"BMPSettingsCell";
static BOOL usingInternalCellClass;

%new
- (UITableView *)_tableView {
	return objc_getAssociatedObject(self, @selector(_tableView));
}
 
%new
- (void)_setTableView:(UITableView *)tableView {
	objc_setAssociatedObject(self, @selector(_tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%new
- (BMPTableDataSource *)dataSource {
	return objc_getAssociatedObject(self, @selector(dataSource));
}
 
%new
- (void)setDataSource:(BMPTableDataSource *)tableView {
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
	cellSelectionView = [[UIView alloc] initWithFrame:CGRectZero];
	cellSelectionView.backgroundColor = tableBG;

	if (%c(BMCurrentUserInfoTableViewCell))
	{
		cellClass = %c(BMCurrentUserInfoTableViewCell);
		usingInternalCellClass = YES;
	}else{
		cellClass = [UITableViewCell class];
		usingInternalCellClass = NO;
	}
	[[self _tableView] registerClass:cellClass forCellReuseIdentifier:SettingsCell];

	[self _setTableView: [[UITableView alloc] initWithFrame:self.view.frame/* style:UITableViewStyleGrouped*/]];
	// [self _tableView].translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:[self _tableView]];
	[self _tableView].delegate = self;
	[self _tableView].dataSource = self;
	[self _tableView].backgroundColor = tableBG;
	[self _tableView].separatorColor = [UIColor clearColor];

	[self setupDataSource];
	// NSDictionary *views = @{@"_tableView" : [self _tableView]};
	// [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:[_tableView]|" options:0 metrics:nil views:views]];
 //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[_tableView]|" options:0 metrics:nil views:views]];


}

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
- (NSDictionary *)cellWithTitle:(NSString *)title selector:(SEL)selector{
	return [self cellWithTitle:title selector:selector accessoryType:UITableViewCellAccessoryNone];
}

%new
- (NSDictionary *)cellWithTitle:(NSString *)title selector:(SEL)selector centred:(BOOL)centred{
	NSMutableDictionary *dict = [[self cellWithTitle:title selector:selector accessoryType:UITableViewCellAccessoryNone] mutableCopy];
	[dict setObject:@(YES) forKey:@"centred"];
	return dict;
}

%new
- (NSDictionary *)cellWithTitle:(NSString *)title selector:(SEL)selector accessoryType:(UITableViewCellAccessoryType)accessoryType{
	return @{@"title" : title, @"selector" : NSStringFromSelector(selector), @"accessoryType" : @(accessoryType)};
}

%new
- (NSDictionary *)switchSettingWithTitle:(NSString *)title propertyName:(NSString *)propertyName{
	return [self switchSettingWithTitle:title propertyName:propertyName sideEffect:nil];
}

%new
- (NSDictionary *)switchSettingWithTitle:(NSString *)title propertyName:(NSString *)propertyName sideEffect:(BMPSideEffect *)sideEffect{
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
	return @{@"title" : title, @"setter" : setter, @"getter" : getter, @"class" : NSStringFromClass([BMPSwitch class]), @"sideEffect" : sideEffect ? : [NSNull null]};
}

%new
- (NSInteger)tableView:(UITableView *)arg1 numberOfRowsInSection:(NSInteger)section{
	return [[self.dataSource sections][section] count];
}

%new
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.dataSource sections] count];
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

	    BMPSideEffect *sideEffect = dictionary[@"sideEffect"];
	    if ([sideEffect isKindOfClass:[BMPSideEffect class]])
	    {
		    [((BMPSwitch *)accessoryView) setSideEffect:sideEffect];
		    sideEffect.accessory = accessoryView;
		    // [(UIView *)accessoryView setBackgroundColor:UIColor.redColor];
	    }
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
    NSLog(@"SIDE EFFECT: %@", switchSettings.sideEffect);
    if (switchSettings.sideEffect)
    {
    	[switchSettings.sideEffect execute];
    }
}

%new
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingsCell];
	if (!cell)
	{
		cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettingsCell];
	}
	if (!usingInternalCellClass)
	{
		cell.backgroundColor = cellBG;
		cell.textLabel.textColor = cellText;
		cell.textLabel.font = cellFont;
	}
	NSDictionary *cellDictionary = [self.dataSource sections][indexPath.section][indexPath.row];
	cell.textLabel.text = cellDictionary[@"title"];
	Class accessoryClass = NSClassFromString(cellDictionary[@"class"]);
	if (accessoryClass)
	{
		cell.accessoryView = [self configuredAccessoryViewOfClass:accessoryClass withDictionary:cellDictionary];
		cell.selectionStyle = 0;
	}else if(cellDictionary[@"accessoryType"]){
		cell.accessoryType = (UITableViewCellAccessoryType)[cellDictionary[@"accessoryType"] integerValue];
		if (!usingInternalCellClass)
		{
			cell.selectedBackgroundView = cellSelectionView;
		}
	}
	if ([cellDictionary[@"centred"] boolValue])
	{
		cell.textLabel.textAlignment = NSTextAlignmentCenter;
	}
	return cell;
}

%new
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSDictionary *cellDictionary = [self.dataSource sections][indexPath.section][indexPath.row];
	SEL selector = NSSelectorFromString(cellDictionary[@"selector"]);
	// 
	// [self performSelector:selector onTarget:self withObject:nil];
	if (selector)
	{
		ForcePerformSelector(selector, self, nil);
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

%new
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return section ? 36 : 0;
}

%new
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	return [[UIView alloc] init];
}

%new
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}

%end