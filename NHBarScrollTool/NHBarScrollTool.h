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
@property (nonatomic, strong) IBOutletCollection(id) NSArray* delegateTargets;

+ (instancetype)BarScrollToolWithController:(UIViewController *)viewController
                                 scrollView:(UIScrollView *)scrollView
                              navigationBar:(__kindof UIView *)navigationBar
                                     tabBar:(__kindof UIView *)tabBar;



- (void)removeObserver:(id)delegateTag;

@end
