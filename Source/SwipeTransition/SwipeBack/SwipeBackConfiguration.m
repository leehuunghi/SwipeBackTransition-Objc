//
//  SwipeBackConfiguration.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/31/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "SwipeBackConfiguration.h"

@implementation SwipeBackConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _transitionDuration = 0.3;
        _parallaxFactor = 0.3;
        _backViewDimness = 0.1;
        
    }
    return self;
}

+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken,^{
        instance = [[SwipeBackConfiguration alloc] init];
    });
    return instance;
}

@end
