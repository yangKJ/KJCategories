//
//  UITextField+KJCustomView.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/4.
//  https://github.com/YangKJ/KJCategories
//  快速设置账号密码框

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KJTextFieldLeftMaker;
@interface UITextField (KJCustomView)

/// 设置底部边框线条颜色
@property (nonatomic, strong) IBInspectable UIColor *bottomLineColor;

/// 设置左边视图，类似账号密码标题
- (UIView *)kj_leftView:(void(^)(KJTextFieldLeftMaker * make))withBlock;

/// 设置右边视图，类似小圆叉
/// @param withBlock 点击事件响应
/// @param imageName 图标名
/// @param width 宽度
/// @param height 高度
/// @param padding 距离右边间距
- (UIButton *)kj_rightViewTapBlock:(nullable void(^)(UIButton * button))withBlock
                         imageName:(nullable NSString *)imageName
                             width:(CGFloat)width
                            height:(CGFloat)height
                           padding:(CGFloat)padding;

@end

typedef NS_ENUM(NSInteger, KJTextAndImageStyle) {
    KJTextAndImageStyleNormal = 0,// 图左文右
    KJTextAndImageStyleImageRight,// 图右文左
};
/// 左边视图的相关参数设置
@interface KJTextFieldLeftMaker : NSObject
/// 文本
@property(nonatomic,strong)NSString *text;
/// 图片名
@property(nonatomic,strong)NSString *imageName;
/// 文本颜色，默认控件字体颜色
@property(nonatomic,strong)UIColor *textColor;
/// 文本字体，默认控件字体
@property(nonatomic,strong)UIFont *font;
/// 图片的最大高度，默认控件高度一半
@property(nonatomic,assign)CGFloat maxImageHeight;
/// 边距，默认0px
@property(nonatomic,assign)CGFloat periphery;
/// 最小宽度，默认实际宽度
@property(nonatomic,assign)CGFloat minWidth;
/// 图文样式，默认图左文右
@property(nonatomic,assign)KJTextAndImageStyle style;
/// 图文间距，默认5px
@property(nonatomic,assign)CGFloat padding;

@end

NS_ASSUME_NONNULL_END
