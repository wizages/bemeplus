//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class BNCPreferenceHelper;

@interface BNCServerInterface : NSObject
{
    BNCPreferenceHelper *_preferenceHelper;
}

@property(retain, nonatomic) BNCPreferenceHelper *preferenceHelper; // @synthesize preferenceHelper=_preferenceHelper;
- (void).cxx_destruct;
- (id)processServerResponse:(id)arg1 data:(id)arg2 error:(id)arg3 log:(_Bool)arg4;
- (id)prepareParamDict:(id)arg1 key:(id)arg2 retryNumber:(long long)arg3;
- (id)preparePostRequest:(id)arg1 url:(id)arg2 key:(id)arg3 retryNumber:(long long)arg4 log:(_Bool)arg5;
- (id)prepareGetRequest:(id)arg1 url:(id)arg2 key:(id)arg3 retryNumber:(long long)arg4 log:(_Bool)arg5;
- (id)genericHTTPRequest:(id)arg1 log:(_Bool)arg2;
- (void)genericHTTPRequest:(id)arg1 retryNumber:(long long)arg2 log:(_Bool)arg3 callback:(CDUnknownBlockType)arg4 retryHandler:(CDUnknownBlockType)arg5;
- (void)genericHTTPRequest:(id)arg1 log:(_Bool)arg2 callback:(CDUnknownBlockType)arg3;
- (id)postRequest:(id)arg1 url:(id)arg2 key:(id)arg3 log:(_Bool)arg4;
- (void)postRequest:(id)arg1 url:(id)arg2 retryNumber:(long long)arg3 key:(id)arg4 log:(_Bool)arg5 callback:(CDUnknownBlockType)arg6;
- (void)postRequest:(id)arg1 url:(id)arg2 key:(id)arg3 log:(_Bool)arg4 callback:(CDUnknownBlockType)arg5;
- (void)postRequest:(id)arg1 url:(id)arg2 key:(id)arg3 callback:(CDUnknownBlockType)arg4;
- (id)getRequest:(id)arg1 url:(id)arg2 key:(id)arg3 log:(_Bool)arg4;
- (id)getRequest:(id)arg1 url:(id)arg2 key:(id)arg3;
- (void)getRequest:(id)arg1 url:(id)arg2 key:(id)arg3 retryNumber:(long long)arg4 log:(_Bool)arg5 callback:(CDUnknownBlockType)arg6;
- (void)getRequest:(id)arg1 url:(id)arg2 key:(id)arg3 log:(_Bool)arg4 callback:(CDUnknownBlockType)arg5;
- (void)getRequest:(id)arg1 url:(id)arg2 key:(id)arg3 callback:(CDUnknownBlockType)arg4;

@end
