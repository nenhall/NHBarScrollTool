//
//  NSDictionary+NHJSON.h
//  NHExtension
//
//  Created by chendb on 2017/4/17.
//  Copyright © 2017年 neghao.studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NHJSON)

//将nsstring类型的json数据结构   转化为NSDictionary类型结构
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
