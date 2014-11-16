//
// OKWorker.h
//
// This is a private class. You don't have to use this.
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