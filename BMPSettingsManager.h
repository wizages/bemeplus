extern NSString * const kBMPEnabledKey;
extern NSString * const kBMPLoopVideoKey;
extern NSString * const kBMPEnablePasscodeKey;
extern NSString * const kBMPPasscodeValueKey;
extern NSString * const kBMPProximityRecording;

#define BMPSharedSettingsManager [BMPSettingsManager sharedSettngsManager]
#define BMPSharedSetting(setting) [BMPSharedSettingsManager setting]

@interface BMPSettingsManager : NSObject

+ (instancetype)sharedSettngsManager;

@property (nonatomic) BOOL tweakIsEnabled, videosShouldLoop, passcodeIsEnabled, proximityEnabled;
@property (nonatomic, retain) NSString *passcodeValue;

@end