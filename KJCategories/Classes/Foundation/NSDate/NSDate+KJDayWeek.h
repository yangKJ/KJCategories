//
//  NSDate+KJDayWeek.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/16.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (KJDayWeek)
/// 是否为昨天
@property (nonatomic, assign, readonly) BOOL isYesterday;
/// 是否同一周
- (BOOL)kj_weekSameDate:(NSDate *)date;
/// 是否同一天
- (BOOL)kj_daySameDate:(NSDate *)date;
/// 蔡勒公式获取周几
- (NSInteger)kj_weekDay;
/// 当前周末日期
- (NSDate *)kj_weekendDate;
/// 本月多少天
- (NSUInteger)kj_monthHowDays;
/// 月初
- (NSDate *)kj_monthFristDay;
/// 月末
- (NSDate *)kj_monthLastDay;
/// 偏移几天的日期
/// @param day 前后天数
/// @param format 时间格式
- (NSString *)kj_skewingDay:(NSInteger)day format:(NSString *)format;
/// 偏移几月的日期
/// @param month 前后月数
/// @param format 时间格式
- (NSString *)kj_skewingMonth:(NSInteger)month format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
