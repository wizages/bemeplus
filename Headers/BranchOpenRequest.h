//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "BNCServerRequest.h"

@interface BranchOpenRequest : BNCServerRequest
{
    _Bool _allowInstallParamsToBeCleared;
    CDUnknownBlockType _callback;
}

@property(nonatomic) _Bool allowInstallParamsToBeCleared; // @synthesize allowInstallParamsToBeCleared=_allowInstallParamsToBeCleared;
@property(copy, nonatomic) CDUnknownBlockType callback; // @synthesize callback=_callback;
- (void).cxx_destruct;
- (void)processResponse:(id)arg1 error:(id)arg2;
- (void)safeSetValue:(id)arg1 forKey:(id)arg2 onDict:(id)arg3;
- (void)makeRequest:(id)arg1 key:(id)arg2 callback:(CDUnknownBlockType)arg3;
- (id)initWithCallback:(CDUnknownBlockType)arg1 allowInstallParamsToBeCleared:(_Bool)arg2;
- (id)initWithCallback:(CDUnknownBlockType)arg1;

@end
