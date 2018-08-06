//
//  NSTimer+NHAutoRetain.m
//  NHExtension
//
//  Created by neghao on 2017/1/8.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "NSTimer+NHAutoRetain.h"

@implementation NSTimer (NHAutoRetain)

+ (NSTimer *)nh_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block{
    
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(nh_blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)nh_timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block
{
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(nh_blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)nh_blcokInvoke:(NSTimer *)timer {
    
    void (^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

@end
