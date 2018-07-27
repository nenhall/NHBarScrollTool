//
//  NSTimer+AutoRetain.h
//  BaiKeTheVoice
//
//  Created by neghao on 2017/1/8.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (AutoRetain)
+ (NSTimer *)nh_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                        repeats:(BOOL)repeats
                                          block:(void(^)(NSTimer *timer))block;
@end
