//
//  UILabel+VerticalAlignment.m
//  NHExtension
//
//  Created by neghao on 2017/8/24.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "UILabel+VerticalAlignment.h"

@implementation UILabel (VerticalAlignment)
- (void)textAlignmentTop {
    self.numberOfLines = 0;
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double finalWidth = self.frame.size.width;
    CGSize maximumSize = CGSizeMake(finalWidth, CGFLOAT_MAX);
    CGRect stringSize = [self.text boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    int lines = (self.frame.size.height - stringSize.size.height) / fontSize.height;
    for (int i = 0; i < lines; i++) {
        self.text = [self.text stringByAppendingString:@"\n"];
    }
}

- (void)textAlignmentBottom {
    self.numberOfLines = 0;
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double finalWidth = self.frame.size.width;
    CGSize maximumSize = CGSizeMake(finalWidth, CGFLOAT_MAX);
    CGRect stringSize = [self.text boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    int lines = (self.frame.size.height - stringSize.size.height) / fontSize.height;
    for (int i = 0; i < lines; i++) {
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}



@end
