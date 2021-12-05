//
//  NSDate+KJDayWeek.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/16.
//  https://github.com/YangKJ/KJCategories

#import "NSDate+KJDayWeek.h"

@implementation NSDate (KJDayWeek)
// 是否是昨天
@dynamic isYesterday;
- (BOOL)isYesterday{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate  = [format dateFromString:[format stringFromDate:[NSDate date]]];
    NSDate *selfDate = [format dateFromString:[format stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:kNilOptions];
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
}
/* 判断两个日期是否在同一周 */
- (BOOL)kj_weekSameDate:(NSDate *)date{
    if (fabs([self timeIntervalSinceDate:date]) >= 7 * 24 * 3600){
        return NO;
    }
    NSCalendar *calender = [NSCalendar currentCalendar];
    calender.firstWeekday = 2;
    NSUInteger countSelf = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:self];
    NSUInteger countDate = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:date];
    return countSelf == countDate;
}
/// 是否同一天
- (BOOL)kj_daySameDate:(NSDate *)date{
    if (fabs([self timeIntervalSinceDate:date]) >= 24 * 3600){
        return NO;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd";
    NSString *nowDateStr = [format stringFromDate:[NSDate date]];
    NSString *selfDateStr = [format stringFromDate:self];
    return [nowDateStr isEqualToString:selfDateStr];
}
/// 蔡勒公式获取周几，返回1 - 7
- (NSInteger)kj_weekDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSInteger year = components.year;
    NSInteger month = components.month;
    NSInteger day = components.day;
    //蔡勒公式
    int benchmark[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
    year -= month < 3;
    NSInteger x = (year + year/4 - year/100 + year/400 + benchmark[month-1] + day) % 7;
    if (x == 0) return 7;
    return x;
}
/// 本月多少天
- (NSUInteger)kj_monthHowDays{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}
/// 返回当前日期的所在月份的第一天日期
- (NSDate *)kj_monthFristDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [components setDay:1];
    return [calendar dateFromComponents:components];
}
/// 获取当月最后一天
- (NSDate *)kj_monthLastDay{
    NSDate *date = [self kj_monthFristDay];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    NSDate *mdate = [calendar dateByAddingComponents:components toDate:date options:0];
    NSDateComponents *components2 = [[NSDateComponents alloc] init];
    [components2 setDay:-1];
    return [calendar dateByAddingComponents:components2 toDate:mdate options:0];
}
/// 返回当前周的周末日期
- (NSDate *)kj_weekendDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComp = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:(7 - [weekdayComp weekday])];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
/// 获取今日前后几天的日期
- (NSString *)kj_skewingDay:(NSInteger)day format:(NSString *)format{
    NSDate *date = self;
    if (day != 0) {
        NSTimeInterval oneDay = 24 * 60 * 60;
        date = [date initWithTimeIntervalSinceNow:oneDay * day];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}
/// 获取今天偏移几月的日期
- (NSString *)kj_skewingMonth:(NSInteger)month format:(NSString *)format{
    NSDate *date = self;
    if (month != 0) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setMonth:month];
        date = [calendar dateByAddingComponents:components toDate:self options:0];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

@end
