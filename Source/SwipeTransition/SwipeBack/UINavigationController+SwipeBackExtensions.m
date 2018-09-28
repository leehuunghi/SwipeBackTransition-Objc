//
//  UINavigationController+SwipeBackExtensions.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/31/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "UINavigationController+SwipeBackExtensions.h"
#import <objc/runtime.h>
#import "AssocKey.h"

@implementation UINavigationController (SwipeBackExtensions)

- (void)setSwipeBack:(SwipeBackController *)swipeBack {
    objc_setAssociatedObject(self, CFBridgingRetain(AssocKey.swipeBack), swipeBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SwipeBackController *)swipeBack {
    return objc_getAssociatedObject(self, CFBridgingRetain(AssocKey.swipeBack));
}

@end
