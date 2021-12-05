//
//  UIDevice+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/3/17.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (KJExtension)

/// App版本号
@property (nonatomic,strong,class) NSString *appCurrentVersion;
/// App名称
@property (nonatomic,strong,class) NSString *appName;
/// 手机UUID
@property (nonatomic,strong,class) NSString *deviceID;
/// 获取App图标
@property (nonatomic,strong,class) UIImage *appIcon;
/// 获取启动页图片
@property (nonatomic,strong,class) UIImage *launchImage;
/// 判断相机是否可用
@property (nonatomic,assign,class) BOOL cameraAvailable;

@end

NS_ASSUME_NONNULL_END
