//
//  SwipeToDismissController.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/27/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface SwipeToDismissController : NSObject<UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, copy) void (^onStartTransition)(NSObject<UIViewControllerContextTransitioning> *);

@property (nonatomic, copy) void (^onFinishTransition)(NSObject<UIViewControllerContextTransitioning> *);

@property (nonatomic, copy) BOOL (^isFirstPageOfPageViewController)(void);

@property (nonatomic) BOOL isEnable;

- (void)setTargetWithViewController:(UIViewController *)viewController;

- (void)removeTargetViewController;

@end
