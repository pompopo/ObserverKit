//
//  OKObserver.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface OKObserver : NSObject

/**
* You must use this to init observer.
* Owner must have a strong reference to observer.
*/
- (instancetype)initWithOwner:(id)owner;

/**
* NSNotification handler.
* notification(NSString* or NSArray* name, id block)
* block can be
*   ^() {}
*   ^(typeof(owner) owner) {}
*   ^(typeof(owner) owner, NSNotification *notification) {}
*/
- (OKObserver *(^)(id, id))notification;

/**
* Key Value Observing handler.
* keypath(NSString* or NSArray* path, id block)
* block can be
*   ^() {}
*   ^(typeof(owner) owner) {}
*   ^(typeof(owner) owner, id newValue) {}
*   ^(typeof(owner) owner, id newValue, id oldValue) {}
*   ^(typeof(owner) owner, id newValue, id oldValue, NSString *keyPath) {}
*/
- (OKObserver *(^)(id, id))keyPath;

/**
* UIControl event handler.
* control(UIControl* or NSArray* control, UIControlEvents events, id block)
* block can be
*   ^() {}
*   ^(typeof(owner) owner) {}
*   ^(typeof(owner) owner, UIControl *control) {}
*   ^(typeof(owner) owner, UIControl *control, UIEvent *event) {}
*/
- (OKObserver *(^)(id, UIControlEvents, id))control;

/**
* convenience version of -[OKObserver control]
* control(UIControl* or NSArray* control, id block)
* block can be
*   ^() {}
*   ^(typeof(owner) owner) {}
*   ^(typeof(owner) owner, UIControl *control) {}
*   ^(typeof(owner) owner, UIControl *control, UIEvent *event) {}
*
*  Automatically select UIControlEvents.
*   UIButton -> UIControlEventTouchUpInside
*   UITextField -> UIControlEventEditingChanged
*   others -> UIControlEventValueChanged
*/
- (OKObserver *(^)(id, id))control2;

/**
* Stop all observations.
* You must call this in thw owner's dealloc method.
*
* @param owner pass the object used in initWithOwner:
*
* or use -[NSObject ok_stop];
*/
- (void)stopObservingWithOwner:(id)owner;
@end
