//
// NSObject+OKObserver.m
//

#import "NSObject+OKObserver.h"
#import "OKObserver.h"
#import <objc/runtime.h>

const char *ObserverKey = "OKObserverKit.OKObserver";
@implementation NSObject (OKObserver)
- (OKObserver *)ok_observer {
    OKObserver *observer = objc_getAssociatedObject(self, ObserverKey);
    if (observer == nil) {
        observer = [[OKObserver alloc] initWithOwner:self];
        objc_setAssociatedObject(self, ObserverKey, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return observer;
}

- (void)ok_stop {
    if (objc_getAssociatedObject(self, ObserverKey) != nil) {
        [self.ok_observer stopObservingWithOwner:self];
    }
}


@end