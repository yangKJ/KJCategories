//
//  NSString+KJExtension.h
//  KJEmitterView
//
//  Created by 77。 on 2019/11/4.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJExtension)

/// Convert to URL
@property (nonatomic, strong, readonly) NSURL *URL;
/// Get pictures
@property (nonatomic, strong, readonly) UIImage *image;
/// Picture controller
@property (nonatomic, strong, readonly) UIImageView *imageView;
/// Text control
@property (nonatomic, strong, readonly) UILabel *textLabel;
/// Take out HTML
@property (nonatomic, strong, readonly) NSString *HTMLString;
/// Generate vertical text
@property (nonatomic, strong, readonly) NSString *verticalText;
/// Is it JSONString
@property (nonatomic, assign, readonly) BOOL isJSONString;
/// Josn string to dictionary
@property (nonatomic, strong, readonly) NSDictionary *JSONDictionary;

/// Dictionary to Json string
extern NSString * kDictionaryToJson(NSDictionary * dict);
/// Array to Json string
extern NSString * kArrayToJson(NSArray * array);

@end

NS_ASSUME_NONNULL_END
