//
//  NSDate+switch.m
//  NH_EXTENSION
//
//  Created by neghao on 2017/9/19.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "NSDate+switchDate.h"

@implementation NSDate (switchDate)

/**
 *  把当前时间转换成20161110104101
 *
 *  @param data 传入要转换的date，不传默认为当前时间
 */
+ (NSString *)getCurrentDateBaseStyleWithData:(NSData *)data{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags;
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
    } else {
        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    }
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    comps = [calendar components:unitFlags fromDate:data ? nil : currentDate];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    //This sets the label with the updated time.
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSInteger sec = [comps second];
    NSString *dataString = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld%ld",year,month,week,day,hour,min,sec];
    return dataString;
}


/**
 *  timeInterval转换成年.月.日格式字符串
 *
 *  @param timeInterval timeInterval
 */
+ (NSString *)timeIntervalConvertYearMonthDayStyleString:(NSString *)timeInterval
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:([timeInterval doubleValue] / 1000.0)];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSString *newStr = [confromTimespStr componentsSeparatedByString:@" "].firstObject;
    NSArray *array = [newStr componentsSeparatedByString:@"-"];
    NSString *time = [array componentsJoinedByString:@"."];
    return time;
}


/**
 *  时间戳转换成具体时间
 */
+ (NSString *)timeIntervalConvertDetailDateTimeWith:(NSTimeInterval)timeInterval{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设置格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000.0];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}



/**
 * 传入格式：2016-09-28 09:20:35 计算两时间间隔时间
 */
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSTimeInterval value = [self timeFormatterWithStartTime:startTime endTime:endTime];
    
    return [self intervalTimeWithValue:value];
}


/**
 *  从某个时间戳到现在的时间间隔
 */
+ (NSString *)dateTimeDifferenceEverSinceWithStarTimeInterval:(NSTimeInterval)starTimeInterval{
    
    NSString *startTime = [self timeIntervalConvertDetailDateTimeWith:starTimeInterval];
    NSString *endTime = [self getCurrentDateStr];
    
    NSTimeInterval value = [self timeFormatterWithStartTime:startTime endTime:endTime];
    
    return [self intervalTimeWithValue:value];
}


/**
 *  计算两时间戳的时间间隔
 */
+ (NSString *)dateTimeDifferenceWithStarTimeInterval:(NSTimeInterval)starTimeInterval endTimeInterval:(NSTimeInterval)endTimeInterval{
    
    NSString *startTime = [self timeIntervalConvertDetailDateTimeWith:starTimeInterval];
    NSString *endTime = [self timeIntervalConvertDetailDateTimeWith:endTimeInterval];
    
    NSTimeInterval value = [self timeFormatterWithStartTime:startTime endTime:endTime];
    
    return [self intervalTimeWithValue:value];
}


/**
 *  时间格式转换成数值 Format:@"yyyy-MM-dd HH:mm:ss"  > To:  123
 */
+ (NSTimeInterval)timeFormatterWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD = [date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    return value;
}


/**
 *  将时间差值转换成 00:00:00:00 天:小时:分钟:秒钟
 */
+ (NSString *)intervalTimeWithValue:(int)value{
    
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%02d:%02d:%02d:%02d",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"%02d:%02d:%02d",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"00:%02d:%02d",minute,second];
    }else{
        str = [NSString stringWithFormat:@"00:00:%02d",second];
    }
    return str;
}


/**
 *  获取当前日期、时间，格式: YYYY-MM-dd hh:mm:ss
 */
+ (NSString *)getCurrentDateStr{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//@"YYYY-MM-dd hh:mm:ss SS"
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}



+ (NSDateComponents *)componetsWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dateOne = [NSDate date];
    NSDate *dateTwo = [NSDate dateWithTimeInterval:timeInterval sinceDate:dateOne];
    unsigned int unitFlags = NSSecondCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    return [calendar components:unitFlags fromDate:dateOne toDate:dateTwo options:0];
}


