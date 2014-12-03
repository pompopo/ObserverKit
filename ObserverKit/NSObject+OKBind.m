//
// Created by takemoto on 2014/12/03.
// Copyright (c) 2014 com.gmail.pompopo. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+OKBind.h"

@implementation NSObject (OKBind)
- (OKBinder * (^)(NSObject *, NSString *))ok_bind {
    return ^(NSObject *object, NSString *string) {
        OKBinder *binder = [[OKBinder alloc] init];
        [binder bind:string target:self source:object];
        objc_setAssociatedObject(self, @"okbinder", binder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return binder;
    };
}

@end