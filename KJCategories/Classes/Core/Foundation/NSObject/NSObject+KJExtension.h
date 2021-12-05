//
//  NSObject+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/15.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJExtension)

/// 代码执行时间处理，block当中执行代码
FOUNDATION_EXPORT CFTimeInterval kDoraemonBoxExecuteTimeBlock(void(^block)(void));
/// 延迟点击，避免快速点击
FOUNDATION_EXPORT void kDoraemonBoxAvoidQuickClick(float time);

/// 保存至相册
/// @param image 保存图片
/// @param complete 保存成功与否回调
- (void)kj_saveImageToPhotosAlbum:(UIImage *)image complete:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
