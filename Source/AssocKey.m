//
//  __AssocKey.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/29/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "AssocKey.h"

@implementation AssocKey

static id swipeToDismiss;

+ (id)swipeBack {
    static id swipeBack;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swipeToDismiss = [NSUUID UUID];
    });
    return swipeBack;
}

+ (id)swipeToDismiss {
    static id swipeToDismiss;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swipeToDismiss = [NSUUID UUID];
    });
    return swipeToDismiss;
}

@end

@implementation __AssocKey

+ (id)pointer:(id)ptr {
    if (ptr) {
        return ptr;
    } else {
        return nil;
    }
}

+ (id)swipeBack {
    return [self pointer:AssocKey.swipeBack];
}

+ (id)swipeToDismiss {
    return [self pointer:AssocKey.swipeToDismiss];
}

@end
