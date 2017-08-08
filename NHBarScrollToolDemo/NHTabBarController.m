//
//  NHTabBarController.m
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/7.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "NHTabBarController.h"
#import "NHTabBar.h"
#import "NHPushViewController.h"

@interface NHTabBarController ()

@end

@implementation NHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    NHTabBar *tabbar = [[NHTabBar alloc] init];
    [tabbar setBtnClickBlock:^{
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NHPushViewController *push = [board instantiateViewControllerWithIdentifier:@"NHPushViewController"];
        [self presentViewController:push animated:YES completion:nil];
    }];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
