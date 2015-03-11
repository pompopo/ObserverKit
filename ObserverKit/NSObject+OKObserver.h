//
// NSObject+OKObserver.h
//

#import <Foundation/Foundation.h>

@class OKObserver;

@interface NSObject (OKObserver)
- (OKObserver *)ok_observer;
- (void)ok_stop;
@end