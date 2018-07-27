//
//  NHBarScrollTool.h
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/7.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_include("UIView+NHLayout.h")
#define UIViewNHLayout_H  0
#import "UIView+NHLayout.h"
#else
#pragma mark - 屏幕尺寸相关
#define kScreenWidth           [UIScreen mainScreen].bounds.size.width
#define kScreenHeight          [UIScreen mainScreen].bounds.size.height
#define kCurrentModeSize       [[UIScreen mainScreen] currentMode].size
#define kInterfaceOrientation  [[UIApplication sharedApplication] statusBarOrientation]
#define kStatusBarHeight       [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight          44.0
#define kTabBarHeight          ((kScreen5_85inch) ? 83.0 : 49.0)
#define kNavgationHeight       (kStatusBarHeight + kNavBarHeight)
//iPhoneX相关属性
/** 5.85inch屏幕 -> iPhone_X */
#define kRespondCurrentMode [UIScreen instancesRespondToSelector:@selector(currentMode)]
#define kScreen5_85inch (kRespondCurrentMode && CGSizeEqualToSize(CGSizeMake(1125, 2436), kCurrentModeSize))
#define kTabBarBottomPad          (kScreen5_85inch ? 34.0 : 0.0)
#define kNavBarTopPad             (kScreen5_85inch ? 44.0 : 0.0)
#define kStatusTopPad             (kScreen5_85inch ? 24.0 : 0.0)
#define kLandscapeBottomPad       (kScreen5_85inch ? 21.0 : 0.0)
#endif
/*******************************自定义的 NSLog******************************/
#pragma mark - 自定义的 NSLog
#ifdef DEBUG
#define NHSLog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define NHSLog(...)
#endif

@interface NHBarScrollTool : NSObject <UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate>
@property (nonatomic, strong) IBOutletCollection(id) NSArray* delegateTargets;
/**
 tabBar凸出部份的补偿值，默认为0
 */
@property (nonatomic, assign) CGFloat tabBarBulgeOffset;


+ (instancetype)BarScrollToolWithController:(UIViewController *)viewController
                                 scrollView:(UIScrollView *)scrollView
                              navigationBar:(__kindof UIView *)navigationBar
                                     tabBar:(__kindof UIView *)tabBar;



- (void)removeObserver:(id)delegateTag;

@end
