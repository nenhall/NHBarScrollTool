//
//  NSString+NHExtension.h
//  NHExtension
//
//  Created by simope on 16/6/13.
//  Copyright © 2016年 simope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NHExtension)

//等级+名字
+ (NSAttributedString *)addAttachmentImage:(NSString *)image Title:(NSString *)title Color:(UIColor *)color;

+ (NSAttributedString *)addAttachmentImageName:(NSString *)image width:(CGFloat)width height:(CGFloat)height;



/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


/**
 *  将字符转成 1.8w 的显示格式
 *
 *  @param str 要转换的string
 *
 *  @return 转换后的string
 */
- (NSString *)stringUpdataShowFormatWithNum:(int)num;


/**
 *  判断是否含有表情
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;


/**
 *  判定是否为有效的手机号
 */
+ (BOOL)isMobile:(NSString*)mobile;
- (BOOL)isMobile;

/**
 *  简单判定是否为有效的身份证号
 */
+ (BOOL)simpleVerifyIdentityCardNum:(NSString *)IDCard;

/**
 *  精确的身份证号有效性检测
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

/**
 md5加密
 */
- (NSString *)md5String;



@end
