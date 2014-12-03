//
// Created by takemoto on 2014/12/03.
// Copyright (c) 2014 com.gmail.pompopo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKBinder.h"
@interface NSObject (OKBind)
- (OKBinder *(^)(NSObject *, NSString *))ok_bind;
@end