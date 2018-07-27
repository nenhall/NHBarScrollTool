//
//  UINavigationItem+BarItem.h
//  NHExtension
//
//  Created by neghao on 2017/6/30.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (BarItem)

/**
 添加右边的item

 @param image 图片
 @param title 标题
 @param width 与右边缘的间隙
 @param clickAction 响应事件
 */
- (UIButton *)addRightBarItem:(UIImage *)image title:(NSString *)title space:(CGFloat)width clickAction:(void(^)(UIButton *button))clickAction;

/**
 添加左边的item
 
 @param image 图片
 @param title 标题
 @param width 与右边缘的间隙
 @param clickAction 响应事件
 */
- (UIButton *)addLeftBarItem:(UIImage *)image title:(NSString *)title space:(CGFloat)width clickAction:(void(^)(UIButton *button))clickAction;



/**
 添加右上角带小红点

 @param image 按钮图片
 @param title 标题
 @param isLeft 添加到左还是右边
 @param clickAction 响应事件
 */
- (UIButton *)addBadgeBarItem:(UIImage *)image title:(NSString *)title space:(CGFloat)width isLeft:(BOOL)isLeft clickAction:(void(^)(UIButton *button))clickAction;



@end
