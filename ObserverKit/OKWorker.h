//
// Created by pom on 2014/11/12.
// Copyright (c) 2014 com.gmail.pompopo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIControl;
@class UIEvent;

@interface OKWorker : NSObject
@property (nonatomic, weak) id owner;
@property (nonatomic, copy) id block;

- (void)work:(NSNotification *)notification;
- (void)work:(UIControl *)control event:(UIEvent *)event;
@end