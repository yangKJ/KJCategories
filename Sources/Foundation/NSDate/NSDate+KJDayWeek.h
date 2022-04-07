//
//  NSDate+KJDayWeek.h
//  KJEmitterView
//
//  Created by 77。 on 2019/12/16.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (KJDayWeek)

/// Is it yesterday
@property (nonatomic, assign, readonly) BOOL isYesterday;

/// Is it the same week
- (BOOL)kj_weekSameDate:(NSDate *)date;

/// Is it the same day
- (BOOL)kj_daySameDate:(NSDate *)date;

/// Zeiler formula to get the day of the week
- (NSInteger)kj_weekDay;

/// Current weekend date
- (NSDate *)kj_weekendDate;

/// How many days in this month
- (NSUInteger)kj_monthHowDays;

/// Beginning of the month
- (NSDate *)kj_monthFristDay;

/// End of month
- (NSDate *)kj_monthLastDay;

/// Date offset by a few days
/// @param day days before and after
/// @param format time format
- (NSString *)kj_skewingDay:(NSInteger)day format:(NSString *)format;

/// Date offset by a few months
/// @param month The number of months before and after
/// @param format time format
- (NSString *)kj_skewingMonth:(NSInteger)month format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
