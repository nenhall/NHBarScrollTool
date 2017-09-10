//
//  NHBarScrollTool.m
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/7.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "NHBarScrollTool.h"
#import "UIView+NHFrame.h"
#import "MJRefresh.h"

@interface NHBarScrollHelper : NSObject
@property (nonatomic, weak  ) UIViewController   *currentConteroller;
@property (nonatomic, weak  ) UITabBarController *tabBarController;
@property (nonatomic, weak  ) UITabBar           *tabBar;
@property (nonatomic, weak  ) UIView             *navigationView;
@property (nonatomic, weak  ) UIScrollView       *scrollView;
@property (nonatomic, strong) NSPointerArray     *weakRefTargets;
@property (nonatomic, assign) CGFloat            lastPointY;
@property (nonatomic, assign) CGFloat            moveOffset;
@property (nonatomic, assign) CGFloat            navBarOriginallY;
@property (nonatomic, assign) CGFloat            tabBarOriginallY;
@property (nonatomic, assign) CGFloat            navgationHeight;
@property (nonatomic, assign) CGFloat            tabbarHeight;
@end


@implementation NHBarScrollHelper

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    CGFloat scrollViewOffsetY = scrollView.contentOffset.y;
    _moveOffset = scrollViewOffsetY - _lastPointY;
//    NSLog(@"contentOffsetY:%f",scrollView.contentOffset.y);
    
    
//    if (scrollViewOffsetY >= _navgationHeight) {
//        return;
//    }
    
    //往下拽刷新的时候，结束掉
    if (scrollViewOffsetY <= -_scrollView.contentInset.top) {
        return;
    }
    
    
    if (scrollView.mj_offsetY >= scrollView.mj_contentH - scrollView.mj_h + scrollView.mj_h + scrollView.mj_insetB - scrollView.mj_h) {
        return;
    }
    
    
    [self updatePageBarFrame];
    
    _lastPointY = scrollView.contentOffset.y;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    for (id target in self.weakRefTargets) {
        if ([target respondsToSelector:_cmd]) {
            [target scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        }
    }
    
    _moveOffset = MAXFLOAT;
    [self updatePageBarFrame];
    
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    
    for (id target in self.weakRefTargets) {
        if ([target respondsToSelector:_cmd]) {
            [target scrollViewDidScrollToTop:scrollView];
        }
    }
    _moveOffset = MAXFLOAT;
    [self updatePageBarFrame];
    
}


#pragma updateBarFrame
- (void)updatePageBarFrame {
    
    if (_moveOffset == MAXFLOAT) {
        [self updataTabBarAndNavigationBarFrame];
        return;
    }
    [self updateNavigationBarFrame];
    
    [self updateTabBarFrame];
    
    
    //    kNSLog(@"%f <-->",moveOffset);
}


- (void)updateNavigationBarFrame {
    CGFloat pageBarOffsetY = _navigationView.top;
//    NSLog(@"%f--%f",_navigationView.top,_moveOffset);
    
    if (_moveOffset > 0) {
        if (pageBarOffsetY <= -(_navgationHeight - _navBarOriginallY)) {
            _navigationView.top = -(_navgationHeight - _navBarOriginallY);
            return;
        }
        
    } else {
        if (pageBarOffsetY == _navBarOriginallY) {
            return;
        }
        
        if (pageBarOffsetY >= _navBarOriginallY) {
            _navigationView.top = _navBarOriginallY;
            return;
        }
    }
    _navigationView.top -= _moveOffset;
}


- (void)updateTabBarFrame {
    
    CGFloat tabBarTop = _tabBar.top;
    CGFloat tabBarOffset = 20;
    CGFloat tabBar_Y = kScreenHeight + tabBarOffset;
    
    if (_moveOffset > 0) {
        _tabBarController.hidesBottomBarWhenPushed = YES;
        
        if (tabBarTop == tabBar_Y) {
            return;
        }
        if (tabBarTop >= tabBar_Y) {
            _tabBar.top = tabBar_Y;
            _tabBarController.hidesBottomBarWhenPushed = YES;
            return;
        }
        
    } else {
        _tabBarController.hidesBottomBarWhenPushed = NO;
        if (tabBarTop == kScreenHeight - _tabbarHeight) {
            return;
        }
        if (tabBarTop <= kScreenHeight - _tabbarHeight) {
            _tabBar.top = kScreenHeight - _tabbarHeight;
            return;
        }
    }
    _tabBar.bottom += _moveOffset;
    //    NSLog(@"%f <--> %f",moveOffset,tab.tabBar.bottom);
}


