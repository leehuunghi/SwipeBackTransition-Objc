//
//  SwipeBackAnimator.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/30/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "SwipeBackAnimator.h"
#import <CoreGraphics/CoreGraphics.h>

@interface SwipeBackAnimator()

@property (nonatomic, weak) SwipeBackController *parent;

@property (nonatomic, weak) UIView *toView;

@end

@implementation SwipeBackAnimator

- (id)initWithParent:(SwipeBackController *)parent {
    self = [super init];
    if (self) {
        self.parent = parent;
    }
    return self;
}

#pragma UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return [SwipeBackConfiguration shareInstance].transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [transitionContext.containerView insertSubview:to.view belowSubview:from.view];
    _toView = to.view;
    
    //parallax effect
    CGAffineTransform tranform = CGAffineTransformIdentity;
    tranform.tx = -transitionContext.containerView.bounds.size.width * [SwipeBackConfiguration shareInstance].parallaxFactor;
    to.view.transform = tranform;
    
    //dim the back view
    UIView *dimmedView = [[UIView alloc] initWithFrame:to.view.bounds];
    dimmedView.backgroundColor = [[UIColor alloc] initWithWhite:0 alpha:[SwipeBackConfiguration shareInstance].backViewDimness];
    [to.view addSubview:dimmedView];

    if(_parent.onStartTransition) {
        _parent.onStartTransition(transitionContext);
    }
    __weak typeof(self)weakSelf = self;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        to.view.transform = CGAffineTransformIdentity;
        from.view.transform = CGAffineTransformMakeTranslation(to.view.frame.size.width, 0);
//        from.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(to.view.frame.size.width, 0);
        dimmedView.alpha = 0;
    } completion:^(BOOL finished) {
        [dimmedView removeFromSuperview];
        from.view.transform = CGAffineTransformIdentity;
//        from.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        if (weakSelf) {
            if(weakSelf.parent.onFinishTransition) {
                weakSelf.parent.onFinishTransition(transitionContext);
            }
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)animationEnded:(BOOL)transitionCompleted {
    if (!transitionCompleted) {
        if (_toView) {
            _toView.transform = CGAffineTransformIdentity;
        }
    }
}

@end
