//
//  UIView+DisplayAnimation.m
//  NHExtension
//
//  Created by neghao on 17/1/4.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "UIView+DisplayAnimation.h"

@implementation UIView (DisplayAnimation)

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
