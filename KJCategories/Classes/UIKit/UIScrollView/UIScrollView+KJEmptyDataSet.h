//
//  UIScrollView+KJEmptyDataSet.h
//  KJEmitterView
//
//  Created by 77。 on 2019/11/18.
//  https://github.com/YangKJ/KJCategories

// On the basis of DZNEmptyDataSet, the state when there is no data is encapsulated again

/* ****************** Need to introduce DZNEmptyDataSet library, pod'DZNEmptyDataSet' ******************/

#import <UIKit/UIKit.h>

#if __has_include(<DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>)
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (KJEmptyDataSet) <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/// Whether it is loading, it must be set to YES before loading data
@property (nonatomic, assign) BOOL loading;

//*************** Display of empty data loading = NO **************
/// The vertical position of the view
@property (nonatomic, assign) CGFloat verticalOffset;
/// Empty data picture name
@property (nonatomic, strong) NSString *loadedImageName;
/// Empty data details, default "No data, you can try to get it again"
@property (nonatomic, strong) NSAttributedString *descriptionText;
/// Refresh button text, default "refresh again"
@property (nonatomic, copy, readwrite) NSAttributedString *_Nullable(^kLoadedButton)(UIControlState state);
/// The view displayed at loading time, the default system chrysanthemum view
@property (nonatomic, copy, readwrite) UIView *_Nullable(^kLoadingContentView)(void);
/// Refresh button click event, return whether to refresh the view
@property (nonatomic, copy, readwrite) bool(^kLoadedButtonClick)(UIButton *button);
/// Other view click events
@property (nonatomic, copy, readwrite) void(^kLoadedOtherViewClick)(void);

@end

NS_ASSUME_NONNULL_END

#endif
