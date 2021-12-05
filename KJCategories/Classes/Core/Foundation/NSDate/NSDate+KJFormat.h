//
//  NSDate+KJFormat.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/16.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (KJFormat)

/// 将日期转化为本地时间
- (NSDate *)kj_localeDate;

/// 时间字符串转位NSDate，格式@"yyyy-MM-dd HH:mm:ss"
+ (NSDate *)kj_dateFromString:(NSString *)string;

/// 时间字符串转NSDate
/// @param string 时间字符串
/// @param format 时间格式
+ (NSDate *)kj_dateFromString:(NSString *)string format:(NSString *)format;

/// 获取当前时间戳，是否为毫秒
+ (NSTimeInterval)kj_currentTimetampWithMsec:(BOOL)msec;

/// 时间戳转时间，内部判断是毫秒还是秒
/// @param timestamp 时间戳
/// @param format 时间格式
+ (NSString *)kj_timeWithTimestamp:(NSTimeInterval)timestamp format:(NSString *)format;

/// 获取指定时间UTC时间戳
/// @param timeString 指定时间
+ (NSTimeInterval)kj_timeStampUTCWithTimeString:(NSString *)timeString;

@end

NS_ASSUME_NONNULL_END
