//
//  SwipeBackController.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/28/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeBackController.h"
#import "SwipeBackAnimator.h"

@interface SwipeBackController()

@property (nonatomic) SwipeBackAnimator *animator;

@property (nonatomic) SwipeBackContext *context;

@property (nonatomic) OneFingerDirectionalPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation SwipeBackController

- (id)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _context = [[SwipeBackContext alloc] initWithTarget:navigationController];
        _navigationController = navigationController;
        self.panGestureRecognizer.delegate = self;
        
        [navigationController.view addGestureRecognizer:_panGestureRecognizer];
        [self setNavigationControllerDelegate:navigationController.delegate];
        
        [_panGestureRecognizer requireGestureRecognizerToFail:navigationController.interactivePopGestureRecognizer];
    }
    return self;
}

- (void)dealloc {
    if (_panGestureRecognizer.view) {
        [_panGestureRecognizer.view removeGestureRecognizer:_panGestureRecognizer];
    }
}

- (BOOL)isEnable {
    return _context.isEnable;
}

- (void)setIsEnable:(BOOL)isEnable {
    _context.isEnable = isEnable;
    if (isEnable && !_panGestureRecognizer.view) {
        if (_navigationController) {
            [_navigationController.view addGestureRecognizer:_panGestureRecognizer];
        } else {
            if(_panGestureRecognizer.view) {
                [_panGestureRecognizer.view removeGestureRecognizer:_panGestureRecognizer];
            }
        }
    }
}

- (void)setNavigationControllerDelegate:(id<UINavigationControllerDelegate>)delegate {
    NSArray *delegates;
    if (delegate) {
        delegates = @[self, delegate];
    } else {
        delegates = @[self];
    }
    _context.navigationControllerDelegateProxy = [[NavigationControllerDelegateProxy alloc] initWithDelegates:delegates];
}

- (void)observePageViewController:(UIPageViewController *)pageViewController isFirstPage:(BOOL (^)(void))isFirstPage {
    UIScrollView *scrollView= [pageViewController.view.subviews firstObject];
    if (scrollView) {
        [scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
        [_context.pageViewControllerPanGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
        _isFirstPageOfPageViewController = isFirstPage;
    }
}

- (void)handlePanGesture:(OneFingerDirectionalPanGestureRecognizer *)recognizer {
    if (recognizer) {
        switch (recognizer.state) {
            case UIGestureRecognizerStateBegan:
                [self.context startTransition];
                break;
            case UIGestureRecognizerStateChanged:
                [self.context updateTransition:recognizer];
                break;
            case UIGestureRecognizerStateEnded:
                if ([_context allowTransitionFinish:recognizer]) {
                    [_context finishTransition];
                } else {
                    [_context cancelTransition];
                }
                break;
            case UIGestureRecognizerStateCancelled:
                [_context cancelTransition];
                break;
            default:
                break;
        }
    }
}

- (id)animator {
    if (!_animator) {
        _animator = [[SwipeBackAnimator alloc] initWithParent:self];
    }
    return _animator;
}

- (OneFingerDirectionalPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[OneFingerDirectionalPanGestureRecognizer alloc] initWithDirection:right target:self action:@selector(handlePanGesture:)];
    }
    return _panGestureRecognizer;
}

#pragma UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([_context pageViewControllerPanGestureRecognizer]) {
        if (_isFirstPageOfPageViewController) {
            BOOL isFirstPage;
            UIView *view = gestureRecognizer.view;
            isFirstPage = _isFirstPageOfPageViewController();
            if (gestureRecognizer != _context.pageViewControllerPanGestureRecognizer
                && isFirstPage
                && view
                && [self.panGestureRecognizer translationInView:view].x > 0) {
                return true;
            }
        }
        return false;
    }
    return _context.allowsTransitionStart;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}

#pragma UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    BOOL temp = (operation == UINavigationControllerOperationPop) && _context.isEnable && _context.interactiveTransition;
    return temp ? self.animator : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return [_context interactiveTransitionIfNeeded];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (animated && _context.isEnable) {
        _context.transitioning = true;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    _context.transitioning = false;
    [_panGestureRecognizer setEnabled:navigationController.viewControllers.count > 1];
}

@end
