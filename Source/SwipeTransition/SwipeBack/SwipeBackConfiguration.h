//
//  SwipeBackConfiguration.h
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/31/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface SwipeBackConfiguration : NSObject

//+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
//- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance instead")));
//+ (instancetype)new __attribute__((unavailable("new not available, call sharedInstance instead")));
//- (instancetype)copy __attribute__((unavailable("copy not available, call sharedInstance instead")));

+ (instancetype)shareInstance;

@property (nonatomic) NSTimeInterval transitionDuration;

@property (nonatomic) CGFloat parallaxFactor;

@property (nonatomic) CGFloat backViewDimness;

@end
