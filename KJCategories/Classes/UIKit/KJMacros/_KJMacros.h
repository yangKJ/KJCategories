//
//  _KJMacros.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/5.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJEmitterView

#ifndef _KJMacros_h
#define _KJMacros_h

#pragma mark - ////////////////////////////// 宏相关 //////////////////////////////

#pragma mark ********** 1.缩写 ************
#define kApplication        [UIApplication sharedApplication]
#define kAppDelegate        [UIApplication sharedApplication].delegate // AppDelegate
#define kNotificationCenter [NSNotificationCenter defaultCenter] // 通知中心
#define kPostNotification(name,obj,info) [kNotificationCenter postNotificationName:name object:obj userInfo:info] // 发送通知
#define kMethodDeprecated(instead) DEPRECATED_MSG_ATTRIBUTE("Please use " # instead " instead") // 方法失效

#pragma mark ********** 2.自定义高效率的 NSLog ************
#ifdef DEBUG // 输出日志 (格式: [编译时间] [文件名] [方法名] [行号] [输出内容])
#define NSLog(FORMAT, ...) fprintf(stderr,"------- 🎈 给我点赞 🎈 -------\n编译时间:%s\n文件名:%s\n方法名:%s\n行号:%d\n打印信息:%s\n\n", \
__TIME__, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
__func__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif

#define kNSSTRING_NOT_NIL(value)  value ? value : @""
#define kNSARRAY_NOT_NIL(value)   value ? value : @[]
#define kNSDICTIONARY_NOT_NIL(value)  value ? value : @{}
#define kNSSTRING_VALUE_OPTIONAL(value)  [value isKindOfClass:[NSString class] ] ? value : nil

// 字符串拼接
#define kStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
// block相关宏
#define kBlockSafeRun(block,...) block ? block(__VA_ARGS__) : nil
// 版本判定 大于等于某个版本
#define kCurrentSystemVersion(version) ([[[UIDevice currentDevice] systemVersion] compare:@#version options:NSNumericSearch]!=NSOrderedAscending)
// 获取时间间隔宏
#define kTimeTick CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kTimeTock NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start);

#pragma mark ********** 3.弱引用 *********

// 设置图片
#define kGetImage(imageName) ([UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]])
// 通过图片获取图片颜色
#define kImageToColor(image) [UIColor colorWithPatternImage:image]

#pragma mark ********** 7.系统默认字体设置和自选字体设置    *********
#define kSystemFontSize(fontsize)       [UIFont systemFontOfSize:(fontsize)]
#define kFont(A)                        [UIFont systemFontOfSize:A]
#define kFont_Blod(A)                   [UIFont boldSystemFontOfSize:A]
#define kFont_Medium(A)                 [UIFont systemFontOfSize:A weight:UIFontWeightMedium]
#define kFont_Italic(A)                 [UIFont italicSystemFontOfSize:A]

#endif /* _KJMacros_h */
