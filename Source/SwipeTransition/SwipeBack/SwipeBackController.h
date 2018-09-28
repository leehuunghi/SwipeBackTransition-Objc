//
//  SwipeBackController.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/28/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwipeBackContext.h"
#import "OneFingerDirectionalPanGestureRecognizer.h"

@interface SwipeBackController : NSObject<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, copy) void (^onStartTransition)(NSObject<UIViewControllerContextTransitioning> *);

@property (nonatomic, copy) void (^onFinishTransition)(NSObject<UIViewControllerContextTransitioning> *);

@property (nonatomic, copy) BOOL (^isFirstPageOfPageViewController)(void);

@property (nonatomic) BOOL isEnable;

- (id)initWithNavigationController:(UINavigationController *)navigationController;

- (void)setNavigationControllerDelegate:(id<UINavigationControllerDelegate>)delegate;

- (void)observePageViewController:(UIPageViewController *)pageViewController isFirstPage:(BOOL (^)(void))isFirstPage;

@end