- (void)updataTabBarAndNavigationBarFrame {
    
    //    CGFloat tabBarOffset = kScreenHeight - _tabBar.top;
    CGFloat scrollViewOffsetY = _scrollView.contentOffset.y;
    
    //    kNSLog(@"%f",_scrollView.contentOffset.y);
    
    if (_navigationView.top <= -_navgationHeight) {
        _navigationView.top = -_navgationHeight;
        return;
    }
    if (_navigationView.top >= 0) {
        _navigationView.top = _navBarOriginallY;
        return;
    }
    
    //以navigationBar为参考对象
    if (fabs(_navigationView.top) + 0 < ((_navgationHeight - _navBarOriginallY) * 0.5)) {
        
        // 解决下滑到一半的时候，刷新栏目没有自动隐藏
        if (scrollViewOffsetY < 0) {
            _scrollView.contentOffset = CGPointMake(0, -_navgationHeight);
        }
        _tabBar.top = kScreenHeight - _tabbarHeight;
        _tabBarController.hidesBottomBarWhenPushed = NO;
        _navigationView.top = _navBarOriginallY;
        
    } else {
        // 解决上滑到一半的时候，刷新栏目没有自动隐藏
        if (scrollViewOffsetY < 0) {
            _scrollView.contentOffset = CGPointMake(0, 0);
        }
        _tabBar.top = kScreenHeight + 20;
        _tabBarController.hidesBottomBarWhenPushed = YES;
        _navigationView.top = -_navgationHeight;
    }
}

@end


@interface NHBarScrollTool ()
//这个必须要用strong，不会导致无法释放问题
@property (nonatomic, strong) NSPointerArray     *weakRefTargets;
@property (nonatomic, strong) NHBarScrollHelper  *scrollHelper;

@end


@implementation NHBarScrollTool

+ (instancetype)BarScrollToolWithController:(UIViewController *)viewController
                                 scrollView:(UIScrollView *)scrollView
                              navigationBar:(__kindof UIView *)navigationBar
                                     tabBar:(__kindof UIView *)tabBar {
    
    return [[[NHBarScrollTool alloc] init] BarScrollToolWithController:viewController
                                                            scrollView:scrollView
                                                         navigationBar:navigationBar
                                                                tabBar:tabBar];

}

- (instancetype)BarScrollToolWithController:(UIViewController *)viewController
                                 scrollView:(UIScrollView *)scrollView
                              navigationBar:(__kindof UIView *)navigationBar
                                     tabBar:(__kindof UIView *)tabBar {
    
    if (self == [super init]) {
        
        UIView *navBar = navigationBar ?: viewController.navigationController.navigationBar;
        UITabBar *tBar = tabBar ?: viewController.tabBarController.tabBar;
        self.scrollHelper.currentConteroller = viewController;
        self.scrollHelper.tabBarController = viewController.tabBarController;
        self.scrollHelper.navigationView = navBar;
        self.scrollHelper.tabBar = tBar;
        self.scrollHelper.navBarOriginallY = navBar.top;
        self.scrollHelper.tabBarOriginallY = tBar.top;
        self.scrollHelper.navgationHeight = navBar.height + navBar.top;
        self.scrollHelper.tabbarHeight = tBar.height;
        self.scrollHelper.scrollView = scrollView;
        
    }
    return self;
}

- (NHBarScrollHelper *)scrollHelper {
    if (!_scrollHelper) {
        _scrollHelper = [[NHBarScrollHelper alloc] init];
    }
    return _scrollHelper;
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    for (id target in self.weakRefTargets) {
        if (target && [target respondsToSelector:aSelector]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        [_weakRefTargets compact];
        for (id target in self.weakRefTargets) {
            if ((sig = [target methodSignatureForSelector:aSelector])) {
                break;
            }
        }
    }
    
    return sig;
}

//转发方法调用给所有delegate
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    for (id target in self.weakRefTargets) {
        if ([target respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:target];
        }
    }
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

//保存代理
- (void)setDelegateTargets:(NSArray *)delegateTargets {
    _delegateTargets = delegateTargets;
    self.weakRefTargets = [NSPointerArray weakObjectsPointerArray];
    for (id delegate in delegateTargets) {
        [self.weakRefTargets addPointer:(__bridge void * _Nullable)(delegate)];
    }
    [self.weakRefTargets addPointer:(__bridge void * _Nullable)(self.scrollHelper)];

}


@end
