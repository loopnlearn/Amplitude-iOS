//
//  BaseTestCase.m
//  Amplitude
//
//  Created by Allan on 3/11/15.
//  Copyright (c) 2015 Amplitude. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "Amplitude+SSLPinning.h"
#import "Amplitude+Test.h"
#import "BaseTestCase.h"
#import "AMPDatabaseHelper.h"

NSString *const apiKey = @"000000";
NSString *const userId = @"userId";

@implementation BaseTestCase {
    id _archivedObj;
}

- (void)setUp {
    [super setUp];
    self.amplitude = [Amplitude alloc];

    [self.amplitude init];
    AMPTrackingOptions *opts = [AMPTrackingOptions options];
    XCTAssertTrue([opts shouldTrackIDFA]);
    [self.amplitude setTrackingOptions:opts];
    self.amplitude.sslPinningEnabled = NO;
}

- (void)tearDown {
    // Ensure all background operations are done
    [self.amplitude flushQueueWithQueue:self.amplitude.initializerQueue];
    [self.amplitude flushQueue];
    [super tearDown];
}

- (BOOL)archive:(id)rootObject toFile:(NSString *)path {
    _archivedObj = rootObject;
    return YES;
}

- (id)unarchive:(NSString *)path {
    return _archivedObj;
}

@end
