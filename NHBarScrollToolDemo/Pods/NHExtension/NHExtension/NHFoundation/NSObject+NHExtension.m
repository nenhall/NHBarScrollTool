//
//  NSObject+NHExtension.m
//  NHExtension
//
//  Created by simope on 16/6/13.
//  Copyright © 2016年 simope. All rights reserved.
//

#import "NSObject+NHExtension.h"

@implementation NSObject (NHExtension)


+ (NSMutableAttributedString *)setTextColorWithStr:(NSString *)str Color:(UIColor *)color Range:(NSRange)range{
    
    if (str == nil) return nil;

    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:str];
    [newStr addAttribute:NSForegroundColorAttributeName value:color range:range];

    return newStr;
}

+ (NSMutableAttributedString *)setTextFontWithStr:(NSString *)str Font:(UIFont *)font Range:(NSRange)range{
    
    if (str == nil) return nil;
    
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:str];
    [newStr addAttribute:NSFontAttributeName value:font range:range];
    
    return newStr;
}


+ (BOOL)isEmptyString:(NSString *)string{
    if(string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
        return YES;
    }
    return NO;
}


+ (BOOL)isEmptyArray:(NSArray *)array{
    if(array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0){
        return YES;
    }
    return NO;
}

@end



