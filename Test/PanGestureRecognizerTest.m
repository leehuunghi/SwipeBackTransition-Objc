//
//  PanGestureRecognizerTest.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 9/18/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "PanGestureRecognizerTest.h"
#import "AutoSwipeBack.h"

@implementation PanGestureRecognizerTest

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    _testAciton = action;
    _testTarget = target;
    self = [super initWithTarget:target action:action];
    return self;
}

- (void)performTouchWithLocation:(CGPoint)location andTranslation:(CGPoint)translation andState:(UIGestureRecognizerState)state {
    _testLocation = location;
    _testTranslation = translation;
    _testState = state;
    SEL testAction = _testAciton;
    if (testAction) {
        [_testTarget performSelector:testAction onThread:NSThread.currentThread withObject:self waitUntilDone:YES];
    }
}

@end
