//
//  KJTestViewController.h
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2020/1/15.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJTestViewController : UIViewController
//获取当前设备可用内存
+ (double)availableMemory;
//获取当前任务所占用内存
+ (double)usedMemory;
@end

NS_ASSUME_NONNULL_END
