//
//  NSData+NHExtend.h
//  NHExtension
//
//  Created by neghao on 2018/7/21.
//

#import <Foundation/Foundation.h>

@interface NSData (NHExtend)

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)md5Data;

/**
 Returns a NSString for md5 hash.
 */
- (NSString *)md5String;

/**
 Returns an NSData for sha1 hash.
 */
- (NSData *)sha1Data;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)sha1String;

/**
 Returns an NSData for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

@end
