//
//  PanGestureRecognizerTest.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 9/18/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoSwipeBack.h"

@interface PanGestureRecognizerTest : UIPanGestureRecognizer
@property (nonatomic) id testTarget;
@property (nonatomic) SEL testAciton;

@property (nonatomic) UIGestureRecognizerState testState;
@property (nonatomic) CGPoint testLocation;
@property (nonatomic) CGPoint testTranslation;

- (void)performTouchWithLocation:(CGPoint)location andTranslation:(CGPoint)translation andState:(UIGestureRecognizerState)state;

@end
