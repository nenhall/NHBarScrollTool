//
//  UITextView+NHExtension.h
//  NHExtension
//
//  Created by neghao on 2016/8/24.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UITextView (NHPlaceholder)
/** 注意先设置textView的字体 */
@property (nonatomic,copy) NSString *placeholder;
@end
