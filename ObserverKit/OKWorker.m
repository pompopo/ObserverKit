//
// OKWorker.m
//

#import "OKWorker.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSMethodSignatureForBlock.m"
typedef void(^OKOneArgumentBlock)(id);
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

    NSMethodSignature *signature = NSMethodSignatureForBlock(self.block);
    id newValue = change[NSKeyValueChangeNewKey];
    id oldValue = change[NSKeyValueChangeOldKey];
    #define call_block(type, arg1, arg2) (^(){ \
                void(^block)(id, type, type, id); \
                block = self.block; \
                block(self.owner, arg1, arg2, keyPath); \
            })()


    if (signature.numberOfArguments > 2) {
        const char *type = [signature getArgumentTypeAtIndex:2];
        if (strcmp(type, @encode(id)) == 0) {
            call_block(id, newValue, oldValue);
        } else if (strcmp(type, @encode(BOOL)) == 0) {
            call_block(BOOL, [newValue boolValue], [oldValue boolValue]);
        } else if (strcmp(type, @encode(char)) == 0) {
            call_block(char, [newValue charValue], [oldValue charValue]);
        } else if (strcmp(type, @encode(double)) == 0) {
            call_block(double, [newValue doubleValue], [oldValue doubleValue]);
        } else if (strcmp(type, @encode(float)) == 0) {
            call_block(float, [newValue floatValue], [oldValue floatValue]);
        } else if (strcmp(type, @encode(int)) == 0) {
            call_block(int, [newValue intValue], [oldValue intValue]);
        } else if (strcmp(type, @encode(NSInteger)) == 0) {
            call_block(NSInteger, [newValue integerValue], [oldValue integerValue]);
        } else if (strcmp(type, @encode(long long)) == 0) {
            call_block(long long, [newValue longLongValue], [oldValue longLongValue]);
        } else if (strcmp(type, @encode(long)) == 0) {
            call_block(long, [newValue longValue], [oldValue longValue]);
        } else if (strcmp(type, @encode(short)) == 0) {
            call_block(short, [newValue shortValue], [oldValue shortValue]);
        } else if (strcmp(type, @encode(unsigned char)) == 0) {
            call_block(unsigned char, [newValue unsignedCharValue], [oldValue unsignedCharValue]);
        } else if (strcmp(type, @encode(NSUInteger)) == 0) {
            call_block(NSUInteger, [newValue unsignedIntegerValue], [oldValue unsignedIntegerValue]);
        } else if (strcmp(type, @encode(unsigned int)) == 0) {
            call_block(unsigned int, [newValue unsignedIntValue], [oldValue unsignedIntValue]);
        } else if (strcmp(type, @encode(unsigned long long)) == 0) {
            call_block(unsigned long long, [newValue unsignedLongLongValue], [oldValue unsignedLongLongValue]);
        } else if (strcmp(type, @encode(unsigned long)) == 0) {
            call_block(unsigned long, [newValue unsignedLongValue], [oldValue unsignedLongValue]);
        } else if (strcmp(type, @encode(unsigned short)) == 0) {
            call_block(unsigned short, [newValue unsignedShortValue], [oldValue unsignedShortValue]);
        } else if (strcmp(type, @encode(CGPoint)) == 0) {
            call_block(CGPoint, [newValue CGPointValue], [oldValue CGPointValue]);
        } else if (strcmp(type, @encode(CGSize)) == 0) {
            call_block(CGSize, [newValue CGSizeValue], [oldValue CGSizeValue]);
        } else if (strcmp(type, @encode(CGRect)) == 0) {
            call_block(CGRect, [newValue CGRectValue], [oldValue CGRectValue]);
        } else {
            // Unsupported type
            OKFourArgumentsBlock block = self.block;
            block(self.owner, newValue, oldValue, keyPath);
        }
    } else {
        OKOneArgumentBlock block = self.block;
        block(self.owner);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
