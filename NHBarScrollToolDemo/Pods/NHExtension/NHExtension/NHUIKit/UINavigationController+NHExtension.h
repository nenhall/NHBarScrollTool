//
//  UINavigationController+NHExtension.h
//  NHExtension
//
//  Created by neghao on 2017/8/1.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHNavAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIButton* centerButton;
@end


@interface UINavigationController (NHPushAnimation)

- (void)pushViewController:(UIViewController *)viewController withCenterButton:(UIButton*)button;


@end

