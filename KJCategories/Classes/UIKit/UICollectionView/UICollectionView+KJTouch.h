//
//  UICollectionView+KJTouch.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/9/18.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  获取touch事件处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJMoveStateType) {
    KJMoveStateTypeBegin = 0,
    KJMoveStateTypeMove,
    KJMoveStateTypeEnd,
    KJMoveStateTypeCancelled,
};
@interface UICollectionView (KJTouch)
/// 开启方法交换
@property(nonatomic,assign) BOOL openExchange;
/// Touch里面移动回调，需要开启方法交换才处理
@property(nonatomic,readwrite,copy) void(^moveblock)(KJMoveStateType state,CGPoint point);

@end

NS_ASSUME_NONNULL_END
