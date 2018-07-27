//
//  UIView+IB_DESIGNABLE.h
//  NHExtension
//
//  Created by neghao on 2017/1/13.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE  // 动态刷新

@interface UIView (IBAppearance)

// 注意: 加上IBInspectable就可以可视化显示相关的属性哦
/** 可视化设置边框宽度 */
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;

///** 可视化设置边框颜色 */
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

///** 可视化设置圆角 */
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@end
