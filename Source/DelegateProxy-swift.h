//
//  DelegateProxy-swift.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/31/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DelegateProxy.h"

@interface DelegateProxy_swift : STDelegateProxy

- (instancetype)initWithDelegates:(NSArray *)delegates;

@end

@interface NavigationControllerDelegateProxy : DelegateProxy_swift<UINavigationControllerDelegate>

@end
