//
//  UIColor+NHExtension.h
//  NHExtension
//
//  Created by simope on 16/7/19.
//  Copyright © 2016年 facebac. All rights reserved.
//

#import <UIKit/UIKit.h>

//颜色字符串返回一个颜色组
#define  kHexColor(hex)        [UIColor colorWithHEX:hex]
#define  kcallColor(hex)        [UIColor callColorFromHexRGB:hex]

//通过图片获取图片颜色
#define  kColorWithPatternImage(image)    \
[UIColor colorWithPatternImage:image]

//通过图片名获取图片颜色
#define  kColorWithPatternImageName(imageName) \
[UIColor colorWithPatternImageName:imageName]


@interface UIColor (NHExtension)

+ (UIColor *)colorWithHEX:(uint)color;
+ (NSArray*)colorForHex:(NSString *)hexColor;
+ (UIColor *)colorWithHexString:(NSString *)color;  //
+ (UIColor *)randomColor;
+ (UIColor *)flashColorWithRed:(uint)red green:(uint)green blue:(uint)blue alpha:(float)alpha;
+ (UIColor *)colorWithPatternImageName:(NSString *)imageName;

/*颜色:得到16#转rgb   增加*/
+ (UIColor *) callColorFromHexRGB:(NSString *) inColorString;

+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha;

@end
