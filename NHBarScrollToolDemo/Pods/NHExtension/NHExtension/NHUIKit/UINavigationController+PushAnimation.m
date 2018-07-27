//
//  UINavigationController+PushAnimation.m
//  NHExtension
//
//  Created by neghao on 2017/8/1.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "UINavigationController+PushAnimation.h"
#import "UINavigationController_pushAnimation.h"
#import <objc/message.h>

@interface OJLNavAnimation ()
@property (nonatomic, strong)id<UIViewControllerContextTransitioning> transitionContext;
@end
@implementation OJLNavAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    UIView* contentView = [self.transitionContext containerView];
    
    
    CGPoint point = self.centerButton.center;
    UIBezierPath* origionPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x , point.y, 0, 0)];
    
    CGFloat X = [UIScreen mainScreen].bounds.size.width - point.x;
    CGFloat Y = [UIScreen mainScreen].bounds.size.height - point.y;
    CGFloat radius = sqrtf(X * X + Y * Y);
    UIBezierPath* finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(point.x , point.y, 0, 0), -radius, -radius)];
    
    UIViewController* toVc = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CAShapeLayer* layer = [CAShapeLayer layer];
    layer.path = finalPath.CGPath;
    toVc.view.layer.mask = layer;
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id _Nullable)(origionPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
    animation.duration = 0.25;
    [layer addAnimation:animation forKey:@"path"];
    
    [contentView addSubview:toVc.view];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:YES];
}
@end



@implementation UINavigationController (PushAnimation)
static char buttonKey;


- (void)setCenterButton:(UIButton *)centerButton {
    objc_setAssociatedObject(self, &buttonKey, centerButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)centerButton {
   return objc_getAssociatedObject(self, &buttonKey);
}


-(void)pushViewController:(UIViewController *)viewController withCenterButton:(UIButton *)button {
    self.centerButton = button;
    self.delegate = self;
    
    [self pushViewController:viewController animated:YES];
}


#pragma mark UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    OJLNavAnimation* animation = [OJLNavAnimation new];
    animation.centerButton = self.centerButton;
    return animation;
}

@end




@implementation UINavigationController (PopGesture)

- (void)setInteractivePopGestureRecognizerEenabled:(BOOL)enabled {

}

@end
