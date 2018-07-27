//
//  UIImageView+NHExtension.m
//  NHExtension
//
//  Created by neghao on 2016/11/25.
//  Copyright © 2016年 neghao.studio. All rights reserved.
//

#import "UIImageView+NHExtension.h"

@implementation UIImageView (NHExtension)

- (void)setRoundImage:(UIImage *)image{
    self.image = image;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.width];
    [path addClip];
    [self drawRect:self.bounds];
    self.image  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}



@end
