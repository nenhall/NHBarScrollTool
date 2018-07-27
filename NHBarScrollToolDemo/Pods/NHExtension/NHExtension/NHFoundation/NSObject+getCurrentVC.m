//
//  NSObject+getCurrentVC.m
//  NHExtension
//
//  Created by neghao on 2017/6/22.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "NSObject+getCurrentVC.h"

@implementation NSObject (getCurrentVC)


- (UIViewController *)getCurrentTopViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    if ([window subviews].count >= 1) {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            result = nextResponder;
        } else {
            result = window.rootViewController;
        }
    }
    return result;
}

@end
