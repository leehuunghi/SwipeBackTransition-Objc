//
//  SwipeBackAnimator.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/30/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeBackController.h"
#import "SwipeBackConfiguration.h"

@interface SwipeBackAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (id)initWithParent:(SwipeBackController *)parent;

@end
