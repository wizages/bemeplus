//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MTLModel.h"

#import "MTLJSONSerializing.h"

@class NSArray;

@interface BMAcceptedInvitesModel : MTLModel <MTLJSONSerializing>
{
    NSArray *_users;
}

+ (id)JSONTransformerForKey:(id)arg1;
+ (id)JSONKeyPathsByPropertyKey;
@property(readonly, nonatomic) NSArray *users; // @synthesize users=_users;
- (void).cxx_destruct;

@end

