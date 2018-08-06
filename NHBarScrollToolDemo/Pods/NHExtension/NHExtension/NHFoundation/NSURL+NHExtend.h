//
//  NSURL+NHExtend.h
//  DZNEmptyDataSet
//
//  Created by neghao on 2018/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (NHExtend)
/** Returns absoluteString but not contain the part of query. */
@property(nonatomic, readonly) NSString *allPath;

/** Boolean value that indicates whether the resource from remote. */
@property(nonatomic, readonly) BOOL isRemote;

/**
 Return a Dictionary which contains query params
 */
- (nullable NSDictionary *)queryDic;

@end
NS_ASSUME_NONNULL_END
