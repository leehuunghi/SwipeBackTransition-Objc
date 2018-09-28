//
//  SwipeBackContextTest.m
//  PanGestureRecognizerTests
//
//  Created by CPU11360 on 9/18/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PanGestureRecognizerTest.h"

@interface SwipeBackContextTest : XCTestCase

@property (nonatomic) SwipeBackContext *context;
@property (nonatomic) UIViewController *viewController;
@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) PanGestureRecognizerTest *panGestureRecognizer;

@end

@implementation SwipeBackContextTest

- (void)setUp {
    [super setUp];
    _viewController = [[UIViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    _panGestureRecognizer = [[PanGestureRecognizerTest alloc] init];
    _context = [[SwipeBackContext alloc] initWithTarget:_navigationController];
}

- (void)testAllowsTransitionStart {
    XCTAssertFalse([_context allowsTransitionStart]);
    [_navigationController pushViewController:_viewController animated:NO];
    XCTAssertTrue([_context allowsTransitionStart]);
    _context.isEnable = false;
    XCTAssertFalse([_context allowsTransitionStart]);
    _context.isEnable = true;
    XCTAssertTrue([_context allowsTransitionStart]);
}

- (void)testStartTransition {
    [_navigationController pushViewController:_viewController animated:NO];
    XCTAssertNil(_context.interactiveTransition);
    [_context startTransition];
    XCTAssertNotNil(_context.interactiveTransition);
}

- (void)testFinishTransition {
    [_navigationController pushViewController:_viewController animated:NO];
    [_context startTransition];
    XCTAssertNotNil(_context.interactiveTransition);
    [_context finishTransition];
    XCTAssertNil(_context.interactiveTransition);
    XCTAssertFalse(_context.transitioning);
}

- (void)testCancelTransition {
    [_navigationController pushViewController:_viewController animated:NO];
    [_context startTransition];
    XCTAssertNotNil(_context.interactiveTransition);
    [_context cancelTransition];
    XCTAssertNil(_context.interactiveTransition);
    XCTAssertFalse(_context.transitioning);
}

@end
