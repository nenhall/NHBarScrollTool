//
//  UINavigationController+PushAnimation.h
//  NHExtension
//
//  Created by neghao on 2017/8/1.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OJLNavAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIButton* centerButton;
@end


@interface UINavigationController (PushAnimation)

- (void)pushViewController:(UIViewController *)viewController withCenterButton:(UIButton*)button;


@end


@interface UINavigationController (PopGesture)

- (void)setInteractivePopGestureRecognizerEenabled:(BOOL)enabled;

@end
