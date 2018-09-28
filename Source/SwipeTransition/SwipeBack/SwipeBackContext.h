//
//  SwipeBackContext.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/29/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Context.h"
#import "DelegateProxy-swift.h"

@interface SwipeBackContext : Context<ContextType>

@property (nonatomic) NavigationControllerDelegateProxy *navigationControllerDelegateProxy;

@property (nonatomic, weak) UIPanGestureRecognizer *pageViewControllerPanGestureRecognizer;

- (BOOL)allowTransitionFinish:(UIPanGestureRecognizer *)recognizer;

- (void)didStartTransition;

- (void)updateTransition:(UIPanGestureRecognizer *)recognizer;

@end
