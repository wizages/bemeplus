//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableData, NSString;

@interface OMGMultipartFormData : NSObject
{
    NSString *boundary;
    NSMutableData *body;
}

- (void).cxx_destruct;
- (void)addParameters:(id)arg1;
- (void)addText:(id)arg1 parameterName:(id)arg2;
- (void)addFile:(id)arg1 parameterName:(id)arg2 filename:(id)arg3 contentType:(id)arg4;
- (void)add:(id)arg1:(id)arg2:(id)arg3:(id)arg4;
- (id)init;

@end
