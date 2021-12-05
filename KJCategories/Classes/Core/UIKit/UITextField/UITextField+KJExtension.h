//
//  UITextField+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/4.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UITextField (KJExtension)

/// 占位placeholder颜色
@property(nonatomic,strong)IBInspectable UIColor *placeholderColor;
/// 占位文字字体大小
@property(nonatomic,assign)IBInspectable CGFloat placeholderFontSize;
/// 最大长度
@property(nonatomic,assign)IBInspectable NSInteger maxLength;
/// 明文暗文切换
@property(nonatomic,assign)BOOL securePasswords;
/// 是否显示键盘上面的操作栏，顶部完成按钮
@property(nonatomic,assign)BOOL displayInputAccessoryView;
/// 达到最大字符长度
@property(nonatomic,copy,readwrite)void(^kMaxLengthBolck)(NSString * text);
/// 文本编辑时刻
@property(nonatomic,copy,readwrite)void(^kTextEditingChangedBolck)(NSString * text);

@end

NS_ASSUME_NONNULL_END
