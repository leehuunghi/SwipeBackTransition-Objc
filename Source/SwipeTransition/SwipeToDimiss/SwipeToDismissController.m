//
//  SwipeToDismissController.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/27/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//
#import "SwipeToDismissController.h"
#import "OneFingerDirectionalPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "DismissAnimator.h"
#import "SwipeToDismissContext.h"

@interface SwipeToDismissController()

@property (nonatomic) DismissAnimator *animator;

@property (nonatomic) SwipeToDismissContext *context;

@property (nonatomic) OneFingerDirectionalPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation SwipeToDismissController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.panGestureRecognizer addTarget:self action:@selector(handlePanGesture:)];
        self.isEnable = true;
        
    }
    return self;
}

- (void)dealloc {
    [self removeTargetViewController];
}

- (OneFingerDirectionalPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[OneFingerDirectionalPanGestureRecognizer alloc] initWithDirection:down];
    }
    return _panGestureRecognizer;
}

- (DismissAnimator *)animator {
    if (!_animator) {
        _animator = [[DismissAnimator alloc] initWithParent:self];
    }
    return _animator;
}

- (void)handlePanGesture:(OneFingerDirectionalPanGestureRecognizer *)recognizer {
    UIScrollView *scrollView = _context.observedScrollView;
    UIView *targetView = _context.targetView;
    if (scrollView && targetView) {
        if (scrollView.contentOffset.y <= [self baseY:scrollView] && [self.panGestureRecognizer translationInView:targetView].y > 0) {
            CGPoint temp;
            temp.y = [self baseY:scrollView];
            temp.x = scrollView.contentOffset.x;
            scrollView.contentOffset = temp;
            scrollView.panGestureRecognizer.state = UIGestureRecognizerStateFailed;
            _context.observedScrollView = nil;
            if ((recognizer.state != UIGestureRecognizerStateBegan)) {
                [_context startTransition];
            }
        } else if (!_context.transitioning) {
            return;
        }
    }
    NSLog(@"%ld", (long)recognizer.state);
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [_context startTransition];
            break;
        case UIGestureRecognizerStateChanged:
            [_context updateTransitionWithRecognizer:recognizer];
            break;
        case UIGestureRecognizerStateEnded:
            if ([_context allowsTransitionFinish:[_context velocity:recognizer].y]) {
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

- (void)setIsEnable:(BOOL)isEnable {
    _isEnable = isEnable;
    if (_context) {
        _context.isEnable = isEnable;
    }
    [self.panGestureRecognizer setEnabled:isEnable];
}


- (void)setTargetWithViewController:(UIViewController *)viewController {
    UIViewController *targetViewController = viewController.navigationController;
    if (!targetViewController) {
        targetViewController = viewController;
    }
    _context = [[SwipeToDismissContext alloc] initWithTarget:targetViewController];
    _context.isEnable = self.isEnable;
    
    targetViewController.transitioningDelegate = self;
    self.panGestureRecognizer.delegate = self;
    
    [targetViewController.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)removeTargetViewController {
    if (_context) {
        if (_context.targetContext) {
            [_context.targetContext setTransitioningDelegate:nil];
            _context = nil;
            if (self.panGestureRecognizer.view) {
                [self.panGestureRecognizer.view removeGestureRecognizer:self.panGestureRecognizer];
            }
        }
    }
}

#pragma UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return [_context allowsTransitionStart];
}

- (CGFloat)baseY:(UIScrollView *)scrollView {
    if (@available(iOS 11, *)) {
        return -scrollView.safeAreaInsets.top;
    } else {
        return -scrollView.contentInset.top;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    UIScrollView *scrollView = otherGestureRecognizer.view;
    if (scrollView) {
        NSString *scrollViewType = NSStringFromClass([scrollView class]);
        NSString *superViewType = NSStringFromClass([scrollView.superview class]);
        if([scrollViewType isEqualToString:NSStringFromClass([UIScrollView class])]
            || [scrollViewType isEqualToString:NSStringFromClass([UITableView class])]
            || [scrollViewType isEqualToString:NSStringFromClass([UICollectionView class])]
            || [superViewType isEqualToString:NSStringFromClass([WKWebView class])]
            || [superViewType isEqualToString:NSStringFromClass([UIWebView class])]) {
            _context.observedScrollView = scrollView;
        } else {
            gestureRecognizer.state = UIGestureRecognizerStateFailed;
            return false;
        }
    }
    return true;
}

#pragma UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    BOOL result = _context.isEnable && _context.interactiveTransition != nil;
    return result ? self.animator : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return [_context interactiveTransitionIfNeeded];
}

@end
