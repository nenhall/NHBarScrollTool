//
//  NHMacroDefineHeader.h
//  Pods
//
//  Created by nenhall_work on 2018/7/12.
//

#ifndef NHMacroDefineHeader_h
#define NHMacroDefineHeader_h
#ifdef __OBJC__

/*********************************屏幕尺寸相关********************************/
/******************************Screen Property******************************/
#pragma mark - 屏幕尺寸相关
#define kCurrentModeSize       [[UIScreen mainScreen] currentMode].size
#define kScreenScale           [UIScreen mainScreen].scale
#define kNativeScale           [[UIScreen mainScreen] nativeScale]
#define kScreenBounds          [UIScreen mainScreen].bounds
#define kScreenSize            kScreenBounds.size
#define kScreenWidth           kScreenSize.width
#define kScreenHeight          kScreenSize.height
/** 通过转屏通知得到的屏幕方向，有延迟，不可靠，建议使用此属性 */
#define kInterfaceOrientation  [[UIApplication sharedApplication] statusBarOrientation]
#define kStatusBarHeight       [[UIApplication sharedApplication] statusBarFrame].size.height
#define kDelegateWindow        [UIApplication sharedApplication].delegate.window
#define kTabBarHeight          ((kScreen5_85inch) ? 83.0 : 49.0)
#define kNavBarHeight          44.0
#define kNavgationHeight       (kStatusBarHeight + kNavBarHeight)

/*********************************屏幕类型判定********************************/
#pragma mark - 屏幕类型判定
#define kRespondCurrentMode [UIScreen instancesRespondToSelector:@selector(currentMode)]
/** 3.5inch屏幕 */
#define kScreen3_5inch  (kRespondCurrentMode && CGSizeEqualToSize(CGSizeMake(640, 960), kCurrentModeSize))
/** 4.0inch屏幕 */
#define kScreen4_0inch  (kRespondCurrentMode && CGSizeEqualToSize(CGSizeMake(640, 1136), kCurrentModeSize))
/** 5.5inch屏幕 在放大模式下*/
#define kScreen4_7inch_BM (kRespondCurrentMode && CGSizeEqualToSize(CGSizeMake(1125, 2001), kCurrentModeSize))
/** 4.7inch屏幕 */
#define kScreen4_7inch  (kRespondCurrentMode && CGSizeEqualToSize(CGSizeMake(750, 1334), kCurrentModeSize))
#define kScreen5_5inch  (kRespondCurrentMode && (CGSizeEqualToSize(CGSizeMake(1242, 2208), kCurrentModeSize)||CGSizeEqualToSize(CGSizeMake(1125, 2001), kCurrentModeSize)))
/** 5.85inch屏幕 -> iPhone_X */
#define kScreen5_85inch (kRespondCurrentMode && CGSizeEqualToSize(CGSizeMake(1125, 2436), kCurrentModeSize))
/** 放大显示模式 */
#define kIsDisplayZoomed (((kScreenScale == 2)&&(kNativeScale == 2.343750)) || ((kScreenScale == 3)&&(kNativeScale == 2.880000)))
/** 以4.7inch屏幕计算尺寸比例 */
#define kScaleBased4_7inch_W  ((kCurrentModeSize.width/kScreenScale)/375.0)
#define kScaleBased4_7inch_H  ((kCurrentModeSize.height/kScreenScale)/667.0)

//适配参数
//#define kSuitParam (kIsDisplayZoomed ? (kScreen4_7inch ? 1.0 : (kScreen5_5inch ? 1.01 : 0.85)) : (kScreen5_5inch ? 1.12 : (kScreen4_7inch ? 1.0 : (kScreen5_85inch ? 1.0 : 0.85))))

/*************************iPhoneX设备上的相关间隙补偿**************************/
#pragma mark - iPhoneX设备上的相关间隙补偿
//iPhoneX相关属性
#define kTabBarBottomPad          (kScreen5_85inch ? 34.0 : 0.0)
#define kNavBarTopPad             (kScreen5_85inch ? 44.0 : 0.0)
#define kStatusTopPad             (kScreen5_85inch ? 24.0 : 0.0)
#define kLandscapeBottomPad       (kScreen5_85inch ? 21.0 : 0.0)
/** iphoneX横屏时左或右的边缘间隙 */
#define kIPhoneXLandscape_L_R_Pad (kScreen5_85inch ? 44.0 : 0.0)//72.5?16:9

/*******************************设备类型判定******************************/
#pragma mark - 设备类型判定
//判断是否为iPhone
#define kIPhoneDevice (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define kIPadDevice   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define kIPodDeveice  ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/*******************************版本判定******************************/
#pragma mark - 版本判定
/** 大于等于某个版本 */
#define iOS_X_OR_LATER(version)  ([[[UIDevice currentDevice] systemVersion] compare:@#version options:NSNumericSearch] != NSOrderedAscending)

/*******************************自定义的 NSLog******************************/
#pragma mark - 自定义的 NSLog
#ifdef DEBUG
#define kNSLog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define kNSLog(...)
#endif

/*********************不需要打印时间戳等信息，使用如下宏定义***********************/
#ifdef DEBUG
#define kCNSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define kCNSLog(...)
#endif


/**********************打印日志,当前行 并弹出一个警告**************************/
#ifdef DEBUG
#   define kALERTLog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define kALERTLog(...)
#endif

//#ifndef __OPTIMIZE__
//#define OPEN_MEMORY_WARNING_TEST YES //打开内存警告测试开关
//#endif
//#define SimulateMemoryWarning  [[UIApplication sharedApplication] performSelector:@selector(_performMemoryWarning)];

/***********************由角度转换弧度 由弧度转换角度**************************/
#pragma mark - 由角度转换弧度 由弧度转换角度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
#define kRadianToDegrees(radian) (radian * 180.0)/(M_PI)


/****************************关联方法宏定义********************************/
#pragma mark - 关联方法宏定义
/** 为对象类型属性快速生成get/set方法 */
#define NH_SYNTHESIZE_CATEGORY_OBJ_PROPERTY(propertyGetter, propertySetter)\
- (id)propertyGetter {\
return objc_getAssociatedObject(self, @selector(propertyGetter));\
}\
- (void)propertySetter(id)obj {\
objc_setAssociatedObject(self, @selector(propertyGetter), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

/** 为基本数据类型属性快速生成get/set方法 */
#define NH_SYNTHESIZE_CATEGORY_VALUE_PROPERTY(valueType, propertyGetter, propertySetter)\
-(valueType)propertyGetter{\
valueType ret = {0};\
[objc_getAssociatedObject(self, @selector(propertyGetter)) getValue:&ret];\
return ret;\
}\
-(void)propertySetter(valueType)value{\
NSValue *valueObj = [NSValue valueWithBytes:&value objCType:@encode(valueType)];\
objc_setAssociatedObject(self, @selector(propertyGetter), valueObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

/*****************************其它常用宏定义******************************/
#pragma mark - 其它常用宏定义
/** 弱引用/强引用 */
#define kWeakSelf(type)   __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) strong_##type = type;
#define kGetImageWithName(imageName)     [UIImage imageNamed:@#imageName]


#endif
#endif /* NHMacroDefineHeader_h */
