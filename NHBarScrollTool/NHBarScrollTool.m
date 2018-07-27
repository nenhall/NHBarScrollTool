//
//  NHBarScrollTool.m
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/7.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "NHBarScrollTool.h"
#include <objc/message.h>

/*******************************自定义的 NSLog******************************/
#pragma mark - 自定义的 NSLog
#ifdef DEBUG
#define NHSLog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define NHSLog(...)
#endif

#if __has_include("NHUIKit.h")
#define UIViewNHLayout_H
#import "NHUIKit.h"
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

@interface UIView (NHLayout2)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic, readonly) CGFloat ttScreenX;
@property (nonatomic, readonly) CGFloat ttScreenY;
@property (nonatomic, readonly) CGFloat screenViewX;
@property (nonatomic, readonly) CGFloat screenViewY;
@property (nonatomic, readonly) CGRect screenFrame;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@end

@implementation UIView (NHLayout2)

- (CGFloat)left {
    return self.frame.origin.x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
@end
#endif

#pragma mark
#pragma mark - ************** NHBarScrollHelper **************
#pragma mark

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
@property (nonatomic, assign) CGFloat            tabBarBulgeOffset;
@end


@implementation NHBarScrollHelper

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    _moveOffset = MAXFLOAT;
    [self updatePageBarFrame];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    if (self.scrollView.contentOffset.y <= -_scrollView.contentInset.top) {
        return;
    }

    CGFloat scrollViewOffsetY = scrollView.contentOffset.y;
    _moveOffset = scrollViewOffsetY - _lastPointY;
    
    
    [self updatePageBarFrame];
    _lastPointY = scrollView.contentOffset.y;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        _moveOffset = MAXFLOAT;
        [self updatePageBarFrame];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _moveOffset = MAXFLOAT;
    [self updatePageBarFrame];
}


#pragma mark - updateBarFrame
- (void)updatePageBarFrame {
    
    if (_moveOffset == MAXFLOAT) {
        [self updataTabBarAndNavigationBarFrame];
        return;
    }

    UIPanGestureRecognizer *pan = _scrollView.panGestureRecognizer;
    CGFloat velocity = [pan velocityInView:_scrollView].y;
    if (velocity > 100) {
        if (_moveOffset < 0) {
            [UIView animateWithDuration:0.1 animations:^{
                self.navigationView.top = self.navBarOriginallY;
                self.tabBar.top = self.tabBarOriginallY;
            }];
            return;
        }
    }
    
    [self updateNavigationBarFrame];
    [self updateTabBarFrame];

}


- (void)updateNavigationBarFrame {
    CGFloat pageBarOffsetY = _navigationView.top;
    CGFloat referencePoint = (_navgationHeight - _navBarOriginallY);
    
//    NHSLog(@"updateNavigationBarFrame:%f  %f  %f",pageBarOffsetY,_moveOffset,referencePoint);
//    UIPanGestureRecognizer *pan = _scrollView.panGestureRecognizer;
//    CGFloat velocity = [pan velocityInView:_scrollView].y;
//    NHSLog(@"velocity %f   %f",velocity,_scrollView.contentSize.height);
    
    if (_moveOffset > 0) {//上
        if (pageBarOffsetY <= -referencePoint) {
            [UIView animateWithDuration:0.1 animations:^{
                self.navigationView.top = -referencePoint;
            }];
            return;
        }
        
    } else {//下
//        NHSLog(@"updateNavigationBarFrame  %f  %f  %f",pageBarOffsetY,referencePoint,_moveOffset);
        if (pageBarOffsetY >= _navBarOriginallY) {
            [UIView animateWithDuration:0.1 animations:^{
                self.navigationView.top = self.navBarOriginallY;
            }];
            return;
        }
    }
    
    _navigationView.top -= _moveOffset;
}


- (void)updateTabBarFrame {
    
    CGFloat tabBarTop = _tabBar.top;
    CGFloat tabBarMaxY = kScreenHeight + _tabBarBulgeOffset + 0;
    
//        NHSLog(@"%f--%f",_tabBar.top,_moveOffset);
    if (_tabBar.top < 729) {
//        NHSLog(@"%f--%f",_tabBar.top,_moveOffset);
    }
    
    if (_moveOffset > 0) {//上
        if (tabBarTop >= tabBarMaxY) {
            [UIView animateWithDuration:0.1 animations:^{
                self.tabBar.top = tabBarMaxY;
            }];
            return;
        }
        
    } else {//下
        // NHSLog(@"updateNavigationBarFrame  %f  %f  %f",pageBarOffsetY,referencePoint,_moveOffset);
        if (tabBarTop <= _tabBarOriginallY) {
            [UIView animateWithDuration:0.1 animations:^{
                self.tabBar.top = self.tabBarOriginallY;
            }];
            return;
        }
    }
    
    _tabBar.bottom += _moveOffset;
    //    NHSLog(@"%f <--> %f",moveOffset,tab.tabBar.bottom);
}

