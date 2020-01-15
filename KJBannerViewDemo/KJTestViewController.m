//
//  KJTestViewController.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2020/1/15.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "KJTestViewController.h"
#import <sys/sysctl.h>
#import <mach/mach.h>

@interface KJTestViewController ()

@end

@implementation KJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = UIColor.whiteColor;
    CGFloat w = self.view.frame.size.width;
//    CGFloat h = self.view.frame.size.height;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 64 + 30, w-40, 20)];
    label.textColor = UIColor.greenColor;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 64 + 30 + 50, w-40, 20)];
    label2.textColor = UIColor.greenColor;
    label2.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    
    label.text = [NSString stringWithFormat:@"当前设备可用内存：%.2fMB",[KJTestViewController availableMemory]];
    label2.text =[NSString stringWithFormat:@"当前任务所占用内存：%.2fMB",[KJTestViewController usedMemory]];
}
  //获取当前设备可用内存
 + (double)availableMemory{
      vm_statistics_data_t vmStats;
      mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
      kern_return_t kernReturn = host_statistics(mach_host_self(),
                                           HOST_VM_INFO,
                                           (host_info_t)&vmStats,
                                           &infoCount);

    if (kernReturn != KERN_SUCCESS) {
    return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count)/1024.0)/1024.0;
}

//获取当前任务所占用内存
+ (double)usedMemory{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                     TASK_BASIC_INFO,
                                     (task_info_t)&taskInfo,
                                     &infoCount);

      if (kernReturn != KERN_SUCCESS) {
      return NSNotFound;
      }
      return taskInfo.resident_size/1024.0/1024.0;
}
@end
