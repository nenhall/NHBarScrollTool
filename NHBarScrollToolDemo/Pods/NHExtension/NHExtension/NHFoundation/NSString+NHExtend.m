//
//  NSString+NHExtend.m
//  NHExtension
//
//  Created by neghao on 2018/7/21.
//

#import "NSString+NHExtend.h"
#import "NSData+NHExtend.h"
#import "NSObject+NHExtend.h"

@implementation NSString (NHExtend)
- (NSString *)stringByTrim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSRange)rangeTotal
{
    return NSMakeRange(0, self.length);
}

#pragma mark - URL
- (NSString *)urlEncode
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"-_.!*'();:@$,[]"]];
}

- (NSString *)urlDecode
{
    return [self stringByRemovingPercentEncoding];
}

- (NSString *)urlAppendingKeyValue:(NSString *)keyValue
{
    NSString *separator = [self rangeOfString:@"?"].length == 0?@"?":@"&";
    return [self stringByAppendingFormat:@"%@%@",separator,keyValue];
}

- (NSString *)md5String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

- (NSString *)sha1String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1String];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA1StringWithKey:key];
}

- (id)jsonObject
{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
}

- (BOOL)matchesRegx:(NSString *)regex options:(NSRegularExpressionOptions)options
{
    if (!regex.isNoEmpty) return NO;
    
    NSError *error;
    NSRegularExpression *rx = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error) return NO;
    
    NSRange range = [rx rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return range.length != 0;
}

- (void)enumerateRegexMatches:(NSString *)regex options:(NSRegularExpressionOptions)options usingBlock:(void (^)(NSString * _Nonnull, NSRange, BOOL * _Nonnull))block
{
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!regExp) return;
    [regExp enumerateMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        block([self substringWithRange:result.range], result.range, stop);
    }];
}

- (NSString *)stringByReplacingRegex:(NSString *)regex options:(NSRegularExpressionOptions)options withString:(NSString *)replacement
{
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!pattern) return self;
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

+ (NSString *)UUIDString
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}


+ (BOOL)isEmptyOrNull:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) return  YES;
    return [self isEmptyOrNull:string];
}

- (BOOL)isEmptyOrNull:(NSString *)string {
    if (string == nil) return  YES;
    if (string == NULL) return  YES;
    if ([string isKindOfClass:[NSNull class]]) return  YES;
    
    //为null string
    if ([string isEqualToString:@"null"]) return YES;
    if ([string isEqualToString:@"(null)"]) return YES;
    
    //全是空格
    NSUInteger nh_lenght = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length];
    if (nh_lenght == 0) return  YES;
 
    return NO;
}

/**
 *  判断是否含有表情
 */
- (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    
    if (!string) {
        return NO;
    }
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if ((0x1d000 <= uc && uc <= 0x1f77f) || (0x1F900 <= uc && uc <=0x1f9ff)) { //修改(0x1F900 <= uc && uc <=0x1f9ff)
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }else if (hs == 0x200d){  //增加判断
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *M2 =@"F";
                NSString *JYM =@"10X98765432";
                NSString *JYM2 =@"10x98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                M2 = [JYM2 substringWithRange:NSMakeRange(Y,1)];
                
                NSString *LM = [value substringWithRange:NSMakeRange(17,1)];
                if ([M isEqualToString:LM] || [LM isEqualToString:M2]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
                /**
                 //计算出校验码所在数组的位置
                 NSInteger idCardMod = S % 11;
                 //得到最后一位身份证号码
                 NSString *idCardLast= [value substringWithRange:NSMakeRange(17, 1)];
                 //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                 if(idCardMod==2) {
                 if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                 return NO;
                 }
                 }
                 */
            }else {
                return NO;
            }
        default:
            return NO;
    }
}


@end
