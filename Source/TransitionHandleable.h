//
//  TransitionHandleable.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/28/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractiveTransition.h"

@protocol TransitionHandleable

@property (nonatomic) InteractiveTransition *interactiveTransition;
@property (nonatomic, readonly) BOOL allowsTransitionStart;

@required
- (void)startTransition;

- (void)didStartTransition;

- (void)finishTransition;

- (void)didFinishTransition;

- (void)cancelTransition;

- (void)didCancelTransition;

@end

