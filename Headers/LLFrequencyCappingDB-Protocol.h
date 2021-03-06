//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray, NSDictionary, NSNumber, NSSet;

@protocol LLFrequencyCappingDB <NSObject>
- (NSSet *)getGloballyDisqualifiedCampaignsBy:(long long)arg1 eligibleCampaigns:(NSSet *)arg2;
- (NSSet *)getDisqualifiedCampaignsBy:(long long)arg1 eligibleCampaigns:(NSSet *)arg2;
- (NSSet *)getIgnoresGlobalCampaignsFromEligibleCampaigns:(NSSet *)arg1;
- (_Bool)deleteFrequencyCappingRules:(NSArray *)arg1;
- (_Bool)deleteGlobalFrequencyCappingRule;
- (_Bool)storeFrequencyCappingRule:(NSDictionary *)arg1 forCampaignId:(NSNumber *)arg2;
@end

