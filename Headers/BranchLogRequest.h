//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "BNCDebugRequest.h"

@class NSString;

@interface BranchLogRequest : BNCDebugRequest
{
    NSString *_log;
}

@property(retain, nonatomic) NSString *log; // @synthesize log=_log;
- (void).cxx_destruct;
- (void)processResponse:(id)arg1 error:(id)arg2;
- (void)makeRequest:(id)arg1 key:(id)arg2 callback:(CDUnknownBlockType)arg3;
- (id)initWithLog:(id)arg1;

@end

