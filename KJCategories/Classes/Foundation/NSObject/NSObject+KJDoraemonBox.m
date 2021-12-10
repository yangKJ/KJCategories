//
//  NSObject+KJDoraemonBox.m
//  KJEmitterView
//
//  Created by 77。 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories

#import "NSObject+KJDoraemonBox.h"
#import <objc/runtime.h>

@implementation NSObject (KJDoraemonBox)

#pragma mark - 轻量级解耦工具（信号）
/// 发送消息处理
- (id)kj_sendSemaphoreWithKey:(NSString *)key Message:(id)message Parameter:(id _Nullable)parameter{
#ifdef DEBUG
    NSLog(@"🍒🍒 发送信号消息 🍒🍒\nSenderKey:%@\n目标:%@\n发送者:%@\n携带参数:%@",key,message,self,parameter);
#endif
    if (self.semaphoreblock) return self.semaphoreblock(key,message,parameter);
    return nil;
}
/// 接收消息处理
- (void)kj_receivedSemaphoreBlock:(id _Nullable(^)(NSString *key, id message, id _Nullable parameter))block{
    self.semaphoreblock = block;
}
#pragma mark - associated
- (id _Nullable(^)(NSString *key, id message, id _Nullable parameter))semaphoreblock{
    return objc_getAssociatedObject(self, @selector(semaphoreblock));
}
- (void)setSemaphoreblock:(id _Nullable(^)(NSString *key, id message, id _Nullable parameter))semaphoreblock{
    objc_setAssociatedObject(self, @selector(semaphoreblock), semaphoreblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - 路由框架（基于URL实现控制器转场）

+ (NSMutableDictionary *)routerDict{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (dict == nil) dict = [NSMutableDictionary dictionary];
    return dict;
}
+ (void)setRouterDict:(NSMutableDictionary*)routerDict{
    objc_setAssociatedObject(self, @selector(routerDict), routerDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
NS_INLINE NSString *keyFromURL(NSURL *URL){
    return URL ? [NSString stringWithFormat:@"%@://%@%@",URL.scheme,URL.host,URL.path] : nil;
}
/// 注册路由URL
+ (void)kj_routerRegisterWithURL:(NSURL *)URL Block:(UIViewController * (^)(NSURL *URL, UIViewController *))block{
    if (![self kj_reasonableURL:URL]) return;
    NSString *key = keyFromURL(URL) ?: @"kDefaultRouterKey";
    @synchronized (self) {
        if (self.routerDict[key]) {
            [self.routerDict[key] addObject:block];
        } else {
            self.routerDict[key] = [NSMutableArray arrayWithObject:block];
        }
    }
}
/// 移除路由URL
+ (void)kj_routerRemoveWithURL:(NSURL *)URL{
    if (![self kj_reasonableURL:URL]) return;
    NSString *key = keyFromURL(URL) ?: @"kDefaultRouterKey";
    if (self.routerDict[key]) [self.routerDict removeObjectForKey:key];
    self.routerDict = nil;
}
/// 执行跳转处理
+ (void)kj_routerTransferWithURL:(NSURL *)URL source:(UIViewController *)vc{
    [self kj_routerTransferWithURL:URL source:vc completion:nil];
}
+ (void)kj_routerTransferWithURL:(NSURL *)URL source:(UIViewController *)vc completion:(void(^_Nullable)(UIViewController *))completion{
    if (![self kj_reasonableURL:URL] || ![NSThread isMainThread]) return;
    NSMutableArray<NSArray*>* keys = [NSMutableArray array];
    NSString *currentKey = keyFromURL(URL);
    if (currentKey) [keys addObject:@[currentKey]];
    __block UIViewController *__vc = nil;
    __weak __typeof(self) weakself = self;
    [keys enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *temps = [weakself kj_effectiveWithKeys:obj];
        __vc = [weakself kj_getTargetViewControllerWith:temps URL:URL source:vc?:weakself.topViewController];
        *stop = !!__vc;
    }];
    if (__vc == nil) return;
    if (completion) completion(__vc);
}

+ (BOOL)kj_reasonableURL:(NSURL *)URL{
    if (!URL) {
        NSAssert(URL, @"URL can not be nil");
        return NO;
    }
    if ([URL.scheme length] <= 0) {
        NSAssert([URL.scheme length] > 0, @"URL.scheme can not be nil");
        return NO;
    }
    if ([URL.host length] <= 0) {
        NSAssert([URL.host length] > 0, @"URL.host can not be nil");
        return NO;
    }
    if ([URL.absoluteString isEqualToString:@""]) {
        NSAssert(![URL.absoluteString isEqualToString:@""], @"URL.absoluteString can not be nil");
        return NO;
    }
    return YES;
}
+ (NSArray *)kj_effectiveWithKeys:(NSArray *)keys{
    if (!keys || ![keys count]) return nil;
    NSMutableArray *temps = [NSMutableArray array];
    for (NSString *key in keys) {
        if(self.routerDict[key] && [self.routerDict[key] count] > 0) {
            [temps addObjectsFromArray:self.routerDict[key]];
        }
    }
    return temps.mutableCopy;
}
+ (UIViewController *)kj_getTargetViewControllerWith:(NSArray *)blocks URL:(NSURL *)URL source:(UIViewController *)vc{
    if (!blocks || ![blocks count]) return nil;
    __block UIViewController *__vc = nil;
    [blocks enumerateObjectsUsingBlock:^(UIViewController *(^obj)(NSURL *,UIViewController *), NSUInteger idx, BOOL * stop) {
        if (obj) {
            __vc = obj(URL,vc);
            if (__vc == nil) *stop = YES;
        }
    }];
    return __vc;
}
+ (UIViewController *)topViewController{
    UIWindow *window = ({
        UIWindow *window;
        if (@available(iOS 13.0, *)) {
            window = [UIApplication sharedApplication].windows.firstObject;
        } else {
            window = [UIApplication sharedApplication].keyWindow;
        }
        window;
    });
    return [self topViewControllerForRootViewController:window.rootViewController];
}
+ (UIViewController *)topViewControllerForRootViewController:(UIViewController *)rootViewController{
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerForRootViewController:navigationController.viewControllers.lastObject];
    }
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerForRootViewController:tabBarController.selectedViewController];
    }
    if (rootViewController.presentedViewController) {
        return [self topViewControllerForRootViewController:rootViewController.presentedViewController];
    }
    if ([rootViewController isViewLoaded] && rootViewController.view.window) {
        return rootViewController;
    }
    return nil;
}

