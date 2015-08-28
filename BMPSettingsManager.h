extern NSString * const kBMPEnabledKey;
extern NSString * const kBMPLoopVideoKey;
extern NSString * const kBMPEnablePasscodeKey;
extern NSString * const kBMPPasscodeValueKey;

#define BMPSharedSettingsManager [NIFSettingsManager sharedManager]
#define BMPSharedSetting(setting) [BMPSharedSettingsManager setting]

@interface BMPSettingsManager : NSObject

+ (instancetype)sharedSettngsManager;

@property (nonatomic) BOOL tweakIsEnabled, videosShouldLoop, passcodeIsEnabled;
@property (nonatomic, retain) NSString *passcodeValue;

@end