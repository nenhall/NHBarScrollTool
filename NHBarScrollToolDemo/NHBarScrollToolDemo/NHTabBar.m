//
//  NHTabBar.m
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/8.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "NHTabBar.h"
#import <NHBarScrollTool.h>

@interface NHTabBar ()
@property (nonatomic ,weak) UIButton *centerBtn;
@property (nonatomic, copy) BKTabBarClickBlock centerBtnblock;

@end

@implementation NHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景图
        [self addPlusButton];
    }
    return self;
}

//添加中间按钮
- (void)addPlusButton {
    UIColor  *normalColor = [UIColor lightGrayColor];
    UIColor  *selectedColor = [UIColor redColor];
    //设置中间按钮图片和尺寸
    UIButton *centerBtn = [[UIButton alloc] init];
    [centerBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [centerBtn setTitleColor:selectedColor forState:UIControlStateSelected];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"living_n"] forState:UIControlStateNormal];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"living_p"] forState:UIControlStateHighlighted];
    centerBtn.size = centerBtn.currentBackgroundImage.size;
    [centerBtn addTarget:self action:@selector(clickPlusButton) forControlEvents:UIControlEventTouchUpInside];
    self.centerBtn = centerBtn;
    [self addSubview:centerBtn];
}

//点击了中间那个按钮
- (void)clickPlusButton{
    if (self.centerBtnblock) {
        self.centerBtnblock();
    }
}

- (void)setBtnClickBlock:(BKTabBarClickBlock)block {
    self.centerBtnblock = block;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置所有button的frame
    [self setAllButtonsFrame];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

//重新设置button的位置
- (void)setAllButtonsFrame {
    
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    
    self.centerBtn.centerX = self.centerX;
    //调整中间按钮的中线点Y值
    self.centerBtn.centerY = self.height * 0.25;
    CGFloat buttonWidth = 50;
    CGFloat halfWidth = (self.width - _centerBtn.width) / 2;
    CGFloat space =  (halfWidth - (buttonWidth * 2)) / 3;
    NSInteger btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
                                        //按钮宽度为TabBar宽度减去中间按钮宽度的一半
            
            btn.width = buttonWidth;
//            btn.centerY = self.height * 0.6;
            
            if (btnIndex == 0) {
                btn.centerX = self.width * 0.25 - space;
            } else if (btnIndex == 1) {
                btn.centerX = self.width * 0.75 + space;
            }
            
            //如果五个按钮的时候，把下面的两个 if 打开，上面两个 if 注释
            //            if (btnIndex < 2) {
            //                btn.left = ((buttonWidth * btnIndex) + (space * btnIndex)) + space;
            //            } else { //中间按钮后的宽度
            //                btn.left = _centerBtn.width + ((buttonWidth * btnIndex) + (space * btnIndex)) + (space * 2);
            //            }
            
            btnIndex++;
            //如果是索引是0(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来中间按钮的位置
            if (btnIndex == 0) {
                btnIndex++;
            }
        }
    }
    
    [self bringSubviewToFront:self.centerBtn];
}

//重写hitTest方法，去监听中间按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //判断当前手指是否点击到中间按钮上，如果是，则响应按钮点击，其他则系统处理
    //首先判断当前View是否被隐藏了，隐藏了就不需要处理了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到中间按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.centerBtn];
        
        //判断如果这个新的点是在中间按钮身上，那么处理点击事件最合适的view就是中间按钮
        if ( [self.centerBtn pointInside:newP withEvent:event]) {
            return self.centerBtn;
        }
    }
    
    return [super hitTest:point withEvent:event];
}


@end
