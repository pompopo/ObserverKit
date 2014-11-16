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
@end
