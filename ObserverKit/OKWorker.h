//
// OKWorker.h
//
// This is a private class. You don't have to use this.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIControl;
@class UIEvent;

@interface OKWorker : NSObject
@property (nonatomic, weak) id owner;
@property (nonatomic, copy) id block;

- (void)observeNotificationNamed:(NSString *)name;
- (void)observeControl:(UIControl *)control event:(UIControlEvents)event;
- (void)observeKeyPath:(NSString *)keyPath;

- (void)stopWithOwner:(id)owner;
@end