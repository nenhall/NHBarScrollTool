//
//  UIButton+NHLayout.h
//  NHExtension
//
//  Created by neghao on 2017/7/18.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 针对同时设置了Image和Title的场景时图片和文字的排版布局 */
typedef NS_ENUM(NSInteger, NHButtonLayoutStyle) {
    NHButtonLayoutDefault     = 0,  /**< 系统原生的排版 */
    NHButtonLayoutImageLeft   = 1,  /**< 图片在左，文字在右，整体居中 */
    NHButtonLayoutImageRight  = 2,  /**< 图片在右，文字在左，整体居中 */
    NHButtonLayoutImageTop    = 3,  /**< 图片在上，文字在下，整体居中 */
    NHButtonLayoutImageBottom = 4,  /**< 图片在下，文字在上，整体居中 */
    NHButtonLayoutImageRightTitleLeft    = 5,  /**< 图片在右，文字在左，等距离按钮两边边距 */
    NHButtonLayoutImageLeftTitleRight    = 6,  /**< 图片在左，文字在右，等距离按钮两边边距 */
    NHButtonLayoutImageCenterTitleUp     = 7,  /**< 图片垂直居中，文字在图片的上面为基准线 */
    NHButtonLayoutImageCenterTitleDown   = 8,  /**< 图片垂直居中，文字在图片的下面为基准线 */
    NHButtonLayoutImageCenterTitleTop    = 9,  /**< 图片垂直居中，文字以按钮顶部为基准线 */
    NHButtonLayoutImageCenterTitleBottom = 10, /**< 图片垂直居中，文字以按钮底部为基准线 */
};

#if !TARGET_INTERFACE_BUILDER

@interface UIButton (NHLayout)
/**
 自动更新图文布局，在父视图调用LayoutSubviews方法时 默认NO
 关闭此功能，且button是使用autoLayout布局，
 则需要在layoutsubiews方法中调用`- setImageTitleStyle: padding:`方法
 */
@property (nonatomic, assign) BOOL closeAutoLayoutStyleOnLayoutSubviews;

/**
 调整title和image的布局，需先设置title、image和添加superview才会生效

 @param style 排版风格
 @param padding title和image的间隙
 */
-(void)setImageTitleStyle:(NHButtonLayoutStyle)style padding:(CGFloat)padding;

@end

#else
IB_DESIGNABLE  //动态刷新
@interface UIButton (ImageTitleLayout)
@property (nonatomic, assign)IBInspectable NSInteger layoutStyle;
@property (nonatomic, assign)IBInspectable CGFloat padding;
@end

#endif


