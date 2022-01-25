//
//  UICollectionView+KJTouch.h
//  KJEmitterView
//
//  Created by 77。 on 2019/9/18.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJMoveStateType) {
    KJMoveStateTypeBegin = 0,
    KJMoveStateTypeMove,
    KJMoveStateTypeEnd,
    KJMoveStateTypeCancelled,
};
@interface UICollectionView (KJTouch)

/// Open method exchange
@property (nonatomic, assign) BOOL openExchange;

/// Move callback in Touch, need to open method exchange before processing
- (void)moveWithBlock:(void(^)(KJMoveStateType state,CGPoint point))withBlock;

@end

NS_ASSUME_NONNULL_END
