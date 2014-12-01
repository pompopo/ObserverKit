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
@property(nonatomic) NSInteger i;
@property(nonatomic) NSInteger j;
@property(nonatomic) BOOL done;

@property(nonatomic) id idVar;
@property(nonatomic) BOOL boolVar;
@property(nonatomic) char charVar;
@property(nonatomic) double doubleVar;
@property(nonatomic) float floatVar;
@property(nonatomic) int intVar;
@property(nonatomic) NSInteger integerVar;
@property(nonatomic) long long longLongVar;
@property(nonatomic) long longVar;
@property(nonatomic) short shortVar;
@property(nonatomic) unsigned char unsignedCharVar;
@property(nonatomic) NSUInteger unsignedIntegerVar;
@property(nonatomic) unsigned long long unsignedLongLongVar;
@property(nonatomic) unsigned long unsignedLongVar;
@property(nonatomic) unsigned short unsignedShortVar;
@property(nonatomic) CGPoint CGPointVar;
@property(nonatomic) CGSize CGSizeVar;
@property(nonatomic) CGRect CGRectVar;
@end

@implementation ObserverKitDemoTests

- (void)setUp {
    [super setUp];
    self.done = NO;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testConnection {
    XCTAssertNotNil(self.ok_observer.keyPath(@"i", ^{}));
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    XCTAssertNotNil(self.ok_observer.control(button, UIControlEventTouchUpInside, ^{}));
    XCTAssertNotNil(self.ok_observer.control2(button, ^{}));
    XCTAssertNotNil(self.ok_observer.notification(@"i", ^{}));
}

- (void)testKeyPath {
    self.i = 100;
    self.j = 200;
    __block int numberOfTests = 0;

    self.ok_observer.keyPath(@"i", ^(typeof(self) me, id newVal, id oldVal, NSString *path) {
        XCTAssert(self == me);
        XCTAssert([newVal integerValue] == 101);
        XCTAssert([oldVal integerValue] == 100);
        XCTAssert([path isEqualToString:@"i"]);
        numberOfTests++;
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
        numberOfTests++;

    });
    self.i = 101;
    self.j = 201;
    while (numberOfTests != 3) {
        sleep(1);
    }
}

- (void)testCasts {
    __block int numberOfTests = 0;
    self.ok_observer.keyPath(@"idVar", ^(id me, id val) {
        XCTAssert(val == self.idVar);
        numberOfTests++;
    }).keyPath(@"boolVar", ^(id me, BOOL val) {
        XCTAssert(val == YES);
        numberOfTests++;
    }).keyPath(@"charVar", ^(id me, char val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"doubleVar", ^(id me, double val) {
        XCTAssert(val == 1.0);
        numberOfTests++;
    }).keyPath(@"floatVar", ^(id me, float val) {
        XCTAssert(val == 1.0);
        numberOfTests++;
    }).keyPath(@"intVar", ^(id me, int val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"integerVar", ^(id me, NSInteger val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"longLongVar", ^(id me, long long val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"longVar", ^(id me, long val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"shortVar", ^(id me, short val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"unsignedCharVar", ^(id me, unsigned char val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"unsignedIntegerVar", ^(id me, NSUInteger val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"unsignedLongLongVar", ^(id me, unsigned long long val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"unsignedLongVar", ^(id me, unsigned long val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"unsignedShortVar", ^(id me, unsigned short val) {
        XCTAssert(val == 1);
        numberOfTests++;
    }).keyPath(@"CGPointVar", ^(id me, CGPoint val) {
        XCTAssert(val.x == 1);
        XCTAssert(val.y == 1);
        numberOfTests++;
    }).keyPath(@"CGSizeVar", ^(id me, CGSize val) {
        XCTAssert(val.height == 1);
        XCTAssert(val.width == 1);
        numberOfTests++;
    }).keyPath(@"CGRectVar", ^(id me, CGRect val) {
        XCTAssert(val.origin.x == 1);
        XCTAssert(val.origin.y == 1);
        XCTAssert(val.size.height == 1);
        XCTAssert(val.size.width == 1);
        numberOfTests++;
    });

    self.idVar = @1;
    self.boolVar = YES;
    self.charVar = 1;
    self.doubleVar = 1.0;
    self.floatVar = 1.0;
    self.intVar = 1;
    self.integerVar = 1;
    self.longLongVar = 1;
    self.longVar = 1;
    self.shortVar = 1;
    self.unsignedCharVar = 1;
    self.unsignedIntegerVar = 1;
    self.unsignedLongLongVar = 1;
    self.unsignedLongVar = 1;
    self.unsignedShortVar = 1;
    self.CGPointVar = CGPointMake(1, 1);
    self.CGSizeVar = CGSizeMake(1, 1);
    self.CGRectVar = CGRectMake(1, 1, 1, 1);
    while (numberOfTests != 18) {
        sleep(1);
    }

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

- (void)testControl2 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ok_observer.control2(button, ^(typeof(self) me, UIControl *control) {
        XCTAssert(control == button);
        me.done = YES;
    });
    [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    while (!self.done) {
        sleep(1);
    }
}

- (void)testControl2TwoButtons {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ok_observer.control2(@[button, button2], ^(typeof(self) me, UIControl *control) {
        XCTAssert(control == button);
        me.done = YES;
    });
    [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    while (!self.done) {
        sleep(1);
    }
}

- (void)testNotification {
    self.ok_observer.notification(@"OKObserverTestNotification", ^(typeof(self) me, NSNotification *notification) {
        XCTAssert([notification.name isEqualToString:@"OKObserverTestNotification"]);

        me.done = YES;
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OKObserverTestNotification" object:nil];
    while (!self.done) {
        sleep(1);
    }

}
@end