+ (NSString *)timeDescriptionOfTimeInterval:(NSTimeInterval)timeInterval
{
    NSDateComponents *components = [[self class] componetsWithTimeInterval:timeInterval];
    NSLog(@"%@",[NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld", (long)components.hour, (long)components.minute, (long)components.second]);
    return [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld", (long)components.hour, (long)components.minute, (long)components.second];
}


+ (NSString *)startTimeWithTimeInterval:(NSTimeInterval)timeInterval{
    
    return [NSString stringWithFormat:@"%@",[[self class] timeDescriptionOfTimeInterval:timeInterval ]];
}


//判定当前的时间段
+(NSString *)compareDate:(NSDate *)date{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *yesterday, *beforeYesterday;
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeYesterday = [today dateByAddingTimeInterval:-secondsPerDay * 2];
    
    // 10 first characters of description is the calendar date:
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeYesterdayStr = [[beforeYesterday description] substringToIndex:10];
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *nowyear = [todayString substringWithRange:NSMakeRange(0, 4)];
    NSString *dateyear = [dateString substringWithRange:NSMakeRange(0, 4)];
    //     NSLog(@"date = %@  dateString = %@ nowyear = %@",[date description],todayString,nowyear);
    if ([dateString isEqualToString:todayString])
    {
        return [NSString stringWithFormat:@"今天%@",[[date description] substringWithRange:NSMakeRange(10, 6)]];
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return [NSString stringWithFormat:@"昨天%@",[[date description] substringWithRange:NSMakeRange(10, 6)]];
    }else if ([dateString isEqualToString:beforeYesterdayStr])
    {
        return [NSString stringWithFormat:@"前天%@",[[date description] substringWithRange:NSMakeRange(10, 6)]];
    }
    else
    {
        if ([dateyear isEqualToString:nowyear]) {
            return [NSString stringWithFormat:@"%@",[[date description] substringWithRange:NSMakeRange(5, 11)]];
        }else{
            return dateString;
        }
    }
}


+ (NSString *)convertStrToTime:(long long)time{
    //    long long time = [timeStr longLongValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    NSString    *timeString = [formatter stringFromDate:date];
    return timeString;
}


+ (NSString *)format:(NSString *)string{
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate*inputDate = [inputFormatter dateFromString:string];
    //    NSLog(@"startDate= %@", inputDate);
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //get date str
    NSString *str= [outputFormatter stringFromDate:inputDate];
    //str to nsdate
    NSDate *strDate = [outputFormatter dateFromString:str];
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: strDate];
    NSDate *endDate = [strDate  dateByAddingTimeInterval: interval];
    //    NSLog(@"endDate:%@",endDate);
    NSString *lastTime = [[self class] compareDate:endDate];
    //    NSLog(@"lastTime = %@",lastTime);
    return lastTime;
}


-(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //修正8小时之差
    NSDate *date1 = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    NSDate *localeDate = [date1  dateByAddingTimeInterval: interval];
    
    //NSLog(@"nowdate=%@\nolddate = %@",localeDate,date);
    NSDate *today = localeDate;
    NSDate *yesterday,*beforeOfYesterday;
    //今年
    NSString *toYears;
    
    toYears = [[today description] substringToIndex:4];
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears = [[date description] substringToIndex:4];
    
    NSLog(@"date = %@",[date description]);
    
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        //今 昨 前天的时间
        NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
        //其他时间
        NSString *time2 = [[date description] substringWithRange:(NSRange){5,11}];
        if ([dateString isEqualToString:todayString]){
            dateContent = [NSString stringWithFormat:@"今天 %@",time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            dateContent = [NSString stringWithFormat:@"昨天 %@",time];
            return dateContent;
        }else if ([dateString isEqualToString:beforeOfYesterdayString]){
            dateContent = [NSString stringWithFormat:@"前天 %@",time];
            return dateContent;
        }else{
            return time2;
        }
    }else{
        return dateString;
    }
}

//当前时间转换成时间戳不计算毫秒
+ (NSString*)getCurrentTimestamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

//当前时间转换成时间戳 加毫秒
+ (NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    NSLog(@"传入的时间戳=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

//将NSDate类型的时间转换为时间戳,从1970/1/1开始
+ (long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    NSLog(@"转换的时间戳=%f",interval);
    long long totalMilliseconds = interval*1000 ;
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
    
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc ] init];
    //    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    //    NSString *timeLocal =  [formatter stringFromDate:[NSDate date]];
    //    NSLog(@"timeLocal:%@", timeLocal);
    
    //    NSDate *dat = [self getDateTimeFromMilliSeconds:time];
    //    NSDateFormatter * formatter2 = [[NSDateFormatter alloc ] init];
    //    [formatter2 setDateFormat:@"YYYY-MM-dd hh:mm:ss.SSS"];
    //    NSString *date2 = [formatter stringFromDate:dat];
    //    NSString *timeLocal2 = [[NSString alloc] initWithFormat:@"%@", date2];
    //    NSLog(@"timeLocal2\n%@", timeLocal2);
}



@end
