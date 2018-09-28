//
//  OneFingerDirectionalPanGestureRecognizer.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/29/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "OneFingerDirectionalPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


@implementation OneFingerDirectionalPanGestureRecognizer

- (id)initWithDirection:(PanDirection)direciton target:(nullable id)target action:(nullable SEL)action; {
    self = [super initWithTarget:target action:action];
    self.direction = direciton;
    self.maximumNumberOfTouches = 1;
    self.cancelsTouchesInView = NO;
    self.delaysTouchesBegan = YES;
    return self;
}

- (instancetype)initWithDirection:(PanDirection)direciton
{
    self = [super init];
    if (self) {
        self = [self initWithDirection:direciton target:nil action:nil];
    }
    return self;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateBegan) {
        CGPoint vel = [self velocityInView:self.view];
        switch (_direction) {
            case up:
                if (fabs(vel.x) > fabs(vel.y) || vel.y >= 0) {
                    self.state = UIGestureRecognizerStateCancelled;
                }
                break;
            case down:
                if (fabs(vel.x) > fabs(vel.y) || vel.y <= 0) {
                    self.state = UIGestureRecognizerStateCancelled;
                }
                break;
            case left:
                if (fabs(vel.y) > fabs(vel.x) || vel.x >= 0) {
                    self.state = UIGestureRecognizerStateCancelled;
                }
                break;
            case right:
                if (fabs(vel.y) > fabs(vel.x) || vel.x <= 0) {
                    self.state = UIGestureRecognizerStateCancelled;
                }
                break;
            default:
                break;
        }
    }
}

@end
