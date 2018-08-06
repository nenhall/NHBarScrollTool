//
//  NSObject+NHExtend.h
//  NHExtension
//
//  Created by neghao on 2018/7/21.
//

#import <Foundation/Foundation.h>

@interface NSObject (NHExtend)
/**
 Returns a BOOL value tells if the object is no empty.
 NSArray/NString/NSDictionary/NSData
 
 */
- (BOOL)isNoEmpty;


/**
 Swap two instance method's implementation in one class.
 
 @param originalSel   Selector 1.
 @param newSel        Selector 2.
 @return              YES if swizzling succeed, otherwise, NO.
 */
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;


/**
 Swap two class method's implementation in one class.
 
 @param originalSel   Selector 1.
 @param newSel        Selector 2.
 @return              YES if swizzling succeed, otherwise, NO.
 */
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;


@end
