//
//  NHBarScrollTool.m
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/7.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "NHBarScrollTool.h"

@interface NHBarScrollTool ()
@property (nonatomic, weak  ) UIViewController   *currentConteroller;
@property (nonatomic, weak  ) UITabBarController *tabBarController;
@property (nonatomic, weak  ) UITabBar           *tabBar;
@property (nonatomic, weak  ) UIView             *navigationView;
@property (nonatomic, weak  ) UIScrollView       *scrollView;
@property (nonatomic, strong) NSPointerArray     *weakRefTargets;
@property (nonatomic, assign) CGFloat            lastPointY;

@end


@implementation NHBarScrollTool

+ (instancetype)BarScrollToolWithController:(UIViewController *)viewController
                              navigationBar:(__kindof UIView *)navigationBar
                                     tabBar:(__kindof UIView *)tabBar {
    return [[[NHBarScrollTool alloc] init] BarScrollToolWithController:viewController
                                                         navigationBar:navigationBar
                                                                tabBar:tabBar];

}

- (instancetype)BarScrollToolWithController:(UIViewController *)viewController
                              navigationBar:(__kindof UIView *)navigationBar
                                     tabBar:(__kindof UIView *)tabBar {
    
    if (self == [super init]) {
        _currentConteroller = viewController;

        _tabBarController = viewController.tabBarController;
        _navigationView = navigationBar;
        _tabBar = tabBar;
    }
    return self;
}



- (void)removeObserver:(id)delegateTag {
    NSUInteger index = [self indexOfDelegate:delegateTag];
    if (index != NSNotFound) {
        [_weakRefTargets removePointerAtIndex:index];
    }
    [_weakRefTargets compact];
}

- (NSUInteger)indexOfDelegate:(id)delegate {
    for (NSUInteger i = 0; i < _weakRefTargets.count; i++) {
        if ([_weakRefTargets pointerAtIndex:i] == (__bridge void*)delegate) {
            return i;
        }
    }
    return NSNotFound;
}

@end
