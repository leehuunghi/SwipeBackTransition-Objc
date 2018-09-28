//
//  Context.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/27/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TransitionHandleable.h"

@interface Target : UIViewController

@end

@protocol TargetHolder

@property (nonatomic, strong) id target;

@property (nonatomic) UIView *targetView;

- (void)init:(UIViewController *)target;

@end

@protocol ContextType <TransitionHandleable, TargetHolder>
@property (nonatomic) BOOL isEnable;
@property (nonatomic) BOOL transitioning;
@property (nonatomic) InteractiveTransition *interactiveTransition;

@required
- (InteractiveTransition *)interactiveTransitionIfNeeded;
@end

@interface Context<Target> : NSObject

@property (nonatomic) BOOL isEnable;
@property (nonatomic) BOOL transitioning;

@property (nonatomic) InteractiveTransition *interactiveTransition;
@property (nonatomic) BOOL allowsTransitionStart;

- (id)initWithTarget:(Target)target;

- (Target)targetContext;

@end
