//
//  UIImageView+NHExtension.h
//  NHExtension
//
//  Created by neghao on 2016/11/25.
//  Copyright © 2016年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (NHExtension)

/**
 *  设置圆角图片
 */
- (void)setRoundImage:(UIImage *)image;

@end


@interface UIImageView (CornerRadius)


- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)zy_cornerRadiusRoundingRect;

- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
