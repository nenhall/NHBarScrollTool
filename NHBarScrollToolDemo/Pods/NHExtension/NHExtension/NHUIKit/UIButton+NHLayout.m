//
//  UIButton+NHLayout.m
//  NHExtension
//
//  Created by neghao on 2017/7/18.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "UIButton+NHLayout.h"
#include <objc/message.h>
#import "NHMacroDefineHeader.h"
#import "NH_INLINE.h"

@interface UIView (NHLayout)
@property (nonatomic, copy) NSDictionary *layoutButtons;
- (void)nh_ImageTitleLayout;
- (void)addLayoutButton:(UIButton *)button;
- (void)removeLayoutButton:(UIButton *)button;
@end

@implementation UIView (NHLayout)
NH_SYNTHESIZE_CATEGORY_OBJ_PROPERTY(layoutButtons, setLayoutButtons:)

- (void)addLayoutButton:(UIButton *)button {
    NSMutableDictionary *buttons = self.layoutButtons.mutableCopy;
    if (!buttons) {
        buttons = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    [buttons setObject:button forKey:[NSString stringWithFormat:@"%p",button]];
    self.layoutButtons = buttons.copy;
}

- (void)removeLayoutButton:(UIButton *)button {
    NSMutableDictionary *buttons = self.layoutButtons.mutableCopy;
    [buttons removeObjectForKey:[NSString stringWithFormat:@"%p",button]];
    self.layoutButtons = buttons.copy;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NH_Method_swizzling([self class], @selector(layoutSubviews), @selector(nh_layoutSubviews));
    });
}

- (void)nh_layoutSubviews {
    [self nh_layoutSubviews];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSString *key in self.layoutButtons) {
            UIButton *button = [self.layoutButtons objectForKey:key];
            if ([button respondsToSelector:@selector(nh_ImageTitleLayout)]) {
                [button nh_ImageTitleLayout];
            }
        }
    });
}

- (void)nh_ImageTitleLayout { }

@end

@interface UIButton ()
@property (nonatomic, assign) CGFloat nh_padding;
@property (nonatomic, assign) NHButtonLayoutStyle nh_layoutStyle;
@end

@implementation UIButton (NHLayout)
NH_SYNTHESIZE_CATEGORY_VALUE_PROPERTY(CGFloat, nh_padding, setNh_padding:)
NH_SYNTHESIZE_CATEGORY_VALUE_PROPERTY(NHButtonLayoutStyle, nh_layoutStyle, setNh_layoutStyle:)
NH_SYNTHESIZE_CATEGORY_VALUE_PROPERTY(BOOL, closeAutoLayoutStyleOnLayoutSubviews, setCloseAutoLayoutStyleOnLayoutSubviews:)

- (void)setLayoutStyle:(NSInteger)layout_Style {
    self.nh_layoutStyle = layout_Style;
    [self addToSuperview];
}

- (NSInteger)layoutStyle {
    return self.nh_layoutStyle;
}

- (void)setPadding:(CGFloat)_padding {
    self.nh_padding = _padding;
}

- (CGFloat)padding {
    return self.nh_padding;
}

- (void)addToSuperview {
    if (!self.closeAutoLayoutStyleOnLayoutSubviews) {
        [self.superview addLayoutButton:self];
    }
}

-(void)nh_ImageTitleLayout {
    nh_safe_dispatch_main_q(^{
        [self updateImageTitleStyle:self.nh_layoutStyle padding:self.nh_padding];
    });
}

-(void)updateImageTitleStyle:(NHButtonLayoutStyle)style padding:(CGFloat)padding
{
    self.titleEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
    
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    
    CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
    CGFloat selfHeight = self.frame.size.height;
    CGFloat selfWidth = self.frame.size.width;
    
    switch (style) {
        case NHButtonLayoutImageLeft:
            if (padding != 0)
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        padding/2,
                                                        0,
                                                        -padding/2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        -padding/2,
                                                        0,
                                                        padding/2);
            }
            break;
        case NHButtonLayoutImageRight:
        {
            //图片在右，文字在左
            self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                    -(imageRect.size.width + padding/2),
                                                    0,
                                                    (imageRect.size.width + padding/2));
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (titleRect.size.width+ padding/2),
                                                    0,
                                                    -(titleRect.size.width+ padding/2));
        }
            break;
        case NHButtonLayoutImageTop:
        {
            //图片在上，文字在下
            self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                    (selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2,
                                                    -((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                    -(selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                    (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    -((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                    -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
            
        }
            break;
        case NHButtonLayoutImageBottom:
        {
            //图片在下，文字在上。
            self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                    (selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    -((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                    -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                    (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    -((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                    -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case NHButtonLayoutImageCenterTitleTop:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y - padding),
                                                    (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    (titleRect.origin.y - padding),
                                                    -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    0,
                                                    -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case NHButtonLayoutImageCenterTitleBottom:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake((selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                    (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    -(selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                    -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    0,
                                                    -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case NHButtonLayoutImageCenterTitleUp:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                    (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                    -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    0,
                                                    -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case NHButtonLayoutImageCenterTitleDown:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake((imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                    (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                    -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                    -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                    0,
                                                    -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
        }
            break;
        case NHButtonLayoutImageRightTitleLeft:
        {
            //图片在右，文字在左，距离按钮两边边距
            
            self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                    -(titleRect.origin.x - padding),
                                                    0,
                                                    (titleRect.origin.x - padding));
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth - padding - imageRect.origin.x - imageRect.size.width),
                                                    0,
                                                    -(selfWidth - padding - imageRect.origin.x - imageRect.size.width));
        }
            
            break;
            
        case NHButtonLayoutImageLeftTitleRight:
        {
            //图片在左，文字在右，距离按钮两边边距
            
            self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                    (selfWidth - padding - titleRect.origin.x - titleRect.size.width),
                                                    0,
                                                    -(selfWidth - padding - titleRect.origin.x - titleRect.size.width));
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                    -(imageRect.origin.x - padding),
                                                    0,
                                                    (imageRect.origin.x - padding));
            
            
            
        }
            break;
        default:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
            break;
    }
}

-(void)setImageTitleStyle:(NHButtonLayoutStyle)style padding:(CGFloat)padding
{
    BOOL empty = (self.imageView.image != nil && self.titleLabel.text != nil);
    if (empty) {
        self.layoutStyle = style;
        self.padding = padding;
        [self addToSuperview];
        if (!self.superview) {
            kNSLog(@"self.superview为空，请添加到父视图设置图文排版");
        }
    } else {
        kNSLog(@"UIButton 图片或者标题为空，请添加图片和标题后再设置图文排版");
    }
}

@end
