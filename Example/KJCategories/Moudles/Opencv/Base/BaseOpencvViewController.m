//
//  BaseOpencvViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2021/3/20.
//  https://github.com/YangKJ/KJCategories

#import "BaseOpencvViewController.h"
#import <Masonry/Masonry.h>

@interface BaseOpencvViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *issuesButton;

@end

@implementation BaseOpencvViewController

- (void)dealloc{
    // 只要控制器执行此方法，代表VC以及其控件全部已安全从内存中撤出。
    // ARC除去了手动管理内存，但不代表能控制循环引用，虽然去除了内存销毁概念，但引入了新的概念--对象被持有。
    // 框架在使用后能完全从内存中销毁才是最好的优化
    // 不明白ARC和内存泄漏的请自行谷歌，此示例已加入内存检测功能，如果有内存泄漏会alent进行提示
    NSLog(@"控制器%s调用情况，已销毁%@",__func__,self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInit];
    [self setupUI];
}

- (void)setupInit{
    self.view.backgroundColor = UIColorFromHEXA(0xf5f5f5, 1);
    _weakself;
    [self.navigationItem kj_makeNavigationItem:^(UINavigationItem * _Nonnull make) {
        make.kAddBarButtonItemInfo(^(KJNavigationItemInfo * _Nonnull info) {
            info.imageName = @"wode_nor";
            info.isLeft = NO;
            info.tintColor = UIColor.blueColor;
        }, ^(UIButton * _Nonnull kButton) {

        });
        make.kAddBarButtonItemInfo(^(KJNavigationItemInfo * _Nonnull info) {
            info.isLeft = NO;
            info.barButton = ^(UIButton * _Nonnull barButton) {
                [barButton setTitle:@"分享" forState:(UIControlStateNormal)];
                [barButton setTitleColor:UIColor.blueColor forState:(UIControlStateNormal)];
                barButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            };
        }, ^(UIButton * _Nonnull kButton) {
            CGRect rect = CGRectMake(0, weakself.topImageView.top, weakself.view.width, weakself.bottomImageView.bottom);
            UIImage *image = [UIImage kj_captureScreen:weakself.view Rect:rect Quality:3];
            [weakself kj_shareActivityWithItems:@[UIImagePNGRepresentation(image)] complete:^(BOOL success) {
                
            }];
        });
    }];
}

- (void)setupUI{
    [self.view addSubview:self.issuesButton];
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.bottomImageView];
    [self.view addSubview:self.changeButton];
    [self.view addSubview:self.topSlider];
    [self.view addSubview:self.bottomSlider];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(5);
        make.left.right.equalTo(self.view).inset(20);
        make.height.equalTo(self.bottomImageView.mas_height);
    }];
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [self.topSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.changeButton.mas_right).offset(10);
        make.right.equalTo(self.view).inset(20);
        make.centerY.equalTo(self.changeButton.mas_centerY).offset(-15);
        make.height.equalTo(@30);
    }];
    [self.bottomSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.changeButton.mas_right).offset(10);
        make.right.equalTo(self.view).inset(20);
        make.centerY.equalTo(self.changeButton.mas_centerY).offset(15);
        make.height.equalTo(@30);
    }];
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.changeButton.mas_bottom).offset(10);
        make.bottom.equalTo(self.issuesButton.mas_top).inset(5);
        make.left.right.equalTo(self.view).inset(20);
        make.height.equalTo(self.topImageView.mas_height);
    }];
    [self.issuesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(35);
        make.left.right.equalTo(self.view).inset(20);
        make.height.equalTo(@35);
    }];
    [_changeButton kj_updateFrame];
    [_changeButton bezierBorderWithRadius:10 borderWidth:1 borderColor:UIColor.greenColor];
}

#pragma mark - action

