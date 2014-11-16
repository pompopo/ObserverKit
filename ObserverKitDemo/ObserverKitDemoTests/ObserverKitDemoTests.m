//
//  ObserverKitDemoTests.m
//  ObserverKitDemoTests
//
//  Created by pom on 2014/11/12.
//  Copyright (c) 2014年 com.gmail.pompopo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSObject+OKObserver.h"
#import "OKObserver.h"
@interface ObserverKitDemoTests : XCTestCase
@property (nonatomic) NSInteger i;
@property (nonatomic) NSInteger j;
@property (nonatomic) BOOL done;
@end

@implementation ObserverKitDemoTests

- (void)setUp {
    [super setUp];
    self.done = NO;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testKeyPath {
    self.i = 100;
    self.j = 200;
    self.ok_observer.keyPath(@"i", ^(typeof(self)me, id newVal, id oldVal, NSString *path) {
        XCTAssert(self == me);
        XCTAssert([newVal integerValue] == 101);
        XCTAssert([oldVal integerValue] == 100);
        XCTAssert([path isEqualToString:@"i"]);
    }).keyPath(@[@"i", @"j"], ^(id me, id newVal, id oldVal, NSString *path) {
        XCTAssert(self == me);
        if ([path isEqualToString:@"j"]) {
            XCTAssert([newVal integerValue] == 201);
            XCTAssert([oldVal integerValue] == 200);
        } else if ([path isEqualToString:@"i"]) {
            XCTAssert([newVal integerValue] == 101);
            XCTAssert([oldVal integerValue] == 100);
        } else {
            XCTFail();
        }
    });
    self.i = 101;
    self.j = 201;
}

- (void)testControl {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ok_observer.control(button, UIControlEventTouchUpInside, ^(typeof(self) me, UIControl *control) {
        XCTAssert(control == button);
        me.done = YES;
    });
    [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    while (!self.done) {
        sleep(1);
    }
}

- (void)testNotification {
    self.ok_observer.notification(@"OKObserverTestNotification", ^(typeof(self)me, NSNotification *notification) {
        XCTAssert([notification.name isEqualToString:@"OKObserverTestNotification"]);

        me.done = YES;
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OKObserverTestNotification" object:nil];
    while (!self.done) {
        sleep(1);
    }
    
}
@end
