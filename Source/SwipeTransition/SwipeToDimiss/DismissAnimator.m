//
//  DismissAnimator.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 9/5/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "DismissAnimator.h"
#import "SwipeToDismissConfiguration.h"

@interface DismissAnimator()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) SwipeToDismissController *parent;

@end

@implementation DismissAnimator

- (id)initWithParent:(SwipeToDismissController *)parent {
    self = [super init];
    if (self) {
        self.parent = parent;
    }
    return self;
}

#pragma UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return [SwipeToDismissConfiguration shareInstance].transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if(to && from) {
        [transitionContext.containerView insertSubview:to.view belowSubview:from.view];
        
        if (_parent.onStartTransition) {
            _parent.onStartTransition(transitionContext);
        }
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            from.view.transform = CGAffineTransformMakeTranslation(0, from.view.frame.size.height);
        } completion:^(BOOL finished) {
            from.view.transform = CGAffineTransformIdentity;
            if (weakSelf.parent.onFinishTransition) {
                weakSelf.parent.onFinishTransition(transitionContext);
            }
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            
        }];
        
        CFTimeInterval pauseTime = [from.view.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        from.view.layer.speed = 0.0;
        from.view.layer.timeOffset = pauseTime;
        
        // [workaround]
        // UIPercentDrivenInteractiveTransition.update() does not work at the moment of dismiss(animated:completion:)
        // Pause the animation for a while, to avoid the bugs
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([SwipeToDismissConfiguration shareInstance].animationWaitTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CFTimeInterval pauseTime = from.view.layer.timeOffset;
            from.view.layer.speed = 1.0;
            from.view.layer.timeOffset = 0.0;
            from.view.layer.beginTime = 0.0;
            CFTimeInterval timeSincePause = [from.view.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
            from.view.layer.beginTime = timeSincePause;
        });
    }
}

- (void)animationEnded:(BOOL)transitionCompleted {

}

@end
