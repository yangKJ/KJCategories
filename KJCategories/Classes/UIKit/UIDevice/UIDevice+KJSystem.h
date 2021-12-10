//
//  UIDevice+KJSystem.h
//  KJEmitterView
//
//  Created by 77。 on 2019/10/23.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (KJSystem)

/// Determine whether the App supports horizontal screen
@property (nonatomic,assign,class) BOOL supportHorizontalScreen;
/// System startup map cache path
@property (nonatomic,strong,class) NSString *launchImageCachePath;
/// Boot map backup file path
@property (nonatomic,strong,class) NSString *launchImageBackupPath;

/// Generate startup diagram, which is obtained in LaunchScreen by default
/// @param portrait Whether the screen is vertical
/// @param dark is it dark
/// @return Return to the startup diagram
+ (UIImage *)kj_launchImageWithPortrait:(BOOL)portrait dark:(BOOL)dark;

/// Generate startup diagram
/// @param name LaunchScreen name
/// @param portrait Whether the screen is vertical
/// @param dark is it dark
/// @return Return to the startup diagram
+ (UIImage *)kj_launchImageWithStoryboard:(NSString *)name
                                 portrait:(BOOL)portrait
                                     dark:(BOOL)dark;

/// Compare version number
+ (BOOL)kj_comparisonVersion:(NSString *)version;

/// Get AppStore version number and detailed information
/// @param appid App store version account
/// @param details data information
/// @return returns the AppStore version number
+ (NSString *)kj_getAppStoreVersionWithAppid:(NSString *)appid
                                     details:(void(^)(NSDictionary * userInfo))details;

/// Jump to the specified URL
+ (void)kj_openURL:(id)URL;
/// Call AppStore
+ (void)kj_skipToAppStoreWithAppid:(NSString *)appid;
/// Call the built-in browser safari
+ (void)kj_skipToSafari;
/// Call your own Mail
+ (void)kj_skipToMail;
/// Whether to switch to speaker
+ (void)kj_changeLoudspeaker:(BOOL)loudspeaker;
/// Whether to turn on the flashlight
+ (void)kj_changeFlashlight:(BOOL)light;

/// Fingerprint verification
+ (void)kj_fingerprintVerification:(void(^)(NSError * error, BOOL reset))block;

/// Whether to enable proxy to prevent Charles from capturing packets
/// @param url test URL, the default Baidu URL
+ (BOOL)kj_checkOpenProxy:(NSString * _Nullable)url;

/// The system comes with shared pictures
/// @param image share
/// @param complete callback for success or failure of sharing
+ (UIActivityViewController *)kj_shareSystemImage:(UIImage *)image
                                         complete:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
