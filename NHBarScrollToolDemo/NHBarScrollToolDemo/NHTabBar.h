//
//  NHTabBar.h
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/8.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BKTabBarClickBlock)();

@interface NHTabBar : UITabBar
- (void)setBtnClickBlock:(BKTabBarClickBlock)block;


@end