- (void)updataTabBarAndNavigationBarFrame {
    
    CGFloat scrollViewOffsetY = _scrollView.contentOffset.y;
    
    //以navigationBar为参考对象
    UIView *referenceObj =_navigationView ?: _tabBar;
    CGFloat referenceH = _navgationHeight;
    CGFloat referenceO_Y = _navBarOriginallY;
    if (!_navigationView) {
        referenceH = _tabBarOriginallY;
        referenceO_Y = _tabBarOriginallY;
    }
    
//    NHSLog(@"%f--%f",_tabBar.top,kScreenHeight - (_tabbarHeight * 0.5));

    if (referenceObj.top <= -(referenceH)) {
        [UIView animateWithDuration:0.1 animations:^{
            self.navigationView.top = -self.navgationHeight;
            self.tabBar.top = kScreenHeight + self.tabBarBulgeOffset + 0;
        }];
        return;
    }
    
    
    if (_navigationView && _navigationView.top >= 0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.navigationView.top = self.navBarOriginallY;
            self.tabBar.top = self.tabBarOriginallY;
        }];
        return;
    } else {
        if (_tabBar.top < (kScreenHeight - (_tabbarHeight * 0.5))) {
            [UIView animateWithDuration:0.1 animations:^{
                self.navigationView.top = self.navBarOriginallY;
                self.tabBar.top = self.tabBarOriginallY;
            }];
            return;
        }
    }


    if (fabs(referenceObj.top) < ((referenceH - referenceO_Y) * 0.5)) {
        // 解决下滑到一半的时候，刷新栏目没有自动隐藏
        if (scrollViewOffsetY < 0) {
            _scrollView.contentOffset = CGPointMake(0, -_scrollView.contentInset.top);
        }
        [UIView animateWithDuration:0.1 animations:^{
            self.tabBar.top = kScreenHeight - self.tabbarHeight;
            self.navigationView.top = self.navBarOriginallY;
        }];
        
    } else {
        // 解决上滑到一半的时候，刷新栏目没有自动隐藏
        if (scrollViewOffsetY < 0) {
            _scrollView.contentOffset = CGPointMake(0, 0);
            [UIView animateWithDuration:0.1 animations:^{
                self.tabBar.top = kScreenHeight - self.tabbarHeight;
                self.navigationView.top = self.navBarOriginallY;
            }];
        } else {
            [UIView animateWithDuration:0.1 animations:^{
                self.tabBar.top = kScreenHeight + self.tabBarBulgeOffset + 0;
                self.navigationView.top = -self.navgationHeight;
            }];
        }
    }
}

@end


@interface NHBarScrollTool () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSPointerArray     *weakRefTargets;
@property (nonatomic, strong) NHBarScrollHelper  *scrollHelper;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) CGFloat scrollSpeedFactor;
@property (nonatomic, assign) BOOL scrollingEnabled;
@property (nonatomic, assign) CGFloat            lastPointY;
@property (nonatomic, assign) CGFloat            moveOffset;
@end


@implementation NHBarScrollTool

+ (instancetype)barToolWithController:(__kindof UIViewController *)viewController
                           scrollView:(UIScrollView *)scrollView
                        navigationBar:(__kindof UIView *)navigationBar
                               tabBar:(__kindof UIView *)tabBar {
    
    return [[[NHBarScrollTool alloc] init] barToolWithController:viewController
                                                      scrollView:scrollView
                                                   navigationBar:navigationBar
                                                          tabBar:tabBar];
}

- (instancetype)barToolWithController:(__kindof UIViewController *)viewController
                           scrollView:(UIScrollView *)scrollView
                        navigationBar:(__kindof UIView *)navigationBar
                               tabBar:(__kindof UIView *)tabBar {
    
    if (self == [super init]) {
        
        UIView *navBar = navigationBar; // ?: viewController.navigationController.navigationBar;
        UITabBar *tBar = tabBar; // ?: viewController.tabBarController.tabBar;
        self.scrollHelper.currentConteroller = viewController;
        self.scrollHelper.tabBarController = viewController.tabBarController;
        self.scrollHelper.navigationView = navBar;
        self.scrollHelper.tabBar = tBar;
        self.scrollHelper.scrollView = scrollView;
        [self updateConstraints];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        if (scrollView) {
//            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//            pan.delegate = self;
//            _scrollingEnabled = YES;
//            [scrollView addGestureRecognizer:pan];
        }
    }
    return self;
}

- (void)deviceOrientationDidChange:(NSNotification *)note {
    [self updateConstraints];
}