- (void)sliderValueChanged:(UISlider *)slider forEvent:(UIEvent *)event {
    UITouch *touchEvent = [[event allTouches]anyObject];
    switch(touchEvent.phase) {
        case UITouchPhaseBegan:break;
        case UITouchPhaseMoved:{
            if (slider.tag == 100) {
                self.kSliderMoving ? self.kSliderMoving(slider.value) : nil;
            } else if (slider.tag == 200) {
                self.kSlider2Moving ? self.kSlider2Moving(slider.value) : nil;
            }
        } break;
        case UITouchPhaseEnded:{
            CGFloat second = slider.value;
            [slider setValue:second animated:YES];
            if (slider.tag == 100) {
                self.kSliderMoveEnd ? self.kSliderMoveEnd(slider.value) : nil;
            } else if (slider.tag == 200) {
                self.kSlider2MoveEnd ? self.kSlider2MoveEnd(slider.value) : nil;
            }
        } break;
        default:break;
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.topImageView.image = image;
    }
}

#pragma mark - lazy

- (UIButton *)issuesButton{
    if (!_issuesButton) {
        _issuesButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                              initWithString:@"大家觉得好用还请点个星，遇见什么问题也可issues，持续更新ing.."
                                              attributes:@{NSForegroundColorAttributeName:UIColor.redColor}];
        [_issuesButton setAttributedTitle:attrStr forState:(UIControlStateNormal)];
        _issuesButton.titleLabel.numberOfLines = 0;
        _issuesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _issuesButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_issuesButton kj_addAction:^(UIButton * _Nonnull kButton) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            NSURL *url = [NSURL URLWithString:@"https://github.com/yangKJ/KJCategories"];
            [[UIApplication sharedApplication] openURL:url];
#pragma clang diagnostic pop
        }];
    }
    return _issuesButton;
}

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _topImageView.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.5];
        _topImageView.image = [UIImage imageNamed:@"fish"];
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
        _weakself;
        [_topImageView kj_AddTapGestureRecognizerBlock:^(UIView * view, UIGestureRecognizer * gesture) {
            UIImagePickerController *vc = [[UIImagePickerController alloc] init];
            vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            vc.delegate = weakself;
            [weakself presentViewController:vc animated:YES completion:nil];
        }];
    }
    return _topImageView;
}

- (UIImageView *)bottomImageView{
    if (!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _bottomImageView.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:0.5];
        _bottomImageView.contentMode = UIViewContentModeScaleAspectFit;
        _weakself;
        [_bottomImageView kj_AddTapGestureRecognizerBlock:^(UIView * view, UIGestureRecognizer * gesture) {
            UIImage * image = ((UIImageView *)view).image;
            if (image == nil) return;
            [weakself kj_shareActivityWithItems:@[UIImagePNGRepresentation((image))] complete:nil];
        }];
    }
    return _bottomImageView;
}

- (UIButton *)changeButton{
    if (!_changeButton) {
        _changeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _changeButton.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.5];
        [_changeButton setTitle:@"Change" forState:(UIControlStateNormal)];
        [_changeButton setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _changeButton.titleLabel.textAlignment = 1;
        _weakself;
        [_changeButton kj_addAction:^(UIButton * _Nonnull kButton) {
            weakself.kButtonAction ? weakself.kButtonAction() : nil;
        }];
    }
    return _changeButton;
}

- (UISlider *)topSlider{
    if (!_topSlider) {
        _topSlider = [[UISlider alloc]initWithFrame:CGRectZero];
        _topSlider.tag = 100;
        _topSlider.backgroundColor = UIColor.clearColor;
        _topSlider.minimumValue = 0.0;
        _topSlider.maximumValue = 1.0;
        [_topSlider addTarget:self
                       action:@selector(sliderValueChanged:forEvent:)
             forControlEvents:UIControlEventValueChanged];
    }
    return _topSlider;
}

- (UISlider *)bottomSlider{
    if (!_bottomSlider) {
        _bottomSlider = [[UISlider alloc]initWithFrame:CGRectZero];
        _bottomSlider.tag = 200;
        _bottomSlider.backgroundColor = UIColor.clearColor;
        _bottomSlider.minimumValue = 0.0;
        _bottomSlider.maximumValue = 1.0;
        [_bottomSlider addTarget:self
                          action:@selector(sliderValueChanged:forEvent:)
                forControlEvents:UIControlEventValueChanged];
    }
    return _bottomSlider;
}

@end
