//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class BMContactImporter, NSArray, NSError;

@protocol BMContactImporterDelegate <NSObject>
- (void)contactImporter:(BMContactImporter *)arg1 didCompleteWithContactsAsDictionaryRepresentations:(NSArray *)arg2;
- (void)contactImporter:(BMContactImporter *)arg1 failedWithAccessDeniedError:(NSError *)arg2;
@end