- (void)updateConstraints {
    _scrollHelper.navBarOriginallY = _scrollHelper.navigationView.top;
    _scrollHelper.tabBarOriginallY = _scrollHelper.tabBar.top;
    _scrollHelper.navgationHeight = _scrollHelper.navigationView.height + _scrollHelper.navigationView.top;
    _scrollHelper.tabbarHeight = _scrollHelper.tabBar.height;
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    UIView *superview = _scrollHelper.scrollView?: _scrollHelper.scrollView.superview;
    CGPoint translation = [gesture translationInView:superview];
//    CGFloat delta = (_lastContentOffset - translation.y) / _scrollSpeedFactor;
    
    _moveOffset = _lastPointY - translation.y;
    _lastPointY = translation.y;
    
    [self updateNavigationBarFrame];
    [self updateTabBarFrame];
}

- (void)updateNavigationBarFrame {
    CGFloat pageBarOffsetY = _scrollHelper.navigationView.top;
    CGFloat referencePoint = (_scrollHelper.navgationHeight - _scrollHelper.navBarOriginallY);
    
    UIPanGestureRecognizer *pan = _scrollHelper.scrollView.panGestureRecognizer;
    CGFloat velocity = [pan velocityInView:_scrollHelper.scrollView].y;
//    NHSLog(@"velocity %f   %f",velocity,self.scrollHelper.scrollView.contentOffset.y);
    
    if (self.scrollHelper.scrollView.contentOffset.y < -88) {
        return;
    }
    
    if (velocity > 100) {
        if (_moveOffset < 0) {
            [UIView animateWithDuration:0.1 animations:^{
                self.scrollHelper.navigationView.top = self.scrollHelper.navBarOriginallY;
            }];
            return;
        }
    }
    
    
        if (pageBarOffsetY < -referencePoint) {
            [UIView animateWithDuration:0.1 animations:^{
                self.scrollHelper.navigationView.top = -referencePoint;
            }];

            return;
        }
        
//        NHSLog(@"updateNavigationBarFrame  %f  %f  %f",pageBarOffsetY,referencePoint,_moveOffset);
    
        if (pageBarOffsetY >= _scrollHelper.navBarOriginallY && (_moveOffset < 0)) {
            [UIView animateWithDuration:0.1 animations:^{
                self.scrollHelper.navigationView.top = self.scrollHelper.navBarOriginallY;
            }];

            return;
        }
        
        if (pageBarOffsetY == _scrollHelper.navBarOriginallY) {
            if (_moveOffset < 0) {
//                _scrollHelper.navigationView.top = _scrollHelper.navBarOriginallY;
                return;
            }
        }
    
    if (_moveOffset <= 0) {
        if (_moveOffset < -_scrollHelper.navgationHeight) {
            [UIView animateWithDuration:0.1 animations:^{
                self.scrollHelper.navigationView.top = self.scrollHelper.navBarOriginallY;
            }];

            return;
        } else if (_moveOffset > _scrollHelper.navgationHeight) {
            [UIView animateWithDuration:0.1 animations:^{
                self.scrollHelper.navigationView.top = -referencePoint;
            }];
            return;
        }
    }
    
    _scrollHelper.navigationView.top -= _moveOffset;

}

- (void)updateTabBarFrame {
    
    CGFloat tabBarTop = self.scrollHelper.tabBar.top;
    CGFloat tabBarMaxY = kScreenHeight + _tabBarBulgeOffset + kTabBarBottomPad;
    
//    NHSLog(@"%f--%f",tabBarTop,_moveOffset);
    
    if (_moveOffset > 0) {//上
        if (tabBarTop >= tabBarMaxY) {
            [UIView animateWithDuration:0.1 animations:^{
                self.scrollHelper.tabBar.top = tabBarMaxY;
            }];
            return;
        }
        
    } else {//下
        if (tabBarTop <= self.scrollHelper.tabBarOriginallY) {
            [UIView animateWithDuration:0.1 animations:^{
                self.scrollHelper.tabBar.top = self.scrollHelper.tabBarOriginallY;
            }];
            return;
        }
    }
    self.scrollHelper.tabBar.bottom += _moveOffset;
    //    NSLog(@"%f <--> %f",moveOffset,tab.tabBar.bottom);
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
    return fabs(velocity.y) > fabs(velocity.x);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch {
    return _scrollingEnabled;
}


- (void)setTabBarBulgeOffset:(CGFloat)tabBarBulgeOffset {
    self.scrollHelper.tabBarBulgeOffset = tabBarBulgeOffset;
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
    self.weakRefTargets = [NSPointerArray weakObjectsPointerArray];
    for (id delegate in delegateTargets) {
        [self.weakRefTargets addPointer:(__bridge void * _Nullable)(delegate)];
    }
    [self.weakRefTargets addPointer:(__bridge void * _Nullable)(self.scrollHelper)];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end



