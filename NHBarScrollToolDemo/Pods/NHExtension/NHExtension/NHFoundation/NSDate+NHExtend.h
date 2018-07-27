//
//  NSDate+NHExtend.h
//  DZNEmptyDataSet
//
//  Created by neghao on 2018/7/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    NHDateFormatYYYYMMdd,/**< year month day */
    NHDateFormatYYYYMMddHH,/**< year month day hour */
    NHDateFormatYYYYMMddHHmm,/**< year month day hour minute */
    NHDateFormatYYYYMMddHHmmss,/**< year month day hour minute second */
} NHDateFormat;


@interface NSDate (NHExtend)

#pragma mark - Properties
///=============================================================================
/// @Properties
///=============================================================================

/** The number of timestamp for the receiver. */
@property(nonatomic, readonly) NSUInteger timeStamp;

/** The number of Year units for the receiver. */
@property (nonatomic, readonly) NSInteger year;

/** The number of Month units for the receiver (1~12). */
@property (nonatomic, readonly) NSInteger month;

/** The number of Day units for the receiver (1~31). */
@property (nonatomic, readonly) NSInteger day;

/** The number of Hour units for the receiver (0~23). */
@property (nonatomic, readonly) NSInteger hour;

/** The number of Minute units for the receiver (0~59). */
@property (nonatomic, readonly) NSInteger minute;

/** The number of Second units for the receiver (0~59). */
@property (nonatomic, readonly) NSInteger second;

/** The number of Nanosecond units for the receiver (0~999). */
@property (nonatomic, readonly) NSInteger nanosecond;

/** The number of Weekday units for the receiver (1~7, first day is based on user setting). */
@property (nonatomic, readonly) NSInteger weekday;

/** The ordinal number of weekday units for the receiver (1~5). */
@property (nonatomic, readonly) NSInteger weekdayOrdinal;

/** The week number of the month for the receiver (1~5). */
@property (nonatomic, readonly) NSInteger weekOfMonth;

/** The week number of the year for the receiver (1~53). */
@property (nonatomic, readonly) NSInteger weekOfYear;

/** The ISO 8601 week-numbering year of the receiver. */
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;

/** The number of quarters for the receiver. */
@property (nonatomic, readonly) NSInteger quarter;

/** Boolean value that indicates whether the month is a leap month. */
@property (nonatomic, readonly) BOOL isLeapMonth;

/** Boolean value that indicates whether the month is a leap year. */
@property (nonatomic, readonly) BOOL isLeapYear;

#pragma mark - Convert
///=============================================================================
/// @Convert
///=============================================================================

/** 转换成带毫秒的时间戳,从1970/1/1开始 传nil为当前时间 */
+ (NSUInteger)timeStampAppendMilliscond:(NSDate *)date;

/** 把时间戳转换成NSDate 传0为当前时间 */
+ (nullable NSDate *)dataFromTimeStamp:(NSUInteger)timeStamp;

/**
 Returns a date parsed from given string interpreted using the format.
 
 @param dateString The string to parse.
 @param format     The string's date format.
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 Return a formate date string using the separator. e.g 2017-08-08
 */
- (NSString *)formatDateWithSeparator:(NSString *)separator;

/**
 自定义时间格式转换
 
 @param separator 分隔标示
 @param format 显示格式
 */

- (NSString *)formatDateWithSeparator:(NSString *)separator format:(NHDateFormat)format;

/**
 Return a formate time string using the separator. e.g 08:08
 */
- (NSString *)formatTimeWithSeparator:(NSString *)separator;

/**
 Returns current timestamp.
 */
+ (NSUInteger)timeStamp;

/**
 Return a Boolean value that indicates whether the data within today.
 */
- (BOOL)isInToday;

/**
 Return a Boolean value that indicates whether the data within yesterday.
 */
- (BOOL)isInYesterday;

/**
 Return a Boolean value that indicates whether the data within tomorrow.
 */
- (BOOL)isInTomorrow;

/**
 Return a Boolean value that indicates whether the data within current week.
 */
- (BOOL)isInThisWeek;

/**
 Return a Boolean value that indicates whether the data within current month.
 */
- (BOOL)isInThisMonth;

/**
 Return a Boolean value that indicates whether the data within current year.
 */
- (BOOL)isInThisYear;

/**
 *  计算两时间戳的时间间隔 reutrn 天:小时:分钟:秒钟
 *
 *  @param starTime 开始时间戳 传0为当前时间
 *  @param endTime  结束时间戳，传0为当前时间
 *  @return 天:小时:分钟:秒钟
 */
+ (NSString *)timeDifferenceWithStarTime:(NSUInteger)starTime
                                 endTime:(NSUInteger)endTime;

@end
