//
//  SwipeToDimissContext.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/27/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Context.h"
#import "DelegateProxy-swift.h"

@interface SwipeToDismissContext : Context<ContextType>

@property (nonatomic, weak) UIScrollView *observedScrollView;

- (BOOL)allowsTransitionFinish:(CGFloat)swipeVelocity;

- (CGPoint)velocity:(UIPanGestureRecognizer *)recoginzer;

- (void)didStartTransition;

- (void)updateTransitionWithRecognizer:(UIPanGestureRecognizer *)recognizer;

- (void)updateTransitionWithTranslationY:(CGFloat)translationY;

@end
