//
//  UINavigationController+AutoSwipeBack.h
//  AutoSwipeBack
//
//  Created by Tatsuya Tanaka on 20171224.
//  Copyright © 2017年 tattn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeBackController.h"

@interface UINavigationController (AutoSwipeBack)
@property(nonatomic, nullable) SwipeBackController* swipeBack;
@end
