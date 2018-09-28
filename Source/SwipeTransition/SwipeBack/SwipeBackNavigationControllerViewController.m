//
//  SwipeBackNavigationControllerViewController.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 8/31/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "SwipeBackNavigationControllerViewController.h"
#import "UINavigationController+SwipeBackExtensions.h"

@interface SwipeBackNavigationControllerViewController ()

@end

@implementation SwipeBackNavigationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.swipeBack = [[SwipeBackController alloc] initWithNavigationController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
