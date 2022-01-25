//
//  KJFoundationHeader.h
//  KJCategories
//
//  Created by 77。 on 2021/11/7.
//  https://github.com/YangKJ/KJCategories

//  Example import NSArray:
//  pod 'KJCategories/Foundation/NSArray'

#ifndef KJFoundationHeader_h
#define KJFoundationHeader_h

#if __has_include(<KJCategories/NSArray+KJPredicate.h>)
#import <KJCategories/NSArray+KJPredicate.h>
#import <KJCategories/NSArray+KJMathSort.h>
#elif __has_include("NSArray+KJPredicate.h")
#import "NSArray+KJPredicate.h"
#import "NSArray+KJMathSort.h"
#else
#endif

#if __has_include(<KJCategories/NSData+KJExtension.h>)
#import <KJCategories/NSData+KJExtension.h>
#elif __has_include("NSData+KJExtension.h")
#import "NSData+KJExtension.h"
#else
#endif

#if __has_include(<KJCategories/NSDate+KJDayWeek.h>)
#import <KJCategories/NSDate+KJDayWeek.h>
#elif __has_include("NSDate+KJDayWeek.h")
#import "NSDate+KJDayWeek.h"
#else
#endif

#if __has_include(<KJCategories/NSDictionary+KJReadWrite.h>)
#import <KJCategories/NSDictionary+KJReadWrite.h>
#elif __has_include("NSDictionary+KJReadWrite.h")
#import "NSDictionary+KJReadWrite.h"
#else
#endif

#if __has_include(<KJCategories/NSObject+KJDoraemonBox.h>)
#import <KJCategories/NSObject+KJDoraemonBox.h>
#import <KJCategories/NSObject+KJDealloc.h>
#import <KJCategories/NSObject+KJkvo.h>
#elif __has_include("NSObject+KJDoraemonBox.h")
#import "NSObject+KJDoraemonBox.h"
#import "NSObject+KJDealloc.h"
#import "NSObject+KJkvo.h"
#else
#endif

#if __has_include(<KJCategories/NSString+KJExtension.h>)
#import <KJCategories/NSString+KJExtension.h>
#import <KJCategories/NSString+KJBlockChain.h>
#import <KJCategories/NSString+KJEmoji.h>
#import <KJCategories/NSString+KJPasswordLevel.h>
#import <KJCategories/NSString+KJRegex.h>
#import <KJCategories/NSString+KJSecurity.h>
#import <KJCategories/NSString+KJSize.h>
#import <KJCategories/NSString+KJVerify.h>
#elif __has_include("NSString+KJExtension.h")
#import "NSString+KJExtension.h"
#import "NSString+KJBlockChain.h"
#import "NSString+KJEmoji.h"
#import "NSString+KJPasswordLevel.h"
#import "NSString+KJRegex.h"
#import "NSString+KJSecurity.h"
#import "NSString+KJSize.h"
#import "NSString+KJVerify.h"
#else
#endif

#if __has_include(<KJCategories/NSTimer+KJExtension.h>)
#import <KJCategories/NSTimer+KJExtension.h>
#elif __has_include("NSTimer+KJExtension.h")
#import "NSTimer+KJExtension.h"
#else
#endif

#endif /* KJFoundationHeader_h */
