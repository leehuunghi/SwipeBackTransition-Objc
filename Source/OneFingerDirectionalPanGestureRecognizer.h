//
//  OneFingerDirectionalPanGestureRecognizer.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/29/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    up,
    down,
    left,
    right
}PanDirection;

@interface OneFingerDirectionalPanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic) PanDirection direction;

- (id _Nullable )initWithDirection:(PanDirection)direciton target:(nullable id)target action:(nullable SEL)action;

- (instancetype)initWithDirection:(PanDirection)direciton;

@end
