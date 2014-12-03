//
// Created by takemoto on 2014/12/03.
// Copyright (c) 2014 com.gmail.pompopo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OKBinder : NSObject
@property (nonatomic, weak, readonly) NSObject *source;
@property (nonatomic, weak, readonly) NSObject *target;

- (void)bind:(NSString *)expression target:(NSObject *)target source:(NSObject *)source;
- (OKBinder *(^)(id(^)(id)))leftToRight;
- (OKBinder *(^)(id(^)(id)))rightToLeft;
@end
