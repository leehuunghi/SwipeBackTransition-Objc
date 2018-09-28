//
//  SwipeToDimissContext.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/27/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "SwipeToDismissContext.h"
#import "SwipeToDismissConfiguration.h"

@implementation SwipeToDismissContext

- (BOOL)allowsTransitionFinish:(CGFloat)swipeVelocity {
    BOOL swipeSpeedCheck = [SwipeToDismissConfiguration shareInstance].dismissSwipeSpeed < swipeVelocity;
    return self.interactiveTransition.percentComplete > [SwipeToDismissConfiguration shareInstance].dismissHeightRatio || swipeSpeedCheck;
}

- (CGPoint)velocity:(UIPanGestureRecognizer *)recoginzer {
    UIView *view = self.targetView;
    if (view) {
        return [recoginzer velocityInView:view];
    } else {
        return CGPointZero;
    }
}

- (InteractiveTransition *)interactiveTransitionIfNeeded {
    return self.isEnable ? self.interactiveTransition : nil;
}

- (void)didStartTransition {
    if ([self targetContext]) {
        UIViewController *viewController = self.targetContext;
        [viewController dismissViewControllerAnimated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((DISPATCH_TIME_NOW +[SwipeToDismissConfiguration shareInstance].animationWaitTime) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            InteractiveTransition *interactionTransition = self.interactiveTransition;
            if (interactionTransition) {
                [interactionTransition updateInteractiveTransition:interactionTransition.percentComplete];
            } else {
                return;
            }
        });
    }
}

- (void)updateTransitionWithRecognizer:(UIPanGestureRecognizer *)recognizer {
    UIView *view = self.targetView;
    if (view && self.isEnable) {
        [self updateTransitionWithTranslationY:[recognizer translationInView:view].y];
    } else {
        return;
    }
}

- (void)updateTransitionWithTranslationY:(CGFloat)translationY {
    UIView *view = self.targetView;
    if (view && self.isEnable) {
        [self.interactiveTransition update:MAX(translationY, 0) maxValue:view.bounds.size.height];
    } else {
        return;
    }
}

- (UIView *)targetView {
    return self.target ? [self.target view] : nil;
}

#pragma TransitionHandleable

- (void)startTransition {
    if (self.allowsTransitionStart) {
        self.interactiveTransition = [InteractiveTransition new];
        [self didStartTransition];
    }
}

- (void)finishTransition {
    if (self.interactiveTransition) {
        [self.interactiveTransition finishInteractiveTransition];
    }
    self.interactiveTransition = nil;
    [self didFinishTransition];
}

- (void)cancelTransition {
    if (self.interactiveTransition) {
        [self.interactiveTransition cancelInteractiveTransition];
    }
    self.interactiveTransition = nil;
    [self didCancelTransition];
}

- (void)didCancelTransition {
    
}

- (void)didFinishTransition {
    
}

@end
