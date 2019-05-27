//
//  KJPageControl.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/5/27.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJPageControl.h"

@implementation KJPageControl
- (instancetype)init{
    if (self = [super init]) {
//        self.userInteractionEnabled = NO;
    }
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView *subview = [self.subviews objectAtIndex:subviewIndex];
        
        //        CGSize size;
        
        //        size.height = 12;
        //
        //        size.width = 12;
        //
        //        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
        //
        //                                     size.width,size.height)];
        
        if (subviewIndex == currentPage)
            
            //        subview.image = [UIImage imageNamed:@"60.png"];
        {    subview.layer.cornerRadius = 0;
            subview.layer.masksToBounds = YES;
        }
        else
        {    //subview.image =[UIImage imageNamed:@"60.png"];
            subview.layer.cornerRadius = 0;
            subview.layer.masksToBounds = YES;
            
        }
    }
}

@end
