//
//  PushableVC.m
//  SwipeTransitionObjC
//
//  Created by CPU11360 on 9/18/18.
//  Copyright © 2018 CPU11360. All rights reserved.
//

#import "PushableVC.h"
#import "UINavigationController+AutoSwipeBack.h"

@interface PushableVC ()

@end

@implementation PushableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PushableVC";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] init];
    navigationBar = self.navigationController.navigationBar;
    
//    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"PushViewableVC"];
//    navigationItem.hidesBackButton = NO;
//    navigationItem.backBarButtonItem = self.navigationController.navigationBar.backItem;
//    navigationBar.items = @[navigationItem];
    
    [self.view addSubview:navigationBar];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    button.center = self.view.center;
    [button addTarget:self action:@selector(didTapButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Push" forState:normal];
    [button setTitleColor:UIColor.redColor forState:normal];
    [self.view addSubview:button];
}

- (void)didTapButton {
    if (self.navigationController) {
        [self.navigationController pushViewController:[PushableVC new] animated:true];
    }
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
