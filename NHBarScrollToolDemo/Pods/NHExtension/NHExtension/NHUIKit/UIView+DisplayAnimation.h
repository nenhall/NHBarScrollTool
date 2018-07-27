//
//  UIView+DisplayAnimation.h
//  NHExtension
//
//  Created by neghao on 17/1/4.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITableViewCellDisplayAnimationStyle) {
    UITableViewCellDisplayAnimationStyleFade,	 //透明度变化
    UITableViewCellDisplayAnimationStyleScale,	 //缩放
    UITableViewCellDisplayAnimationStylePosition,//位置变化
    UITableViewCellDisplayAnimationStyleRotateX, //x轴旋转
    UITableViewCellDisplayAnimationStyleRotateY  //Y 轴旋转
};

@interface UIView (DisplayAnimation)

- (void)doCellAnimationWithAnimationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle;

+ (void)doCellAnimationWithAnimationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle onTheView:(UIView *)view;

@end
