//
//  InteractiveTransition.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/30/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "InteractiveTransition.h"

@implementation InteractiveTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.completionCurve = UIViewAnimationCurveLinear;
    }
    return self;
}

- (void)update:(CGFloat)value maxValue:(CGFloat)maxValue {
    CGFloat percentComplete = value > 0 ? value / maxValue : 0;
    NSLog(@"percent %f", percentComplete);
    [self updateInteractiveTransition:percentComplete];
}

@end
