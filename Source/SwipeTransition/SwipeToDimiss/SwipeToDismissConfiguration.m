//
//  SwipeToDismissConfiguration.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 9/5/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "SwipeToDismissConfiguration.h"

@implementation SwipeToDismissConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        _transitionDuration = 0.3;
        _dismissHeightRatio = 0.3;
        _dismissSwipeSpeed = 1600;
        _animationWaitTime = 0.01;
    }
    return self;
}

+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken,^{
        instance = [[SwipeToDismissConfiguration alloc] init];
    });
    return instance;
}

@end