//  路由 - 基于URL实现控制器转场的框架
//  NSURL *URL = [NSURL URLWithString:@"https://www.test.com/xxxx/abc?className=KJVideoEncodeVC&title=title"];
//  URL.query          // className=KJVideoEncodeVC&title=title
//  URL.scheme         // https
//  URL.host           // www.test.com
//  URL.path           // /xxxx/abc
//  URL.absoluteString // https://www.test.com/xxxx/abc?className=KJVideoEncodeVC&title=title
/// 解析获取参数
+ (NSDictionary *)kj_analysisParameterGetQuery:(NSURL *)URL{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    NSURLComponents *URLComponents = [[NSURLComponents alloc] initWithString:URL.absoluteString];
    [URLComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * obj, NSUInteger idx, BOOL * stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    return parm;
}

#pragma mark - 安全数据处理
/// 安全非空数据转换
/// @return 处理之后的对象，NSNull转换为空字符串
- (id)kj_safeObject{
    id object = self;
    if ([object isKindOfClass:[NSNull class]]) {
        return @"";
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        return kReplaceDictionaryNull(object);
    } else if ([object isKindOfClass:[NSArray class]]) {
        return kReplaceArrayNull(object);
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return kReplaceNumberNull(object);
    } else if ([object isKindOfClass:[NSString class]]) {
        return kReplaceStringNull(object);
    }
    return object;
}
/// 处理字典
NS_INLINE NSDictionary * kReplaceDictionaryNull(NSDictionary * dict){
    if (dict == nil || dict.count == 0 || [dict isKindOfClass:[NSNull class]]) {
        return @{};
    }
    @autoreleasepool {
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        for (NSString *key in dict.allKeys) {
            [temp setObject:[dict[key] kj_safeObject] forKey:key];
        }
        return temp.mutableCopy;
    }
}
/// 处理数组
NS_INLINE NSArray * kReplaceArrayNull(NSArray * array){
    if (array == nil || array.count == 0 || [array isKindOfClass:[NSNull class]]) {
        return @[];
    }
    @autoreleasepool {
        __block NSMutableArray *temp = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
            [temp addObject:[obj kj_safeObject]];
        }];
        return temp.mutableCopy;
    }
}
/// 处理NSNumber
NS_INLINE NSNumber * kReplaceNumberNull(NSNumber * number){
    if ([number isKindOfClass:[NSNull class]] || number == nil) {
        number = @(0);
    }
    return number;
}
/// 处理字符串
NS_INLINE NSString * kReplaceStringNull(NSString * string){
    string = [NSString stringWithFormat:@"%@",string];
    if ([string isKindOfClass:[NSNull class]] ||
        [string isEqualToString:@"(null)"] ||
        [string isEqualToString:@"null"] ||
        [string isEqualToString:@"<null>"]) {
        string = @"";
    }
    return string;
}

/// 偷懒专用，自动生成属性代码
- (void)kj_autoCreatePropertyCodeWithJson:(id)json{
    NSDictionary *dict;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dict = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    NSMutableString *propertyCode = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        NSString *code = nil;
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,strong) NSString *%@;//%@", key,obj];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,assign) BOOL %@;//%@", key,obj];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,assign) NSInteger %@;//%@", key,obj];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,strong) NSDictionary *%@;//%@", key,obj];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,strong) NSArray *%@;//%@", key,obj];
        }
        [propertyCode appendFormat:@"\n%@", code];
    }];
    NSLog(@"%@",propertyCode);
}
/// 模型转换，支持二级和关键字替换
+ (__kindof NSObject*)kj_modelTransformJson:(id)json{
    id model = [[self alloc]init];
    NSDictionary *dict;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dict = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
    } else if ([json isKindOfClass:[NSArray class]]) {
        
    } else {
        return model;
    }
    //TODO:
    return model;
}


@end
