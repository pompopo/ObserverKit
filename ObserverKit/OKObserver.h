//
//  OKObserver.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface OKObserver : NSObject

- (instancetype)initWithOwner:(id)owner;

- (OKObserver *(^)(id, id))notification;

- (OKObserver *(^)(id, id))keyPath;

- (OKObserver *(^)(id, UIControlEvents, id))control;
@end
