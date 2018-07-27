//
//  NSDictionary+NHJSON.m
//  NHExtension
//
//  Created by chendb on 2017/4/17.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import "NSDictionary+NHJSON.h"

@implementation NSDictionary (NHJSON)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
//    NSString *newString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableLeaves
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
