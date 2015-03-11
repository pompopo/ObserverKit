//
//  DeallocTests.m
//  ObserverKitDemo
//
//  Created by pompopo on 2015/03/11.
//  Copyright (c) 2015年 com.gmail.pompopo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OKObserver.h"
#import "NSObject+OKObserver.h"
@interface HogeObject : NSObject
@property (nonatomic) NSInteger i;
@end
@implementation HogeObject
- (void)dealloc {
    [self ok_stop];
}
@end

@interface DeallocTests : XCTestCase
@property (nonatomic) HogeObject *hoge;
@end

@implementation DeallocTests

- (void)setUp {
    [super setUp];
    self.hoge = [[HogeObject alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDeallocWithoutObserving {
    self.hoge = nil;
}

- (void)testNotification {
    self.hoge.ok_observer.notification(@"HogeNotification", ^{
        XCTFail();
    });
    self.hoge = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HogeNotification" object:nil];
}

- (void)testKVO {
    self.hoge.ok_observer.keyPath(@"i", ^{
        XCTFail();
    });
    self.hoge = nil;
    self.hoge.i = 1000;
}

- (void)testControl {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.hoge.ok_observer.control2(button, ^{
        XCTFail();
    });
    self.hoge = nil;
    [button sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
