//
//  SovrinSequenceUtils.m
//  libsovrin
//
//  Created by Anastasia Tarasova on 10/07/2017.
//  Copyright © 2017 Kirill Neznamov. All rights reserved.
//

#import "SovrinSequenceUtils.h"

@interface SequenceUtils()

@property (atomic, strong) NSLock *lock;
@property (atomic, assign) NSUInteger idsCounter;

@end

@implementation SequenceUtils

+ (SequenceUtils *)sharedInstance
{
    static SequenceUtils *instance = nil;
    static dispatch_once_t dispatch_once_block;
    
    dispatch_once(&dispatch_once_block, ^{
        instance = [SequenceUtils new];
        instance.idsCounter = 0;
        instance.lock = [NSLock new];
    });
    
    return instance;
}


- (NSUInteger)getNextId
{
    if ([self.lock tryLock])
    {
        self.idsCounter +=1;
    }
    [self.lock unlock];
    return self.idsCounter;
}

@end
