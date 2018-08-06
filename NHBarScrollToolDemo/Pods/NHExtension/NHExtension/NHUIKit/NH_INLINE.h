//
//  NH_INLINE.h
//  Pods
//
//  Created by nenhall_work on 2018/7/12.
//

#ifndef NH_INLINE_h
#define NH_INLINE_h
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>

/** 这里只适合放简单的函数 */
/** 这里只适合放简单的函数 */
/** 这里只适合放简单的函数 */

/** 主线程do */
NS_INLINE void nh_safe_dispatch_main_q(dispatch_block_t block) {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), block);
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/** 自定提醒窗口，自动消失 */
NS_INLINE void NHTipWithMessageAutoDismiss(NSString *message){
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alerView show];
        [alerView performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:@[@0, @1] afterDelay:1.5];
    });
}

/** 自定提醒窗口 */
NS_INLINE UIAlertView* NHTipWithTitleMessages(NSString *title, NSString *message, id delegate, NSString *cancelTitle, NSString *otherTitle){
    __block UIAlertView *alerView;
    dispatch_async(dispatch_get_main_queue(), ^{
        alerView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
        [alerView show];
        //[alerView performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:@[@0, @1] afterDelay:0.9];
    });
    return alerView;
}

/** 设置圆角 */
NS_INLINE void kNHViewBorderRadius(UIView *view, CGFloat radius, CGFloat width, UIColor *color)
{
    [view.layer setCornerRadius:(radius)];
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:(width)];
    if (color) {
        [view.layer setBorderColor:[color CGColor]];
    }
}

/** 校正ScrollView在iOS11上的偏移问题 */
NS_INLINE void NHAdjustsScrollViewInsetNever(UIViewController *viewController,__kindof UIScrollView *tableView) {
#if __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        viewController.automaticallyAdjustsScrollViewInsets = false;
    }
#else
    viewController.automaticallyAdjustsScrollViewInsets = false;
#endif
}

/** 判定一个对象是否为 NSNull */
NS_INLINE BOOL kObjIsNSNullClass(id _Nonnull obj) {
    return [obj isKindOfClass:[NSNull class]];
}

/** NSInteger to NSString */
NS_INLINE NSString* kGetIntegerWithString(NSInteger value){
    return [NSString stringWithFormat:@"%ld",value];
}

/** int to NSString */
NS_INLINE NSString* kGetIntValueWithString(int value){
    return [NSString stringWithFormat:@"%d",value];
}

/** obj to NSString */
NS_INLINE NSString* kGetStringWithObj(id obj){
    return [NSString stringWithFormat:@"%@",obj];
}

/** NSString to NSUTF8StringEncoding */
NS_INLINE NSString* kStrignToUTF8String(NSString *string){
   return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

/*****************************沙盒目录文件******************************/
/** 获取temp */
NS_INLINE NSString* kTemporaryDirectory() {
    return NSTemporaryDirectory();
}

/** 获取沙盒 Document */
NS_INLINE NSString* kDocumentDirectory() {
   return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

/** 获取沙盒 Library */
NS_INLINE NSString* kLibraryDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

/** 获取沙盒 Cache */
NS_INLINE NSString* kCachesDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

/** 合成路径 */
NS_INLINE NSString* kAppendingPathComponent(NSString* path, NSString*subPath){
    return [NSString stringWithFormat:@"%@/%@",(path),(subPath)];
}

/** 系统加载动效 */
NS_INLINE void kNetworkActivityIndicatorVisible(BOOL visible) {  [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
}

/** 获取通知中心 */
NS_INLINE NSNotificationCenter* kNotificationCenter() {
    return [NSNotificationCenter defaultCenter];
}

/** mainBundle Dictionary */
NS_INLINE NSDictionary* kBundleDictionary() {
    return [[NSBundle mainBundle] infoDictionary];
}

/** 通过xib名称加载cell */
NS_INLINE id kLoadNibWithNamed(NSString *name, id owner){
   return [[NSBundle mainBundle] loadNibNamed:name owner:owner options:nil].firstObject;
}

/** 获取main stroyboard */
NS_INLINE UIStoryboard* kLoadMainStroyboard() {
   return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

/** 从main storyboard 里面加载viewController */
NS_INLINE UIViewController* kLoadMainStroyboardWithNibName(NSString* name) {
   return [kLoadMainStroyboard() instantiateViewControllerWithIdentifier:name];
}

/** app版本 */
NS_INLINE NSString* kAppVersion() {
   return [kBundleDictionary() objectForKey:@"CFBundleShortVersionString"];
}

/** app build版本 */
NS_INLINE NSString* kAppBuildVersion() {
    return [kBundleDictionary() objectForKey:@"CFBundleVersion"];
}

/** 交换方法的实现 */
NS_INLINE void NH_Method_swizzling(Class class, SEL originalSelector, SEL swizzledSelector) {
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        if (class_addMethod(class, originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod))) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
}


#endif
#endif /* NH_INLINE_h */
