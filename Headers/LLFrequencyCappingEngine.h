//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSDateFormatter;

@interface LLFrequencyCappingEngine : NSObject
{
    id <LLFrequencyCappingDB> _fcDb;
    NSDateFormatter *_fcTimeFormatter;
    NSDateFormatter *_fcDateFormatter;
}

@property(retain, nonatomic) NSDateFormatter *fcDateFormatter; // @synthesize fcDateFormatter=_fcDateFormatter;
@property(retain, nonatomic) NSDateFormatter *fcTimeFormatter; // @synthesize fcTimeFormatter=_fcTimeFormatter;
@property(retain, nonatomic) id <LLFrequencyCappingDB> fcDb; // @synthesize fcDb=_fcDb;
- (void).cxx_destruct;
- (id)getAllDisqualifiedCampaignsBy:(long long)arg1 eligibleCampaigns:(id)arg2;
- (id)filterOutCampaignsDisqualifiedByFrequencyCappingRules:(id)arg1;
- (_Bool)testDateAndTimeFCRules:(id)arg1 withFormatter:(id)arg2;
- (_Bool)testEachFCRuleInList:(id)arg1 forKeys:(id)arg2;
- (_Bool)validateFrequencyCappingRule:(id)arg1 isGlobal:(_Bool)arg2;
- (_Bool)extractAndStoreFrequencyCappingRules:(id)arg1 isGlobal:(_Bool)arg2;
- (id)initWithFrequencyCappingDB:(id)arg1;

@end

