//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray, NSTimer;

@interface BMRecentNameRetriever : NSObject
{
    _Bool _running;
    id <BMRecentNameReceiverDelegate> _delegate;
    NSArray *_fetchedUsers;
    NSTimer *_dataSendingTimer;
    unsigned long long _dataIndex;
}

+ (id)retrieverWithDelegate:(id)arg1;
@property(nonatomic) _Bool running; // @synthesize running=_running;
@property(nonatomic) unsigned long long dataIndex; // @synthesize dataIndex=_dataIndex;
@property(retain, nonatomic) NSTimer *dataSendingTimer; // @synthesize dataSendingTimer=_dataSendingTimer;
@property(copy, nonatomic) NSArray *fetchedUsers; // @synthesize fetchedUsers=_fetchedUsers;
@property(nonatomic) __weak id <BMRecentNameReceiverDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)pushDataWithStartIndex:(unsigned long long)arg1 endIndex:(unsigned long long)arg2;
- (void)calculateNewDataToSend;
- (void)primeData;
- (void)fetchData;
- (void)stop;
- (void)start;
- (id)initWithDelegate:(id)arg1;

@end

