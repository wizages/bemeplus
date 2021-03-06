//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MTLModel.h"

#import "MTLJSONSerializing.h"

@class NSHTTPURLResponse;

@interface OVCResponse : MTLModel <MTLJSONSerializing>
{
    NSHTTPURLResponse *_HTTPResponse;
    id _result;
}

+ (id)JSONKeyPathsByPropertyKey;
+ (id)responseWithHTTPResponse:(id)arg1 JSONObject:(id)arg2 resultClass:(Class)arg3;
+ (id)resultKeyPathForJSONDictionary:(id)arg1;
@property(retain, nonatomic) id result; // @synthesize result=_result;
@property(retain, nonatomic) NSHTTPURLResponse *HTTPResponse; // @synthesize HTTPResponse=_HTTPResponse;
- (void).cxx_destruct;

@end

