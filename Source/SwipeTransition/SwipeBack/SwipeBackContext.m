//
//  SwipeBackContext.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/29/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "SwipeBackContext.h"

@interface SwipeBackContext()

@property (nonatomic) float originX;

@end

@implementation SwipeBackContext

- (BOOL)allowsTransitionStart {
    UINavigationController *navigationController = self.targetContext;
    if (navigationController) {
        return navigationController.viewControllers.count > 1 && [super allowsTransitionStart];
    } else {
        return false;
    }
}

- (BOOL)allowTransitionFinish:(UIPanGestureRecognizer *)recognizer {
    UIView *view = self.targetView;
    if (view) {
        return [recognizer velocityInView:view].x > 0;
    } else {
        return false;
    }
}

- (void)updateTransition:(UIPanGestureRecognizer *)recognizer {
    UIView *view = self.targetView;
    if (view && [self isEnable]) {
        CGPoint translation = [recognizer translationInView:view];
        if (self.interactiveTransition) {
            [self.interactiveTransition update:translation.x maxValue:view.bounds.size.width];
            UINavigationController *navigation = self.targetContext;
            NSArray* views = [navigation.navigationBar subviews];
            for (UIView* view in views) {
                if (view.class == NSClassFromString(@"_UINavigationBarContentView")) {
                    NSArray *sub = [view subviews];
                    for (UIView *subView in sub) {
                        if (subView.class != NSClassFromString(@"_UIButtonBarButton")) {
                            if (!_originX) {
                                _originX = subView.frame.origin.x;
                            };
                            [subView setFrame:(CGRectMake(_originX + translation.x, subView.frame.origin.y, subView.frame.size.width, subView.frame.size.height))];
                        }
                    }
                }
            }
        }
    } else {
        return;
    }
}

- (UIView *)targetView {
    return [self.target view];
}

- (InteractiveTransition *)interactiveTransitionIfNeeded {
    return self.isEnable ? self.interactiveTransition : nil;
}

- (void)setNavigationControllerDelegateProxy:(NavigationControllerDelegateProxy *)navigationControllerDelegateProxy {
    _navigationControllerDelegateProxy = navigationControllerDelegateProxy;
    if (self.targetContext) {
        [self.targetContext setDelegate:navigationControllerDelegateProxy];
    }
}

#pragma TransitionHandleable

- (void)didStartTransition {
    if (self.targetContext) {
        UINavigationController *navigation = self.targetContext;
        [navigation popViewControllerAnimated:YES];
    }
}

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

- (void)didFinishTransition {
    UINavigationController *navigation = self.targetContext;
    [navigation.navigationBar.topItem.titleView setHidden:NO];
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

@end
