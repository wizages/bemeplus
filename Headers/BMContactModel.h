//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MTLModel.h"

#import "MTLJSONSerializing.h"

@class BMUserModel, NSString;

@interface BMContactModel : MTLModel <MTLJSONSerializing>
{
    BMUserModel *_user;
    NSString *_phoneNumber;
}

+ (id)userJSONTransformer;
+ (id)JSONKeyPathsByPropertyKey;
@property(readonly, nonatomic) NSString *phoneNumber; // @synthesize phoneNumber=_phoneNumber;
@property(readonly, nonatomic) BMUserModel *user; // @synthesize user=_user;
- (void).cxx_destruct;

@end

