//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "AFHTTPRequestSerializer.h"

@class ACAccount, NSString;

@interface OVCSocialRequestSerializer : AFHTTPRequestSerializer
{
    ACAccount *_account;
    NSString *_serviceType;
}

+ (id)defaultAccountStore;
+ (long long)socialRequestMethodForMethod:(id)arg1;
+ (id)serviceTypeForAccountTypeIdentifier:(id)arg1;
+ (id)serializerWithServiceType:(id)arg1;
+ (id)serializerWithAccount:(id)arg1;
@property(copy, nonatomic) NSString *serviceType; // @synthesize serviceType=_serviceType;
@property(retain, nonatomic) ACAccount *account; // @synthesize account=_account;
- (void).cxx_destruct;
- (id)socialRequestWithMethod:(id)arg1 URLString:(id)arg2 parameters:(id)arg3;
- (id)requestServiceType;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)multipartFormRequestWithMethod:(id)arg1 URLString:(id)arg2 parameters:(id)arg3 constructingBodyWithBlock:(CDUnknownBlockType)arg4 error:(id *)arg5;
- (id)requestWithMethod:(id)arg1 URLString:(id)arg2 parameters:(id)arg3 error:(id *)arg4;

@end

