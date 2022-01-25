//
//  UIImage+KJGIF.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJGIF)

/// Whether it is a dynamic picture
@property (nonatomic,assign,readonly) BOOL isGif;

/// Local dynamic picture playback
/// @param name dynamic image name
/// @return returns animated gif
+ (UIImage *)kj_gifLocalityImageWithName:(NSString *)name;

/// Local animation
/// @param data data source
/// @return returns animated gif
+ (UIImage *)kj_gifImageWithData:(NSData *)data;

/// Network animation
/// @param URL image link
/// @return returns animated gif
+ (UIImage *)kj_gifImageWithURL:(NSURL *)URL;

/// Picture playback, dynamic picture
/// @param data data source
/// @return returns animated gif
+ (UIImage *)kj_playImageWithData:(NSData *)data;

/// The child thread plays the dynamic picture
/// @param xxblock dynamic graph generation callback
/// @param data image data
void kPlayGifImageData(void(^xxblock)(bool isgif, UIImage * image), NSData * data);

@end

NS_ASSUME_NONNULL_END
