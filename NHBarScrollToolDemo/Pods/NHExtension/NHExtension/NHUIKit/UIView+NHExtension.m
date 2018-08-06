//
//  UIView+NHExtension.m
//  NHExtension
//
//  Created by neghao on 2016/8/24.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "UIView+NHExtension.h"
#import <objc/runtime.h>

IB_DESIGNABLE
@implementation UIView (NHIBAppearance)

- (void)setBorderColor:(UIColor *)borderColor {
    UIColor *bc = objc_getAssociatedObject(self, @selector(borderColor));
    if(bc == borderColor) return;
    
    objc_setAssociatedObject(self, @selector(borderColor), borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = [borderColor CGColor];
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, @selector(borderColor));
}

/**
 *  设置边框宽度
 */
- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;
    
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

/**
 *  设置圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius < 0) return;
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = (cornerRadius > 0);
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

@end


@implementation UIView (NHConstantMethod)

- (UIView *)findFirstResponder {
    UIView* baseView = self;
    
    if (baseView.isFirstResponder)
        return baseView;
    for (UIView *subview in baseView.subviews) {
        UIView *firstResponder = [subview findFirstResponder];
        if (firstResponder != nil)
            return firstResponder;
    }
    return nil;
}


/** 获取当前View的控制器对象 */
-(UIViewController *)currentViewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

+ (instancetype)loadViewFromNib {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:(NSStringFromClass([self class]))
                                                   owner:self
                                                 options:nil];
    if (views.count > 0) {
        return views.firstObject;
    }
    return nil;
}


+ (instancetype)loadCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    Class someClass = NSClassFromString(className);
    NSString *identifier = className;
    id obj = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!obj) {
        obj = [[someClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return obj;
}

@end


@implementation UITableViewCell (NHDisplayAnimation)

- (void)doCellAnimationWithAnimationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle
{
    __weak __typeof(&*self)weakSelf = self;
    switch (animationStyle) {
        case UITableViewCellDisplayAnimationStyleFade:
        {
            self.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.alpha = 1;
            }];
        }
            break;
        case UITableViewCellDisplayAnimationStyleScale:
        {
            self.layer.transform = CATransform3DMakeScale(0.2, 0.2, 1);
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }];
        }
            break;
        case UITableViewCellDisplayAnimationStylePosition:
        {
            self.transform = CGAffineTransformTranslate(self.transform, -[UIScreen mainScreen].bounds.size.width/2, 0);
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.transform = CGAffineTransformIdentity;
            }];
            
        }
            break;
        case UITableViewCellDisplayAnimationStyleRotateX:
        {
            self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI, 1, 0, 0);
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.layer.transform = CATransform3DRotate(weakSelf.layer.transform, M_PI, 1, 0, 0);
            }];
            
        }
            break;
        case UITableViewCellDisplayAnimationStyleRotateY:
        {
            self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI, 0, 1, 0);
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.layer.transform = CATransform3DRotate(weakSelf.layer.transform, M_PI, 0, 1, 0);
            }];
            
        }
            break;
            
        default:
            break;
    }
}

+ (void)doCellAnimationWithAnimationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle onTheView:(UIView *)view{
    [self doCellAnimationWithAnimationStyle:animationStyle onTheView:view];
}

//cell显示动画
- (void)doCellAnimationWithAnimationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle onTheView:(UIView *)view
{
    __weak __typeof(&*self)weakSelf = self;
    switch (animationStyle) {
        case UITableViewCellDisplayAnimationStyleFade:
        {
            view.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.alpha = 1;
            }];
        }
            break;
        case UITableViewCellDisplayAnimationStyleScale:
        {
            view.layer.transform = CATransform3DMakeScale(0.2, 0.2, 1);
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }];
        }
            break;
        case UITableViewCellDisplayAnimationStylePosition:
        {
            view.transform = CGAffineTransformTranslate(view.transform, -[UIScreen mainScreen].bounds.size.width/2, 0);
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.transform = CGAffineTransformIdentity;
            }];
            
        }
            break;
        case UITableViewCellDisplayAnimationStyleRotateX:
        {
            view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 1, 0, 0);
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.layer.transform = CATransform3DRotate(weakSelf.layer.transform, M_PI, 1, 0, 0);
            }];
            
        }
            break;
        case UITableViewCellDisplayAnimationStyleRotateY:
        {
            view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 0, 1, 0);
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.layer.transform = CATransform3DRotate(weakSelf.layer.transform, M_PI, 0, 1, 0);
            }];
            
        }
            break;
            
        default:
            break;
    }
}

@end

