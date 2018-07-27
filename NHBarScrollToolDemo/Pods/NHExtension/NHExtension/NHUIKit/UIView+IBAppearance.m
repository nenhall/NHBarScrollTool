//
//  UIView+IB_DESIGNABLE.m
//  NHExtension
//
//  Created by neghao on 2017/1/13.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "UIView+IBAppearance.h"
#import <objc/runtime.h>


#define BORDER_COLOR_KEYPATH @"borderColor"


@implementation UIView (IBAppearance)

- (void)setBorderColor:(UIColor *)borderColor {
    UIColor *bc = objc_getAssociatedObject(self, BORDER_COLOR_KEYPATH);
    if(bc == borderColor) return;

    objc_setAssociatedObject(self, BORDER_COLOR_KEYPATH, borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.layer.borderColor = [borderColor CGColor];

}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, BORDER_COLOR_KEYPATH);
}


/**
 *  设置边框宽度
 *
 *  @param borderWidth 可视化视图传入的值
 */
- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;
    
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.borderWidth;
}


///**
// *  设置边框颜色
// *
// *  @param borderColor 可视化视图传入的值
// */
//- (void)setBorderColor:(UIColor *)borderColor {
//    
//    self.layer.borderColor = borderColor.CGColor;
//}
//
//- (UIColor *)borderColor{
//    return self.borderColor;
//}

/**
 *  设置圆角
 *
 *  @param cornerRadius 可视化视图传入的值
 */
- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius{
    return self.cornerRadius;
}


@end
