//
//  NSString+KJVerify.m
//  KJEmitterView
//
//  Created by yangkejun on 2021/8/10.
//  https://github.com/YangKJ/KJCategories

#import "NSString+KJVerify.h"

@implementation NSString (KJVerify)

/// 是否为纯字母
- (BOOL)isPureLetter{
    if (self.length == 0) return NO;
    NSString * const regex = @"[a-zA-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/// 是否为大写字母
- (BOOL)isCapitalLetter{
    if (self.length == 0) return NO;
    NSString * const regex = @"[A-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/// 是否为小写字母
- (BOOL)isLowercaseLetter{
    if (self.length == 0) return NO;
    NSString * const regex = @"[a-z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/// 是否为纯汉字
- (BOOL)isChineseCharacter{
    if (self.length == 0) return NO;
    //中文编码范围是0x4e00~0x9fa5
    NSString * const regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/// 是否包含字母
- (BOOL)isContainLetter{
    if (self.length == 0) return NO;
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]"
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:self
                                                     options:NSMatchingReportProgress
                                                       range:NSMakeRange(0, self.length)];
    //count是str中包含[A-Za-z]数字的个数，只要count>0，说明str中包含数字
    return count > 0 ? YES : NO;
}

/// 是否仅包含字母和数字
- (BOOL)isLetterAndNumber{
    if (self.length == 0) return NO;
    NSString * const regex = @"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/// 是否以字母开头
- (BOOL)isLettersBegin{
    if (self.length == 0) return NO;
    NSString * first = [self substringToIndex:1];
    NSString * const regex = @"[a-zA-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:first];
}

/// 是否以汉字开头
- (BOOL)isChineseBegin{
    if (self.length == 0) return NO;
    NSString * first = [self substringToIndex:1];
    NSString * const regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:first];
}

#pragma mark - 谓词相关
//MARK: - 过滤空格
- (NSString *)kj_filterSpace{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}
/// 过滤特殊字符
- (NSString *)kj_removeSpecialCharacter:(NSString*_Nullable)character{
    if (character == nil) {
        character = @"‘；：”“'。，、,.？、 ~￥#……&<>《》()[]{}【】^!@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€";
    }
    NSRange urgentRange = [self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:character]];
    if (urgentRange.location != NSNotFound){
        return [self kj_removeSpecialCharacter:[self stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return self;
}

//MARK: - 检测字符串中是否有特殊字符
- (BOOL)kj_validateHaveSpecialCharacter{
    NSString *regex = @".*[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？].*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

//MARK: - 验证手机号码是否有效
- (BOOL)kj_validateMobileNumber{
    if (self.length != 11) return NO;
    NSString *mo = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    NSString *cm = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    NSString *cu = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    NSString *ct = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    NSPredicate *regexmo = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mo];
    NSPredicate *regexcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cm];
    NSPredicate *regexcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cu];
    NSPredicate *regexct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ct];
    if ([regexmo evaluateWithObject:self] ||
        [regexcm evaluateWithObject:self] ||
        [regexct evaluateWithObject:self] ||
        [regexcu evaluateWithObject:self]) {
        return YES;
    } else {
        return NO;
    }
}
//MARK: - 验证邮箱格式是否正确
- (BOOL)kj_validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [predicate evaluateWithObject:self];
}
//MARK: - 判断身份证是否是真实的
- (BOOL)kj_validateIDCardNumber{
    /*
     身份证基础知识：
     身份证是国民的身份编号，编号是有一定规律的，这里介绍身份证验证规则比较详细。项目中经常会需要对身份证进行校验，我们先了解一些基本知识，然后分析代码
     居民身份证号码，根据〖中华人民共和国国家标准 GB 11643-1999〗中有关公民身份号码的规定，公民身份号码是特征组合码，由十七位数字本体码和一位数字校验码组成。
     排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。 居民身份证是国家法定的证明公民个人身份的有效证件。
     结构和形式
     1．号码的结构
     　  公民身份号码是特征组合码，由十七位数字本体码和一位校验码组成。排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
     2．地址码
     　  表示编码对象常住户口所在县（市、旗、区）的行政区划代码，按GB/T2260的规定执行。
     3．出生日期码
     　  表示编码对象出生的年、月、日，按GB/T7408的规定执行，年、月、日代码之间不用分隔符。
     4．顺序码
     　  表示在同一地址码所标识的区域范围内，对同年、同月、同日出生的人编定的顺序号，顺序码的奇数分配给男性，偶数分配给女性。
     5．校验码
     　  根据前面十七位数字码，按照ISO7064:1983.MOD11-2校验码计算出来的检验码。
     地址码
     华北地区： 北京市|110000，天津市|120000，河北省|130000，山西省|140000，内蒙古自治区|150000，
     东北地区： 辽宁省|210000，吉林省|220000，黑龙江省|230000，
     华东地区： 上海市|310000，江苏省|320000，浙江省|330000，安徽省|340000，福建省|350000，江西省|360000，山东省|370000，
     华中地区： 河南省|410000，湖北省|420000，湖南省|430000，
     华南地区： 广东省|440000，广西壮族自治区|450000，海南省|460000，
     西南地区： 重庆市|500000，四川省|510000，贵州省|520000，云南省|530000，西藏自治区|540000，
     西北地区： 陕西省|610000，甘肃省|620000，青海省|630000，宁夏回族自治区|640000，新疆维吾尔自治区|650000，
     特别地区：台湾地区(886)|710000，香港特别行政区（852)|810000，澳门特别行政区（853)|820000
     中国大陆居民身份证号码中的地址码的数字编码规则为：
     第一、二位表示省（自治区、直辖市、特别行政区）。
     第三、四位表示市（地级市、自治州、盟及国家直辖市所属市辖区和县的汇总码）。其中，01-20，51-70表示省直辖市；21-50表示地区（自治州、盟）。
     第五、六位表示县（市辖区、县级市、旗）。01-18表示市辖区或地区（自治州、盟）辖县级市；21-80表示县（旗）；81-99表示省直辖县级市。
     生日期码
     （身份证号码第七位到第十四位）表示编码对象出生的年、月、日，其中年份用四位数字表示，年、月、日之间不用分隔符。例如：1981年05月11日就用19810511表示。
     顺序码
     （身份证号码第十五位到十七位）地址码所标识的区域范围内，对同年、月、日出生的人员编定的顺序号。其中第十七位奇数分给男性，偶数分给女性
     校验码
     作为尾号的校验码，是由号码编制单位按统一的公式计算出来的，如果某人的尾号是0-9，都不会出现X，
     但如果尾号是10，那么就得用X来代替，因为如果用10做尾号，那么此人的身份证就变成了19位，而19位的号码违反了国家标准，并且中国的计算机应用系统也不承认19位的身份证号码。
     Ⅹ是罗马数字的10，用X来代替10，可以保证公民的身份证符合国家标准。
     身份证校验码的计算方法
     1、将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。
     2、将这17位数字和系数相乘的结果相加。
     3、用加出来和除以11，看余数是多少？
     4、余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字。其分别对应的最后一位身份证的号码为1－0－X－9－8－7－6－5－4－3－2。(即余数0对应1，余数1对应0，余数2对应X...)
     5、通过上面得知如果余数是3，就会在身份证的第18位数字上出现的是9。如果对应的数字是2，身份证的最后一位号码就是罗马数字x。
     例如：某男性的身份证号码为【53010219200508011x】，我们看看这个身份证是不是合法的身份证。
     首先我们得出前17位的乘积和【(5*7)+(3*9)+(0*10)+(1*5)+(0*8)+(2*4)+(1*2)+(9*1)+(2*6)+(0*3)+(0*7)+(5*9)+(0*10)+(8*5)+(0*8)+(1*4)+(1*2)】是189，
     然后用189除以11得出的结果是189/11=17----2，也就是说其余数是2。最后通过对应规则就可以知道余数2对应的检验码是X。
     所以，可以判定这是一个正确的身份证号码。
     */
    NSString *value = self;
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (value == nil) {
        return NO;
    } else {
        length = value.length;
        if (length != 15 && length != 18) return NO;
    }
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32",
                            @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45",
                            @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64",
                            @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray){
        if ([areaCode isEqualToString:valueStart2]){
            areaFlag = YES;
            break;
        }
    }
    if (areaFlag == NO) return NO;
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    NSInteger year = 0;
    switch (length){
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue + 1900;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc]
                                     initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                     options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                regularExpression = [[NSRegularExpression alloc]
                                     initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                     options:NSRegularExpressionCaseInsensitive error:nil];
            }
            return [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)] > 0 ? YES : NO;
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc]
                                     initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                     options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                regularExpression = [[NSRegularExpression alloc]
                                     initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                     options:NSRegularExpressionCaseInsensitive error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if (numberofMatch > 0) {
                int S =
                ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue)*7 +
                ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue)*9 +
                ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue)*10 +
                ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue)*5 +
                ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue)*8 +
                ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue)*4 +
                ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue)*2 +
                [value substringWithRange:NSMakeRange(7,1)].intValue * 1 +
                [value substringWithRange:NSMakeRange(8,1)].intValue * 6 +
                [value substringWithRange:NSMakeRange(9,1)].intValue * 3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];
                return [M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]];
            } else {
                return NO;
            }
        default:
            return NO;
    }
}
/// 验证银行卡
- (BOOL)kj_validateBankCardNumber{
    NSString * const BANKCARD = @"^(\\d{16}|\\d{19})$";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    return [predicate evaluateWithObject:self];
}

/// 验证IP地址
- (BOOL)kj_validateIPAddress{
    if (self.length == 0) return NO;
    NSString * const regex = [NSString stringWithFormat:@"^(\\\\d{1,3})\\\\.(\\\\d{1,3})\\\\.(\\\\d{1,3})\\\\.(\\\\d{1,3})$"];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:self]) {
        NSArray * componds = [self componentsSeparatedByString:@","];
        BOOL boo = YES;
        for (NSString * s in componds) {
            if (s.integerValue > 255) {
                boo = NO; break;
            }
        }
        return boo;
    }
    return NO;
}

@end
