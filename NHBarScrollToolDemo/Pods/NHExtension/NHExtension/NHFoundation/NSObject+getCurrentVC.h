//
//  NSObject+getCurrentVC.h
//  NHExtension
//
//  Created by neghao on 2017/6/22.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (getCurrentVC)

///获取当前window最上层的控件器
- (UIViewController *)getCurrentTopViewController;

@end
