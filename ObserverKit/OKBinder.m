//
// Created by takemoto on 2014/12/03.
// Copyright (c) 2014 com.gmail.pompopo. All rights reserved.
//

#import "OKBinder.h"
#import "NSObject+OKObserver.h"
#import "OKObserver.h"
static const NSString *OKBinderDirectionLeft = @"<-";
static const NSString *OKBinderDirectionRight = @"->";
static const NSString *OKBinderDirectionBoth = @"<>";

typedef id(^ConverterBlock)(id);

@interface OKBinder()
@property (nonatomic, copy) ConverterBlock leftToRightConverter;
@property (nonatomic, copy) ConverterBlock rightToLeftConverter;
@end

@implementation OKBinder
- (void)bind:(NSString *)expression target:(NSObject *)target source:(NSObject *)source {
    _source = source;
    _target = target;

    NSArray *components = [expression componentsSeparatedByString:@" "];
    NSString *targetPath = nil;
    NSString *sourcePath = nil;
    BOOL leftToRight = NO;
    BOOL rightToLeft = NO;
    if (components.count == 1) {
        sourcePath = [@"source." stringByAppendingString:components[0]];
        targetPath = [@"target." stringByAppendingString:components[0]];
    } else if (components.count == 3) {
        sourcePath = [@"source." stringByAppendingString:components[2]];
        targetPath = [@"target." stringByAppendingString:components[0]];
        if ([OKBinderDirectionLeft isEqualToString:components[1]]) {
            rightToLeft = YES;
        } else if ([OKBinderDirectionRight isEqualToString:components[1]]) {
            leftToRight = YES;
        } else if ([OKBinderDirectionBoth isEqualToString:components[1]]) {
            rightToLeft = YES;
            leftToRight = YES;
        }
    }

    if (leftToRight) {
        self.ok_observer.keyPath(targetPath, ^(OKBinder *weakBinder, id value) {
            if (weakBinder.leftToRightConverter != nil) {
                value = weakBinder.leftToRightConverter(value);
            }
            [weakBinder setValue:value forKeyPath:sourcePath];
        });
    }
    if (rightToLeft) {
        self.ok_observer.keyPath(sourcePath, ^(typeof(self) weakBinder, id value) {
            if (weakBinder.rightToLeftConverter != nil) {
                value = weakBinder.rightToLeftConverter(value);
            }
            [weakBinder setValue:value forKeyPath:targetPath];
        });
    }
}

- (OKBinder *(^)(id(^)(id)))leftToRight {
    return ^OKBinder *(id (^block)(id) ) {
        self.leftToRightConverter = block;
        return self;
    };
}

- (OKBinder *(^)(id(^)(id)))rightToLeft {
    return ^OKBinder *(id (^block)(id) ) {
        self.rightToLeftConverter = block;
        return self;
    };
}


@end