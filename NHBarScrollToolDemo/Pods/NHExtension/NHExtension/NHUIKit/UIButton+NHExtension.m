//
//  UIButton+NHExtension.m
//  NHExtension
//
//  Created by neghao on 2016/11/24.
//  Copyright © 2016年 neghao.studio. All rights reserved.
//

#import "UIButton+NHExtension.h"
#import <objc/runtime.h>
#import "NH_INLINE.h"

@implementation UIButton (repeatRate)

+ (void)load {
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    SEL customSEL = @selector(nh_sendAction:to:forEvent:);
    NH_Method_swizzling([self class], sysSEL, customSEL);
}

- (NSTimeInterval )nhAcceptEventInterval{
    return [objc_getAssociatedObject(self, @selector(nhAcceptEventInterval)) doubleValue];
}

- (void)setNhAcceptEventInterval:(NSTimeInterval)nhAcceptEventInterval{
    objc_setAssociatedObject(self, @selector(nhAcceptEventInterval), @(nhAcceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/** 上一次接受事件的时候 */
- (NSTimeInterval )nhAcceptEventTime{
    return [objc_getAssociatedObject(self, @selector(nhAcceptEventTime)) doubleValue];
}

- (void)setNhAcceptEventTime:(NSTimeInterval)nhAcceptEventTime{
    objc_setAssociatedObject(self, @selector(nhAcceptEventTime), @(nhAcceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)nh_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    // 设置统一的间隔时间，可以在此处加上以下几句
//     if (self.custom_acceptEventInterval <= 0) {
//        self.custom_acceptEventInterval = 2;
//     }
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.nhAcceptEventTime >= self.nhAcceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.nhAcceptEventInterval > 0) {
        self.nhAcceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self nh_sendAction:action to:target forEvent:event];
    }
}

@end
