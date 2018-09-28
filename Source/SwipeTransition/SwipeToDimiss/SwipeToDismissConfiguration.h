//
//  SwipeToDismissConfiguration.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 9/5/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SwipeToDismissConfiguration : NSObject

+ (instancetype)shareInstance;

/// Duration of the dismiss animation [s]
@property (nonatomic) NSTimeInterval transitionDuration;

/// Wait time until the dismiss animation [s]
@property (nonatomic) NSTimeInterval animationWaitTime;

/// Threshold of the height to dismiss
@property (nonatomic) CGFloat dismissHeightRatio;

/// Threshold of the finger speed to dismiss [pt/s]
@property (nonatomic) CGFloat dismissSwipeSpeed;
@end
