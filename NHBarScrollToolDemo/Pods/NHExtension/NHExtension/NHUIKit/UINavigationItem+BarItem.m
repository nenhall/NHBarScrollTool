//
//  UINavigationItem+BarItem.m
//  NHExtension
//
//  Created by neghao on 2017/6/30.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "UINavigationItem+BarItem.h"
#import "UINavigationItem_BarItemAction.h"
#import <objc/message.h>
#import "NSString+NHExtension.h"


@implementation UINavigationItem (BarItem)
static char rightItemKey;
static char leftItemKey;

-(void (^)(UIButton *))navigationLeftBarItemDidClick {
    return objc_getAssociatedObject(self, &leftItemKey);
}

- (void (^)(UIButton *))navigationRightBarItemDidClick {
    return objc_getAssociatedObject(self, &rightItemKey);
}

- (void)setNavigationLeftBarItemDidClick:(void (^)(UIButton *))navigationLeftBarItemDidClick {
    objc_setAssociatedObject(self, &leftItemKey, navigationLeftBarItemDidClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setNavigationRightBarItemDidClick:(void (^)(UIButton *))navigationRightBarItemDidClick {
    objc_setAssociatedObject(self, &rightItemKey, navigationRightBarItemDidClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (UIButton *)addLeftBarItem:(UIImage *)image title:(NSString *)title space:(CGFloat)width clickAction:(void(^)(UIButton *button))clickAction {
    CGFloat titleWidth = [title sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(CGFLOAT_MAX, 40)].size.width;
    CGFloat buttonWidth = image.size.width > titleWidth  ? image.size.width : titleWidth;

    UIButton* leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth < 40 ? 40 : buttonWidth, 40)];
    [leftButton addTarget:self action:@selector(clickLeftNavgationItem:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];

    UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationLeftBarItemDidClick = clickAction;
    self.leftBarButtonItems = @[ [self addSpaceBarItem:width], leftBarItem ];

    return leftButton;
}

- (UIButton *)addRightBarItem:(UIImage *)image title:(NSString *)title space:(CGFloat)width clickAction:(void(^)(UIButton *button))clickAction {
    CGFloat titleWidth = [title sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(CGFLOAT_MAX, 40)].size.width;
    CGFloat buttonWidth = image.size.width > titleWidth ? image.size.width : titleWidth;

    UIButton* rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth < 40 ? 40 : buttonWidth, 40)];
    [rightButton addTarget:self action:@selector(clickRightNavgationItem:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];

    UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationRightBarItemDidClick = clickAction;
    self.rightBarButtonItems = @[ rightBarItem, [self addSpaceBarItem:width] ];

    return rightButton;
}

- (UIButton *)addBadgeBarItem:(UIImage *)image title:(NSString *)title space:(CGFloat)width isLeft:(BOOL)isLeft clickAction:(void(^)(UIButton *button))clickAction {
    CGFloat titleWidth = [title sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(CGFLOAT_MAX, 40)].size.width;
    CGFloat buttonWidth = image.size.width > titleWidth ? image.size.width : titleWidth;
    UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth < 40 ? 40 : buttonWidth, 40)];
    [itemButton addTarget:self action:@selector(clickRightNavgationItem:) forControlEvents:UIControlEventTouchUpInside];
    [itemButton setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [itemButton setTitle:title forState:UIControlStateNormal];
    [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    itemButton.titleLabel.font = [UIFont systemFontOfSize:14];

    
    if (isLeft) {
        UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
        self.navigationLeftBarItemDidClick = clickAction;
        self.leftBarButtonItems = @[ [self addSpaceBarItem:width], leftBarItem ];

    } else {
        UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
        self.navigationRightBarItemDidClick = clickAction;
        self.rightBarButtonItems = @[ rightBarItem, [self addSpaceBarItem:width] ];
    }
    return itemButton;
}

- (UIBarButtonItem *)addSpaceBarItem:(CGFloat)width {
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = width;
    return spaceItem;
}

- (void)clickLeftNavgationItem:(UIButton *)button {
    if (self.navigationLeftBarItemDidClick) {
        self.navigationLeftBarItemDidClick(button);
    }
}

- (void)clickRightNavgationItem:(UIButton *)button {
    if (self.navigationRightBarItemDidClick) {
        self.navigationRightBarItemDidClick(button);
    }
}


@end
