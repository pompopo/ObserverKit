#ObserverKit ![build](https://travis-ci.org/pompopo/ObserverKit.svg?branch=master) ![pod](http://img.shields.io/cocoapods/v/ObserverKit.svg) ![license](http://img.shields.io/cocoapods/l/ObserverKit.svg) ![platform](http://img.shields.io/cocoapods/p/ObserverKit.svg)

A simple library to use UIControl, NSNotification, Key Value Observing...
##Install
with CocoaPod
```
pod 'ObserverKit'

```
and
```
#import "OKObserver.h"
#import "NSObject+OKObserver.h" // Optional
```

##Example
```objectivec

self.ok_observer.control(self.field1, UIControlEventEditingChanged, ^(typeof (self) me, UITextField *field) {
    me.i = [field.text integerValue];

}).control(self.field2, UIControlEventEditingChanged, ^(typeof(self)me, UITextField *field) {
    me.j = [field.text integerValue];

}).keyPath(@[@"i", @"j"], ^(typeof(self)me, id newValue, id oldValue, NSString *path) {
    NSLog(@"%@: %@ -> %@", path, oldValue, newValue);
    me.total = me.i + me.j;

}).keyPath(@"total", ^(typeof(self)me, id val){
    me.resultLabel.text = [NSString stringWithFormat:@"%ld", [val integerValue]];

}).notification(UIApplicationDidReceiveMemoryWarningNotification, ^{
    NSLog(@"Did receive memory warning");
});
```
## Key Value Observing
```objectivec
// single key
self.ok_observer.keyPath(@"i", ^(typeof(self)me, id newValue, id oldValue) {
    NSLog(@"%@ -> %@", newValue, oldValue);
});

// multiple keys
self.ok_observer.keyPath(@[@"i", @"j"], ^(typeof(self)me, id newValue, id oldValue, NSString *keyPath) {
    if ([keyPath isEqualToString:@"i"]) {
        NSLog(@"i changed");
    } else {
        NSLog(@"j changed");
    }
});

// cast NSNumber, NSValue
self.ok_observer.keyPath(@"i", ^(typeof(self)me, NSInteger newValue) {
    // You don't have to write [newValue integerValue]
    if (newValue == 100) {
        ...
    }
});
```
## UIControl
```objectivec
// single control
self.ok_observer.control(self.button, UIControlEventTouchUpInside, ^(typeof(self)me, UIButton *button, UIEvent *event) {
    NSLog(@"button touched");
});

// multiple controls
self.ok_observer.control(@[self.buttonA, self.buttonB], ^(typeof(self)me, UIButton *button) {
    if (button.tag == 1) {
        NSLog(@"buttonA touched");
    } else {
        NSLog(@"buttonB touched");
    }
});
```

## NSNotification
```objectivec
// single notification
self.ok_observer.notification(UIApplicationDidReceiveMemoryWarningNotification, ^(id me, NSNotification *notification) {
    NSLog(@"memory warning");
});

// multiple notification
self.ok_observer.notification(@[UIKeyboardDidShowNotification, UIKeyboardDidHideNotification], ^{
    NSLog(@"Keyboard did show or hide");
});
```
##License
MIT License. See LICENSE.
