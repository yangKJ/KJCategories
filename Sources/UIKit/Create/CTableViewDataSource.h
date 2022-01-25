//
//  CTableViewDataSource.h
//  KJEmitterView
//
//  Created by yangkejun on 2019/4/25.
//  https://github.com/yangKJ/KJEmitterView
//  快捷创建列表封装

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign, readonly) CGFloat totalHeight;//总高度
@property (nonatomic, assign) BOOL canEdit;//是否可以编辑
/// 设置不同类型的Cell
@property (nonatomic, copy, readwrite) __kindof UITableViewCell * (^tableViewCellAtIndexPath)(NSString * identifier, NSIndexPath * indexPath);
/// 设置不同类型Cell的标识符
@property (nonatomic, copy, readwrite) NSString * (^identifierAtIndexPath)(NSIndexPath * indexPath);
/// 设置不同Cell高度
@property (nonatomic, copy, readwrite) CGFloat (^heightForRowAtIndexPath)(NSIndexPath * indexPath);
/// 返回多少组Section
@property (nonatomic, copy, readwrite) NSInteger (^tableViewNumberSections)(void);
/// 返回每组Section有多少个Cell
@property (nonatomic, copy, readwrite) NSInteger (^numberOfRowsInSection)(NSInteger section);
/// 系统自带右侧标题索引
@property (nonatomic, copy, readwrite) NSArray * (^sectionIndexTitlesForTableView)(void);

//Header
@property (nonatomic, copy, readwrite) CGFloat (^heightForHeaderInSection)(NSInteger section);
@property (nonatomic, copy, readwrite) UIView *(^viewForHeaderInSection)(NSInteger section);
@property (nonatomic, copy, readwrite) NSString * (^titleForHeaderInSection)(NSInteger section);

//Footer
@property (nonatomic, copy, readwrite) CGFloat (^heightForFooterInSection)(NSInteger section);
@property (nonatomic, copy, readwrite) UIView *(^viewForFooterInSection)(NSInteger section);
@property (nonatomic, copy, readwrite) NSString * (^titleForFooterInSection)(NSInteger section);
 
//点击处理
@property (nonatomic, copy, readwrite) void (^didSelectRowAtIndexPath)(NSIndexPath * indexPath);
@property (nonatomic, copy, readwrite) void (^didDeselectRowAtIndexPath)(NSIndexPath * indexPath);

//编辑，删除
@property (nonatomic, copy, readwrite) UITableViewCellEditingStyle (^editingStyleForRowAtIndexPath)(NSIndexPath * indexPath);
@property (nonatomic, copy, readwrite) BOOL (^canEditRowAtIndexPath)(NSIndexPath * indexPath);
@property (nonatomic, copy, readwrite) void (^deleteRowAtIndexPath)(NSIndexPath * indexPath);

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new  NS_UNAVAILABLE;
- (instancetype)initWithConfigureBlock:(void(^)(UITableViewCell * cell, NSIndexPath * indexPath))block;

@end

NS_ASSUME_NONNULL_END
