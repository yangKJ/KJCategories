//
//  UIScrollView+KJEmptyDataSet.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/18.
//  https://github.com/YangKJ/KJCategories
//  DZNEmptyDataSet 基础上再次封装没数据时状态

/* ******************  需要引入DZNEmptyDataSet库，pod 'DZNEmptyDataSet' ******************/

#import <UIKit/UIKit.h>

#if __has_include(<DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>)
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (KJEmptyDataSet) <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
/// 是否正在加载，加载数据前必须设置为YES
@property(nonatomic,assign)BOOL loading;

//*************** 空数据的显示 loading = NO **************
/// 视图的垂直位置
@property(nonatomic,assign)CGFloat verticalOffset;
/// 空数据图片名
@property(nonatomic,strong)NSString *loadedImageName;
/// 空数据详情信息，默认 "没有数据，您可以尝试重新获取"
@property(nonatomic,strong)NSAttributedString *descriptionText;
/// 刷新按钮文字，默认 "再次刷新"
@property(nonatomic,copy,readwrite)NSAttributedString *_Nullable(^kLoadedButton)(UIControlState state);
/// 加载时刻展示的视图，默认系统菊花视图
@property(nonatomic,copy,readwrite)UIView *_Nullable(^kLoadingContentView)(void);
/// 刷新按钮点击事件，返回是否刷新视图
@property(nonatomic,copy,readwrite)bool(^kLoadedButtonClick)(UIButton *button);
/// 其他视图点击事件
@property(nonatomic,copy,readwrite)void(^kLoadedOtherViewClick)(void);

@end

NS_ASSUME_NONNULL_END

#endif
