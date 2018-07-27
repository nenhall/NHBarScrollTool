//
//  NHBarScrollTool.h
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/7.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NHBarScrollTool : NSObject <UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate>
@property (nonatomic, copy) IBOutletCollection(id) NSArray* delegateTargets;

/** tabBar凸出部份的高度，默认为0 */
@property (nonatomic, assign) CGFloat tabBarBulgeOffset;


+ (instancetype)barToolWithController:(__kindof UIViewController *)viewController
                           scrollView:(UIScrollView *)scrollView
                        navigationBar:(__kindof UIView *)navigationBar
                               tabBar:(__kindof UIView *)tabBar;

/** 移除代理对象 */
- (void)removeObserver:(id)delegateTag;


/** updateConstraints
 * 如果是使用autolayout、mansory布局，需要在`viewDidLayoutSubviews`函数中调用此
 */
- (void)updateConstraints;

@end
