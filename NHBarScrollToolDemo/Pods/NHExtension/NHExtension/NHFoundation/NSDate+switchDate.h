//
//  NSDate+switch.h
//  NH_EXTENSION
//
//  Created by neghao on 2017/9/19.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (switchDate)

+ (NSString *)timeDescriptionOfTimeInterval:(NSTimeInterval)timeInterval;

+ (NSString *)startTimeWithTimeInterval:(NSTimeInterval)timeInterval;

//判定当前的时间段
+ (NSString *)compareDate:(NSDate *)date;

+ (NSString *)convertStrToTime:(long long)time;

+ (NSString *)format:(NSString *)string;


/**
 *  把当前时间转换成20161110104101
 *
 *  @param data 传入要转换的date，不传默认为当前时间
 */
+ (NSString *)getCurrentDateBaseStyleWithData:(NSData *)data;


/**
 *  timeInterval转换成年\月\日格式字符串
 *
 *  @param timeInterval timeInterval
 */
+ (NSString *)timeIntervalConvertYearMonthDayStyleString:(NSString *)timeInterval;


/**
 *  时间戳转换成具体时间
 *
 *  @param timeInterval 需要转换的时间戳
 *
 *  @return 返回格式:2016-09-28 09:20:35
 */
+ (NSString *)timeIntervalConvertDetailDateTimeWith:(NSTimeInterval)timeInterval;


/**
 *  传入格式：2016-09-28 09:20:35 计算两时间间隔时间
 *
 *  @param startTime 开始时间
 *  @param endTime   结束时间
 *
 *  @return 消耗总用时
 */
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;


/**
 *  从某个时间戳到现在的时间间隔
 *
 *  @param starTimeInterval 开始时间戳
 *
 *  @return 消耗总用时
 */
+ (NSString *)dateTimeDifferenceEverSinceWithStarTimeInterval:(NSTimeInterval)starTimeInterval;


/**
 *  计算两时间戳的时间间隔
 *
 *  @param starTimeInterval 开始时间戳
 *  @param endTimeInterval  结束时间戳
 *  @return 消耗总用时
 */
+ (NSString *)dateTimeDifferenceWithStarTimeInterval:(NSTimeInterval)starTimeInterval endTimeInterval:(NSTimeInterval)endTimeInterval;


/**
 *  获取当前日期、时间，格式: YYYY-MM-dd hh:mm:ss
 *
 *  @return 返回时间字符串
 */
+ (NSString *)getCurrentDateStr;


/**
 *  时间格式转换成数值 Format:@"yyyy-MM-dd HH:mm:ss"  > To:  123
 */
+ (NSTimeInterval)timeFormatterWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;


//当前时间转换成时间戳
+ (long long)getDateTimeTOMilliSeconds:(NSDate *)datetime;


//当前时间转换成时间戳 加毫秒
+ (NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds;

@end
