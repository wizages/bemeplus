#import "BMPSettingsManager.h"

#define defaults()                          [NSUserDefaults standardUserDefaults]
#define defaults_save()                     [defaults() synchronize]
#define defaults_object(key)                [defaults() objectForKey:key]

NSString * const kBMPEnabledKey = @"BMPTweakEnabled";
NSString * const kBMPLoopVideoKey = @"BMPLoopVideos";
NSString * const kBMPEnablePasscodeKey = @"BMPEnablePasscode";
NSString * const kBMPPasscodeValueKey = @"BMPPasscodeValue";

@implementation BMPSettingsManager

+ (instancetype)sharedSettngsManager{
    static BMPSettingsManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil){
            sharedMyManager = [[self alloc] init];
            [sharedMyManager loadSettings];
        }
    }
    return sharedMyManager;
}

/**
 * 	tweakIsEnabled
	videosShouldLoop
	passcodeIsEnabled
	passcodeValue
 */

- (BOOL)boolSettingName:(NSString *)name withDefaultSetting:(BOOL)defaultSetting{
    return defaults_object(name) ? [defaults_object(name) boolValue] : defaultSetting;
}

- (NSInteger)integerSettingName:(NSString *)name withDefaultSetting:(NSInteger)defaultSetting{
    return defaults_object(name) ? [defaults_object(name) integerValue] : defaultSetting;
}

- (NSInteger)floatSettingName:(NSString *)name withDefaultSetting:(CGFloat)defaultSetting{
    return defaults_object(name) ? [defaults_object(name) floatValue] : defaultSetting;
}

- (NSString *)stringSettingName:(NSString *)name withDefaultSetting:(NSString *)defaultSetting{
    return (NSString *)[self objectSettingName:name withDefaultSetting:defaultSetting];
}

- (id)objectSettingName:(NSString *)name withDefaultSetting:(id)defaultSetting{
    return defaults_object(name) ? defaults_object(name) : defaultSetting;
}

-(void)loadSettings{
	_tweakIsEnabled = [self boolSettingName:kBMPEnabledKey withDefaultSetting:YES];
	_videosShouldLoop = [self boolSettingName:kBMPLoopVideoKey withDefaultSetting:YES];
	_passcodeIsEnabled = [self boolSettingName:kBMPEnablePasscodeKey withDefaultSetting:YES];
	_passcodeValue = [self stringSettingName:kBMPPasscodeValueKey withDefaultSetting:nil];
}

- (void)setTweakIsEnabled:(BOOL)value{
	_tweakIsEnabled = value;
	[self saveSettings];
}

- (void)setVideosShouldLoop:(BOOL)value{
	_videosShouldLoop = value;
	[self saveSettings];
}

- (void)setPasscodeIsEnabled:(BOOL)value{
	_passcodeIsEnabled = value;
	[self saveSettings];
}

- (void)setPasscodeValue:(NSString *)value{
	_passcodeValue = value;
	[self saveSettings];
}

- (void)saveSettings{
    [[NSUserDefaults standardUserDefaults] setObject:@(_tweakIsEnabled) forKey:kBMPEnabledKey];
    [[NSUserDefaults standardUserDefaults] setObject:@(_videosShouldLoop) forKey:kBMPLoopVideoKey];
    [[NSUserDefaults standardUserDefaults] setObject:@(_passcodeIsEnabled) forKey:kBMPEnablePasscodeKey];
    [[NSUserDefaults standardUserDefaults] setObject:_passcodeValue forKey:kBMPPasscodeValueKey];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end