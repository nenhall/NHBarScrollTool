//
//  UIDevice+NHExtension.h
//  NHExtension
//
//  Created by nenhall_work on 2018/7/12.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    NHDevicePlatform_unknown,/**< 未知设备 */
    NHDevicePlatform_iPhone1,
    NHDevicePlatform_iPhone3,
    NHDevicePlatform_iPhone3GS,
    NHDevicePlatform_iPhone4,
    NHDevicePlatform_iPhone4S,
    NHDevicePlatform_iPhone5,
    NHDevicePlatform_iPhone5C,
    NHDevicePlatform_iPhone5S,
    NHDevicePlatform_iPhone6,
    NHDevicePlatform_iPhone6P,
    NHDevicePlatform_iPhone6S,
    NHDevicePlatform_iPhone6SP,
    NHDevicePlatform_iPhoneSE,
    NHDevicePlatform_iPhone7,
    NHDevicePlatform_iPhone7P,
    NHDevicePlatform_iPhone8,
    NHDevicePlatform_iPhone8P,
    NHDevicePlatform_iPhoneX,
    NHDevicePlatform_iPodTouch,
    NHDevicePlatform_iPodTouch2,
    NHDevicePlatform_iPodTouch3,
    NHDevicePlatform_iPodTouch4,
    NHDevicePlatform_iPodTouch5,
    NHDevicePlatform_iPad,
    NHDevicePlatform_iPad2,
    NHDevicePlatform_iPad3,
    NHDevicePlatform_iPad4,
    NHDevicePlatform_iPad5,
    NHDevicePlatform_iPad6,
    NHDevicePlatform_iPadMini,
    NHDevicePlatform_iPadMini2,
    NHDevicePlatform_iPadMini3,
    NHDevicePlatform_iPadMini4,
    NHDevicePlatform_iPadPro9_7,
    NHDevicePlatform_iPadPro12_9,
    NHDevicePlatform_iPadPro12_9_2nd,
    NHDevicePlatform_iPadPro10_5,
    NHDevicePlatform_iPadAir,
    NHDevicePlatform_iPadAir2,
    NHDevicePlatform_simulator,/**< 模拟器 */
} NHDevicePlatform;

@interface UIDevice (NHExtension)

/** 设备名称 */
+ (NSString *)currentDeviceName;

/** 获得当前具体的设置型号 */
+ (NHDevicePlatform)devicePlatform;

@end
