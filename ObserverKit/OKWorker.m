//
// OKWorker.m
//

#import "OKWorker.h"

typedef void(^OKTwoArgumentsBlock)(id, id);
typedef void(^OKThreeArgumentsBlock)(id, id, id);
typedef void(^OKFourArgumentsBlock)(id, id, id, id);

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
    OKFourArgumentsBlock block = self.block;
    block(self.owner, change[NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey], keyPath);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
