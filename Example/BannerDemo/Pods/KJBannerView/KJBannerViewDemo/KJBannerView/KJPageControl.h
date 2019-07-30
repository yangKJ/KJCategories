//
//  KJPageControl.h
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/5/27.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSInteger{
    PageControlStyleRectangle = 0, // 默认类型 长方形
    PageControlStyleCircle, // 圆形
    PageControlStyleSquare, // 正方形
}PageControlStyle;
@interface KJPageControl : UIPageControl
/* 总共点数 */
@property(nonatomic,assign)NSInteger totalPages;
/* 当前点，默认0 */
@property(nonatomic,assign)NSInteger currentIndex;
/* 选中的色，默认白色 */
@property(nonatomic,strong)UIColor *selectColor;
/* 背景色，默认灰色 */
@property(nonatomic,strong)UIColor *normalColor;
/* 类别，默认长方形 */
@property(nonatomic,assign)PageControlStyle pageType;
@end

NS_ASSUME_NONNULL_END
