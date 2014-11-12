//
// Created by pom on 2014/11/12.
// Copyright (c) 2014 com.gmail.pompopo. All rights reserved.
//

#import "OKWorker.h"

typedef void(^OKTwoArgumentsBlock)(id, id);
typedef void(^OKThreeArgumentsBlock)(id, id, id);

@implementation OKWorker

- (void)work:(NSNotification *)notification {
    OKTwoArgumentsBlock block = self.block;
    block(self.owner, notification);
}

- (void)work:(UIControl *)control event:(UIEvent *)event {
    OKThreeArgumentsBlock block = self.block;
    block(self.owner, control, event);
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    OKTwoArgumentsBlock block = self.block;
    block(self.owner, change[NSKeyValueChangeNewKey]);
}

@end
