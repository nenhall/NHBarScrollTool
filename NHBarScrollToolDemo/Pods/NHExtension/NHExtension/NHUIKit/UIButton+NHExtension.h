//
//  UIButton+NHExtension.h
//  NHExtension
//
//  Created by neghao on 2016/11/24.
//  Copyright © 2016年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (repeatRate)
/** 接受点击事件的时间间隔 */
@property (nonatomic, assign) NSTimeInterval nhAcceptEventInterval;

@end
