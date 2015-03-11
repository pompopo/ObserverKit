//
//  ViewController.m
//  ObserverKitDemo
//
//  Created by pom on 2014/11/12.
//  Copyright (c) 2014年 com.gmail.pompopo. All rights reserved.
//

#import "ViewController.h"
#import "OKObserver.h"
#import "NSObject+OKObserver.h"

@interface Foo : NSObject
@property (nonatomic) NSInteger i;
@end
@implementation Foo
@end
@interface ViewController ()
@property(nonatomic) NSInteger i;
@property(nonatomic) NSInteger j;
@property(nonatomic) NSInteger total;
@property(weak, nonatomic) IBOutlet UITextField *field1;
@property(weak, nonatomic) IBOutlet UITextField *field2;
@property(weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic) Foo *foo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ok_observer.control(self.field1, UIControlEventEditingChanged, ^(typeof(self) me, UITextField *field) {
        me.i = [field.text integerValue];

    }).control(self.field2, UIControlEventEditingChanged, ^(typeof(self) me, UITextField *field) {
        me.j = [field.text integerValue];

    }).keyPath(@[@"i", @"j"], ^(typeof(self) me, id newValue, id oldValue, NSString *path) {
        NSLog(@"%@: %@ -> %@", path, oldValue, newValue);
        me.total = me.i + me.j;

    }).keyPath(@"total", ^(typeof(self) me, id val) {
        me.resultLabel.text = [NSString stringWithFormat:@"%ld", [val integerValue]];

    }).notification(UIApplicationDidReceiveMemoryWarningNotification, ^{
        NSLog(@"Did receive memory warning");
    });
    __weak id obj = nil;
    @autoreleasepool {
        ViewController *controller = [[ViewController alloc] init];
        obj = controller;

        controller.ok_observer.notification(UIApplicationDidReceiveMemoryWarningNotification, ^{
            NSLog(@"fua-");
        });
        controller.i = 100;

        NSLog(@"obj = %@", obj);
    }

    NSLog(@"obj = %@", obj);

    self.foo = [[Foo alloc] init];
    self.ok_observer.keyPath(@"foo.i", ^(typeof(self)me, NSInteger newValue){
        NSLog(@"foo.i changed: %d", newValue);
    });

    self.foo.i = 1000;
    self.foo = nil;
}

- (void)dealloc {
//    [self ok_stop];
    NSLog(@"DEALLOC");
}
@end

