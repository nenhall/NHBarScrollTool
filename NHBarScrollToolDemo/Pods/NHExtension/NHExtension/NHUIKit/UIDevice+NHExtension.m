//
//  UIDevice+NHExtension.m
//  NHExtension
//
//  Created by nenhall_work on 2018/7/12.
//

#import "UIDevice+NHExtension.h"
#import <sys/sysctl.h>

@implementation UIDevice (NHExtension)

+ (NSString *)currentDeviceName {
    return [[UIDevice currentDevice] name];
}

// pragma mark 判断设备的型号
+ (NHDevicePlatform)devicePlatform {
    
    // Gets a string with the device model
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    // iPhone======
    
    if ([platform isEqualToString:@"iPhone1,1"]) return NHDevicePlatform_iPhone1;
    if ([platform isEqualToString:@"iPhone1,2"]) return NHDevicePlatform_iPhone3;
    if ([platform isEqualToString:@"iPhone2,1"]) return NHDevicePlatform_iPhone3GS;
    if ([platform isEqualToString:@"iPhone3,1"]) return NHDevicePlatform_iPhone4;
    if ([platform isEqualToString:@"iPhone3,2"]) return NHDevicePlatform_iPhone4;
    if ([platform isEqualToString:@"iPhone3,3"]) return NHDevicePlatform_iPhone4;
    if ([platform isEqualToString:@"iPhone4,1"]) return NHDevicePlatform_iPhone4S;
    if ([platform isEqualToString:@"iPhone5,1"]) return NHDevicePlatform_iPhone5;
    if ([platform isEqualToString:@"iPhone5,2"]) return NHDevicePlatform_iPhone5;
    if ([platform isEqualToString:@"iPhone5,3"]) return NHDevicePlatform_iPhone5C;
    if ([platform isEqualToString:@"iPhone5,4"]) return NHDevicePlatform_iPhone5C;
    if ([platform isEqualToString:@"iPhone6,1"]) return NHDevicePlatform_iPhone5S;
    if ([platform isEqualToString:@"iPhone6,2"]) return NHDevicePlatform_iPhone5S;
    if ([platform isEqualToString:@"iPhone7,1"]) return NHDevicePlatform_iPhone6;
    if ([platform isEqualToString:@"iPhone7,2"]) return NHDevicePlatform_iPhone6P;
    if ([platform isEqualToString:@"iPhone8,1"]) return NHDevicePlatform_iPhone6S;
    if ([platform isEqualToString:@"iPhone8,2"]) return NHDevicePlatform_iPhone6SP;
    if ([platform isEqualToString:@"iPhone8,4"]) return NHDevicePlatform_iPhoneSE;
    if ([platform isEqualToString:@"iPhone9,1"]) return NHDevicePlatform_iPhone7;
    if ([platform isEqualToString:@"iPhone9,3"]) return NHDevicePlatform_iPhone7;
    if ([platform isEqualToString:@"iPhone9,2"]) return NHDevicePlatform_iPhone7P;
    if ([platform isEqualToString:@"iPhone9,4"]) return NHDevicePlatform_iPhone7P;
    if ([platform isEqualToString:@"iPhone10,1"]) return NHDevicePlatform_iPhone8;
    if ([platform isEqualToString:@"iPhone10,4"]) return NHDevicePlatform_iPhone8;
    if ([platform isEqualToString:@"iPhone10,2"]) return NHDevicePlatform_iPhone8P;
    if ([platform isEqualToString:@"iPhone10,5"]) return NHDevicePlatform_iPhone8P;
    if ([platform isEqualToString:@"iPhone10,3"]) return NHDevicePlatform_iPhoneX;
    if ([platform isEqualToString:@"iPhone10,6"]) return NHDevicePlatform_iPhoneX;

    // iPot Touch======
    if ([platform isEqualToString:@"iPod1,1"]) return NHDevicePlatform_iPodTouch;
    if ([platform isEqualToString:@"iPod2,1"]) return NHDevicePlatform_iPodTouch2;
    if ([platform isEqualToString:@"iPod3,1"]) return NHDevicePlatform_iPodTouch3;
    if ([platform isEqualToString:@"iPod4,1"]) return NHDevicePlatform_iPodTouch4;
    if ([platform isEqualToString:@"iPod5,1"]) return NHDevicePlatform_iPodTouch5;
    
    // iPad======
    if ([platform isEqualToString:@"iPad1,1"]) return NHDevicePlatform_iPad;
    if ([platform isEqualToString:@"iPad2,1"]) return NHDevicePlatform_iPad2;
    if ([platform isEqualToString:@"iPad2,2"]) return NHDevicePlatform_iPad2;
    if ([platform isEqualToString:@"iPad2,3"]) return NHDevicePlatform_iPad2;
    if ([platform isEqualToString:@"iPad2,4"]) return NHDevicePlatform_iPad2;
    if ([platform isEqualToString:@"iPad2,5"]) return NHDevicePlatform_iPadMini;
    if ([platform isEqualToString:@"iPad2,6"]) return NHDevicePlatform_iPadMini;
    if ([platform isEqualToString:@"iPad2,7"]) return NHDevicePlatform_iPadMini;
    if ([platform isEqualToString:@"iPad3,1"]) return NHDevicePlatform_iPad3;
    if ([platform isEqualToString:@"iPad3,2"]) return NHDevicePlatform_iPad3;
    if ([platform isEqualToString:@"iPad3,3"]) return NHDevicePlatform_iPad3;
    if ([platform isEqualToString:@"iPad3,4"]) return NHDevicePlatform_iPad4;
    if ([platform isEqualToString:@"iPad3,5"]) return NHDevicePlatform_iPad4;
    if ([platform isEqualToString:@"iPad3,6"]) return NHDevicePlatform_iPad4;
    if ([platform isEqualToString:@"iPad4,1"]) return NHDevicePlatform_iPadAir;
    if ([platform isEqualToString:@"iPad4,2"]) return NHDevicePlatform_iPadAir;
    if ([platform isEqualToString:@"iPad4,3"]) return NHDevicePlatform_iPadAir;
    if ([platform isEqualToString:@"iPad4,4"]) return NHDevicePlatform_iPadMini2;
    if ([platform isEqualToString:@"iPad4,5"]) return NHDevicePlatform_iPadMini2;
    if ([platform isEqualToString:@"iPad4,6"]) return NHDevicePlatform_iPadMini2;
    if ([platform isEqualToString:@"iPad4,7"]) return NHDevicePlatform_iPadMini3;
    if ([platform isEqualToString:@"iPad4,8"]) return NHDevicePlatform_iPadMini3;
    if ([platform isEqualToString:@"iPad4,9"]) return NHDevicePlatform_iPadMini3;
    if ([platform isEqualToString:@"iPad5,1"]) return NHDevicePlatform_iPadMini4;
    if ([platform isEqualToString:@"iPad5,2"]) return NHDevicePlatform_iPadMini4;
    if ([platform isEqualToString:@"iPad5,3"]) return NHDevicePlatform_iPadAir2;
    if ([platform isEqualToString:@"iPad5,4"]) return NHDevicePlatform_iPadAir2;
    if ([platform isEqualToString:@"iPad6,7"]) return NHDevicePlatform_iPadPro12_9;
    if ([platform isEqualToString:@"iPad6,8"]) return NHDevicePlatform_iPadPro12_9;
    if ([platform isEqualToString:@"iPad6,3"]) return NHDevicePlatform_iPadPro9_7;
    if ([platform isEqualToString:@"iPad6,4"]) return NHDevicePlatform_iPadPro9_7;
    if ([platform isEqualToString:@"iPad6,11"]) return NHDevicePlatform_iPad5;
    if ([platform isEqualToString:@"iPad6,12"]) return NHDevicePlatform_iPad5;
    if ([platform isEqualToString:@"iPad7,1"]) return NHDevicePlatform_iPadPro12_9_2nd;
    if ([platform isEqualToString:@"iPad7,2"]) return NHDevicePlatform_iPadPro12_9_2nd;
    if ([platform isEqualToString:@"iPad7,3"]) return NHDevicePlatform_iPadPro10_5;
    if ([platform isEqualToString:@"iPad7,4"]) return NHDevicePlatform_iPadPro10_5;
    if ([platform isEqualToString:@"iPad7,5"]) return NHDevicePlatform_iPad6;
    if ([platform isEqualToString:@"iPad7,6"]) return NHDevicePlatform_iPad6;

    // 模拟器======
    if ([platform isEqualToString:@"iPhone Simulator"] || [platform isEqualToString:@"x86_64"]) return NHDevicePlatform_simulator;
    
    return NHDevicePlatform_unknown;
}

@end
