//
//  NSString+NHExtend.h
//  NHExtension
//
//  Created by neghao on 2018/7/21.
//

#import <Foundation/Foundation.h>


@interface NSString (NHExtend)
NS_ASSUME_NONNULL_BEGIN

/**
 Trim blank characters (space and newline) in head and tail.
 
 @return the trimmed string.
 */
- (NSString *)stringByTrim;

/**
 Returns a NSString for md5 hash.
 */
- (NSString *)md5String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (nullable NSString *)sha1String;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key The hmac key.
 */
- (nullable NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns a new UUID NSString. e.g. "C3278C30-2B3D-4E1E-7AC2-B6FFB24A07C1"
 */
+ (NSString *)UUIDString;

/**
 URL encode a string in utf-8.
 
 @return the encode string.
 */
- (NSString *)urlEncode;

/**
 URL decode a string in utf-8.
 
 @return the decoded string.
 */
- (NSString *)urlDecode;

/**
 Returns a new string made by appending a given query keyValue string to the receiver.
 */
- (NSString *)urlAppendingKeyValue:(NSString *)keyValue;

/**
 Converts json string to json object. return nil if an error occurs.
 NSArray/NSDictionary
 */
- (nullable id)jsonObject;

/**
 Whether it can match the regular expression.
 
 @param regex  The regular expression
 @param options The matching options to report.
 @return YES if can match the regex; otherwise, NO.
 */
- (BOOL)matchesRegx:(NSString *)regex options:(NSRegularExpressionOptions)options;

/**
 Match the regular expression, and executes a given block using each object in the matches.
 
 @param regex    The regular expression
 @param options  The matching options to report.
 @param block    The block to apply to elements in the array of matches.
 */

- (void)enumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block;

/**
 Returns a new string containing matching regular expressions replaced with the template string.
 
 @param regex       The regular expression
 @param options     The matching options to report.
 @param replacement The substitution template used when replacing matching instances.
 
 @return A string with matching regular expressions replaced by the template string.
 */
- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement;

/**
 Returns NSMakeRange(0, self.length).
 */
- (NSRange)rangeTotal;

/** 是否为空或者为纯(null)、null string */
+ (BOOL)isEmptyOrNull:(NSString *)string;

/** 是否为空或者为纯(null)、null string */
- (BOOL)isEmptyOrNull:(NSString *)string;

/** 判断是否含有表情 */
- (BOOL)stringContainsEmoji:(NSString *)string;

/** 精确的身份证号有效性检测 */
- (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

@end

NS_ASSUME_NONNULL_END

