//
//  UIViewController+Extension.h
//  NHExtension
//
//  Created by neghao on 2016/12/28.
//  Copyright © 2016年 neghao.studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

    //结束tableView的刷新
- (void)endScrollViewRefresh:(UIScrollView *)scrollView;

//获取当前显示的控制器
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;

//返回上一层控制器
- (void)backController;

//present多层控制器后，返回到最底层控制器
- (void)dismissViewControllerClass:(Class)cla;

@end



