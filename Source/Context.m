//
//  Context.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/27/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "Context.h"

@interface Context()

@property (nonatomic) Target *target;

@end

@implementation Context

- (id)initWithTarget:(Target *)target {
    self = [super init];
    if (self) {
        _isEnable = true;
        _transitioning = false;
        _target = target;
    }
    return self;
}

- (void)setInteractiveTransition:(InteractiveTransition *)interactiveTransition {
    _interactiveTransition = interactiveTransition;
    _transitioning = _interactiveTransition != nil;
}

- (BOOL)allowsTransitionStart {
    return !_transitioning && _isEnable;
}

- (Target *)targetContext {
    return _target;
}

@end
