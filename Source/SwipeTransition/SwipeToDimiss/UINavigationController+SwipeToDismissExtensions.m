//
//  UINavigationController+SwipeToDismissExtensions.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 9/5/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "UINavigationController+SwipeToDismissExtensions.h"
#import <objc/runtime.h>
#import "AssocKey.h"

@implementation UINavigationController (SwipeToDismissExtensions)

- (void)setSwipeToDismiss:(SwipeToDismissController *)swipeToDismiss {
        objc_setAssociatedObject(self, CFBridgingRetain(AssocKey.swipeToDismiss), swipeToDismiss, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SwipeToDismissController *)swipeToDismiss {
    return objc_getAssociatedObject(self, CFBridgingRetain(AssocKey.swipeToDismiss));
}

@end
