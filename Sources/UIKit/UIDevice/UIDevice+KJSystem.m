//
//  UIDevice+KJSystem.m
//  KJEmitterView
//
//  Created by 77。 on 2019/10/23.
//  https://github.com/YangKJ/KJCategories

#import "UIDevice+KJSystem.h"
#import <AVFoundation/AVFoundation.h>
#import <LocalAuthentication/LocalAuthentication.h>// 指纹解锁必须的头文件

@implementation UIDevice (KJSystem)

@dynamic supportHorizontalScreen;
+ (BOOL)supportHorizontalScreen{
    NSArray *temp = [NSBundle.mainBundle.infoDictionary objectForKey:@"UISupportedInterfaceOrientations"];
    if ([temp containsObject:@"UIInterfaceOrientationLandscapeLeft"] ||
        [temp containsObject:@"UIInterfaceOrientationLandscapeRight"]) {
        return YES;
    } else {
        return NO;
    }
}

@dynamic launchImageCachePath,launchImageBackupPath;
+ (NSString *)launchImageCachePath{
    NSString *bundleID = [NSBundle mainBundle].infoDictionary[@"CFBundleIdentifier"];
    NSString *path = nil;
    if (@available(iOS 13.0, *)) {
        NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        path = [NSString stringWithFormat:@"%@/SplashBoard/Snapshots/%@ - {DEFAULT GROUP}", libraryDirectory, bundleID];
    } else {
        NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        path = [[cachesDirectory stringByAppendingPathComponent:@"Snapshots"] stringByAppendingPathComponent:bundleID];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return path;
    }
    return nil;
}
+ (NSString *)launchImageBackupPath{
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [cachesDirectory stringByAppendingPathComponent:@"ll_launchImage_backup"];
    if (![NSFileManager.defaultManager fileExistsAtPath:path]) {
        [NSFileManager.defaultManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:@{} error:nil];
    }
    return path;
}
/// 生成启动图
+ (UIImage *)kj_launchImageWithPortrait:(BOOL)portrait dark:(BOOL)dark{
    return [self kj_launchImageWithStoryboard:@"LaunchScreen" portrait:portrait dark:dark];
}
/// 生成启动图，根据LaunchScreen名称、是否竖屏、是否暗黑
+ (UIImage *)kj_launchImageWithStoryboard:(NSString *)name portrait:(BOOL)portrait dark:(BOOL)dark{
    if (@available(iOS 13.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
        window.overrideUserInterfaceStyle = dark?UIUserInterfaceStyleDark:UIUserInterfaceStyleLight;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    UIView *__view = storyboard.instantiateInitialViewController.view;
    __view.frame = [UIScreen mainScreen].bounds;
    CGFloat w = __view.frame.size.width;
    CGFloat h = __view.frame.size.height;
    if (portrait) {
        if (w > h) __view.frame = CGRectMake(0, 0, h, w);
    } else {
        if (w < h) __view.frame = CGRectMake(0, 0, h, w);
    }
    [__view setNeedsLayout];
    [__view layoutIfNeeded];
    UIGraphicsBeginImageContextWithOptions(__view.frame.size, NO, [UIScreen mainScreen].scale);
    [__view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *launchImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return launchImage;
}

/// 对比版本号
+ (BOOL)kj_comparisonVersion:(NSString *)version{
    NSString *appCurrentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([version compare:appCurrentVersion] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}
/// 获取AppStore版本号和详情信息
+ (NSString *)kj_getAppStoreVersionWithAppid:(NSString *)appid details:(void(^)(NSDictionary *))details{
    __block NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (appid == nil) return appVersion;
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_async(dispatch_group_create(), queue, ^{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
            NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSDictionary * dict = [json[@"results"] firstObject];
            appVersion = dict[@"version"];
            if (details) details(dict);
            dispatch_semaphore_signal(semaphore);
        }] resume];
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return appVersion;
}
/// 跳转到指定URL
+ (void)kj_openURL:(id)URL{
    if (URL == nil) return;
    if (![URL isKindOfClass:[NSURL class]]) {
        URL = [NSURL URLWithString:URL];
    }
    if ([[UIApplication sharedApplication] canOpenURL:URL]){
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] openURL:URL];
#pragma clang diagnostic pop
        }
    }
}
/// 调用AppStore
+ (void)kj_skipToAppStoreWithAppid:(NSString *)appid{
    NSString * appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *urlString = [@"http://itunes.apple.com/" stringByAppendingFormat:@"%@?id=%@",appName,appid];
    [self kj_openURL:urlString];
}
/// 调用自带浏览器safari
+ (void)kj_skipToSafari{
    [self kj_openURL:@"http://www.abt.com"];
}
/// 调用自带Mail
+ (void)kj_skipToMail{
    [self kj_openURL:@"mailto://admin@abt.com"];
}
/// 是否切换为扬声器
+ (void)kj_changeLoudspeaker:(BOOL)loudspeaker{
    if (loudspeaker) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    } else {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
}
/// 是否开启手电筒
+ (void)kj_changeFlashlight:(BOOL)light{
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![captureDevice hasTorch]) return;
    if (light) {
        NSError *error = nil;
        if ([captureDevice lockForConfiguration:&error]) {
            [captureDevice setTorchMode:AVCaptureTorchModeOn];
        }
    } else {
        [captureDevice lockForConfiguration:nil];
        [captureDevice setTorchMode:AVCaptureTorchModeOff];
    }
    [captureDevice unlockForConfiguration];
}
/// 指纹验证
+ (void)kj_fingerprintVerification:(void(^)(NSError *error, BOOL reset))block{
    LAContext * context = [[LAContext alloc]init];
    if (@available(iOS 10.0, *)) {
        context.localizedCancelTitle = NSLocalizedString(@"取消", nil);
    }
    NSError * error;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:NSLocalizedString(@"验证指纹以确认你的身份", nil)
                          reply:^(BOOL success, NSError *error) {
            if (success) {
                if (block) block(nil,YES);
            } else {
                if (block) block(error,NO);
            }
        }];
    } else {
        if (block) block(error,NO);
    }
}
/// 是否开启代理，防止Charles抓包
+ (BOOL)kj_checkOpenProxy:(NSString * _Nullable)url{
    NSDictionary * dict = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSURL * URL = [NSURL URLWithString:url ?: @"https://www.baidu.com"];
    NSArray *proxies = (__bridge NSArray*)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)(URL),
                                                                      (__bridge CFDictionaryRef _Nonnull)(dict)));
    if (proxies.count) {
        NSDictionary * settings = proxies[0];
        if ([[settings objectForKey:(NSString*)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return NO;
    }
}

/// 系统自带分享图片
/// @param image 分享
/// @param complete 分享成功与否回调
+ (UIActivityViewController *)kj_shareSystemImage:(UIImage *)image complete:(void(^)(BOOL))complete{
    NSArray * items = @[UIImagePNGRepresentation(image)];
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    if (@available(iOS 11.0, *)) {
        vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypeOpenInIBooks, UIActivityTypeMarkupAsPDF];
    } else if (@available(iOS 9.0, *)) {
        vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypeOpenInIBooks];
    } else {
        vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail];
    }
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock =
    ^(UIActivityType activityType, BOOL completed, NSArray * returnedItems, NSError * activityError) {
        if (complete) complete(completed);
    };
    vc.completionWithItemsHandler = itemsBlock;
    
    UIViewController * __autoreleasing topvc = kDeviceTopViewController();
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        vc.popoverPresentationController.sourceView = topvc.view;
        CGSize size = [UIScreen mainScreen].bounds.size;
        vc.popoverPresentationController.sourceRect = CGRectMake(size.width/2, size.height, 0, 0);
    }
    [topvc presentViewController:vc animated:YES completion:nil];
    return vc;
}

/// 顶部控制器
NS_INLINE UIViewController * kDeviceTopViewController(void){
    UIViewController *result = nil;
    UIWindow *window = ({
        UIWindow *window;
        if (@available(iOS 13.0, *)) {
            window = [UIApplication sharedApplication].windows.firstObject;
        } else {
            window = [UIApplication sharedApplication].keyWindow;
        }
        window;
    });
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)vc;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result = nav.childViewControllers.lastObject;
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)vc;
        result = nav.childViewControllers.lastObject;
    } else {
        result = vc;
    }
    return result;
}

@end
