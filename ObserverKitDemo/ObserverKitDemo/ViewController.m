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
#import "NSObject+OKBind.h"

@interface ViewController ()
@property (nonatomic) NSInteger i;
@property (nonatomic) NSInteger j;
@property (nonatomic) NSInteger total;
@property (weak, nonatomic) IBOutlet UITextField *field1;
@property (weak, nonatomic) IBOutlet UITextField *field2;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) NSString *text;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ok_observer.control(self.field1, UIControlEventEditingChanged, ^(typeof (self) me, UITextField *field) {
        me.i = [field.text integerValue];
        
    }).control(self.field2, UIControlEventEditingChanged, ^(typeof(self)me, UITextField *field) {
        me.j = [field.text integerValue];
        
    }).keyPath(@[@"i", @"j"], ^(typeof(self)me, id newValue, id oldValue, NSString *path) {
        NSLog(@"%@: %@ -> %@", path, oldValue, newValue);
        me.total = me.i + me.j;
        me.text = [NSString stringWithFormat:@"%qi", (long long int) me.total];

    }).keyPath(@"total", ^(typeof(self)me, id val){
//        me.resultLabel.text = [NSString stringWithFormat:@"%ld", [val integerValue]];

    }).notification(UIApplicationDidReceiveMemoryWarningNotification, ^{
        NSLog(@"Did receive memory warning");
    });

    self.resultLabel.ok_bind(self, @"text <- total").rightToLeft(^id(id val) {
        return [NSString stringWithFormat:@"%@", val];
    });
}

@end
