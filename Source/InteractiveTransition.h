//
//  InteractiveTransition.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/30/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition

- (void)update:(CGFloat)value maxValue:(CGFloat)maxValue;

@end
