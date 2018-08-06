//
//  UITextView+NHExtension.m
//  NHExtension
//
//  Created by neghao on 2016/8/24.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

/** 注意先设置textView的字体 */

#import "UITextView+NHExtension.h"
#import <objc/runtime.h>

#define LEFT_MARGIN 5
#define TOP_MARGIN  8

@implementation UITextView (NHPlaceholder)

- (NSString *)placeholder{
     return self.label.text;
}

- (void)setPlaceholder:(NSString *)placeholder{

    //赋值修改高度
    self.label.text = placeholder;
    [self changeLabelFrame];
    if (self.text == nil || [self.text isEqualToString:@""]) {
        self.label.hidden = NO;
    }else{
        self.label.hidden = YES;
    }
    if ([self.text isEqualToString:@""]) {
        self.label.hidden = NO;
    }
    //监听文本改变,如果没有设置placeholder就不会监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

//文本修改
- (void)textDidChange:(NSNotification *)notify{
   self.label.hidden = self.text.length;
}

- (UILabel *)label{
    
    UILabel *label =  objc_getAssociatedObject(self, @"label");
    
    if (label == nil) {
        //没有就创建,并设置属性
        label = [[UILabel alloc] init];
        label.font = self.font;
        label.frame = self.bounds;
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        [self addSubview:label];
        
        //关联到自身
        objc_setAssociatedObject(self, @"label", label, OBJC_ASSOCIATION_RETAIN);
       
    }
    
    return label;
}

//计算frame
- (void)changeLabelFrame{
    //文字可显示区域
    CGSize size = CGSizeMake(self.bounds.size.width, CGFLOAT_MAX);
    //计算文字所占区域
    CGSize labelSize = [self.placeholder boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.label.font} context:nil].size;
    self.label.frame = CGRectMake(LEFT_MARGIN, TOP_MARGIN, labelSize.width, labelSize.height);
    self.label.hidden = NO;
    [self.label setText:self.placeholder];
}
@end
