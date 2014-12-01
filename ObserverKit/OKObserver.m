//
//  OKObserver.m
//

#import "OKObserver.h"
#import "OKWorker.h"
#import "NSMethodSignatureForBlock.m"

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
                 [[NSNotificationCenter defaultCenter] addObserver:worker
                                                          selector:@selector(work:)
                                                              name:name
                                                            object:nil];
             }];
        return self;
    };
}

- (OKObserver *(^)(id, id))keyPath {
    return ^OKObserver *(id obj, id block) {
        [self bindObject:obj
                   block:block
             constructor:^(id path, OKWorker *worker) {
                 [self.owner addObserver:worker
                              forKeyPath:path
                                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                 context:NULL];
             }];
        return self;
    };
}

- (OKObserver *(^)(id, UIControlEvents, id))control {
    return ^OKObserver *(id obj, UIControlEvents events, id block) {
        [self bindObject:obj
                   block:block
             constructor:^(id control, OKWorker *worker) {
                 [control addTarget:worker
                             action:@selector(work:event:)
                   forControlEvents:events];
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
                 [control addTarget:worker
                             action:@selector(work:event:)
                   forControlEvents:events];
             }];
        return self;
    };
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
