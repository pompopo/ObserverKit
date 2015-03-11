//
//  OKObserver.m
//

#import "OKObserver.h"
#import "OKWorker.h"

@interface OKObserver ()
@property(nonatomic, weak) id owner;
@property(nonatomic, strong) NSMutableArray *workers;
@end

@implementation OKObserver

- (instancetype)initWithOwner:(id)owner {
    self = [super init];
    if (self) {
        _owner = owner;
        _workers = @[].mutableCopy;
    }
    return self;
}

- (OKObserver *(^)(id, id))notification {
    return ^OKObserver *(id obj, id block) {
        [self bindObject:obj
                   block:block
             constructor:^(id name, OKWorker *worker) {
                 [worker observeNotificationNamed:name];
             }];
        return self;
    };
}

- (OKObserver *(^)(id, id))keyPath {
    return ^OKObserver *(id obj, id block) {
        [self bindObject:obj
                   block:block
             constructor:^(id path, OKWorker *worker) {
                 [worker observeKeyPath:path];
             }];
        return self;
    };
}

- (OKObserver *(^)(id, UIControlEvents, id))control {
    return ^OKObserver *(id obj, UIControlEvents events, id block) {
        [self bindObject:obj
                   block:block
             constructor:^(id control, OKWorker *worker) {
                 [worker observeControl:control event:events];
             }];
        return self;
    };
}

- (OKObserver *(^)(id, id))control2 {
    return ^OKObserver *(id obj, id block) {
        [self bindObject:obj
                   block:block
             constructor:^(id control, OKWorker *worker) {
                 UIControlEvents events = [self defaultEventsForUIControl:control];
                 [worker observeControl:control event:events];
             }];
        return self;
    };
}

- (void)stopObservingWithOwner:(id)owner {
    [self.workers enumerateObjectsUsingBlock:^(OKWorker *worker, NSUInteger idx, BOOL *stop) {
        [worker stopWithOwner:owner];
    }];

    [self.workers removeAllObjects];
}

#pragma mark - Private

- (UIControlEvents)defaultEventsForUIControl:(UIControl *)control {
    if ([control isKindOfClass:[UIButton class]]) {
        return UIControlEventTouchUpInside;
    } else if ([control isKindOfClass:[UITextField class]]) {
        return UIControlEventEditingChanged;
    } else {
        return UIControlEventValueChanged;
    }
}

typedef void(^OKConstructorBlock)(id obj, OKWorker *worker);

- (void)bindObject:(id)objOrArray block:(id)block constructor:(OKConstructorBlock)constructor {
    NSArray *targets = nil;
    if ([objOrArray isKindOfClass:[NSArray class]]) {
        targets = objOrArray;
    } else {
        targets = @[objOrArray];
    }
    OKWorker *worker = [[OKWorker alloc] init];
    worker.owner = self.owner;
    worker.block = block;
    [self.workers addObject:worker];
    [targets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        constructor(obj, worker);
    }];

}

@end
