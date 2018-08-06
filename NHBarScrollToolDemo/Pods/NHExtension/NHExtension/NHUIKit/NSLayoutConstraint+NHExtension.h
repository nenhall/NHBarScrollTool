//
//  NSLayoutConstraint+NHExtension.h
//  DZNEmptyDataSet
//
//  Created by neghao on 2018/7/15.
//

#import <UIKit/UIKit.h>


#if TARGET_INTERFACE_BUILDER
IB_DESIGNABLE
@interface NSLayoutConstraint (NHExtension)
@property (nonatomic, assign)IBInspectable BOOL fitSafeAereLayout;
@property (nonatomic, assign)IBInspectable CGFloat scaleBased47inchW;
@property (nonatomic, assign)IBInspectable CGFloat scaleBased47inchH;

@end
#endif
