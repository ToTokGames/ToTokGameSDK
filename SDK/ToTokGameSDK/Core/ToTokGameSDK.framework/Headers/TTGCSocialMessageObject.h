//
//  TTGCSocialMessageObject.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/21.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

/**
 *  社交平台类型
 */
typedef NS_ENUM(NSInteger, TTGCSocialPlateType) {
    TTGCSocialPlate_Facebook       = 1,             // Facebook
    TTGCSocialPlate_Messenger      = 2,             // Messenger
    TTGCSocialPlate_WhatsApp       = 3,             // WhatsApp
};

/**
 *  分享内容类型
 */
typedef NS_ENUM(NSInteger, TTGCShareContentType) {
    TTGCShareContent_Link          = 1,             // 链接
    TTGCShareContent_Photo         = 2,             // 图片
    TTGCShareContent_Video         = 3,             // 视频
    TTGCShareContent_Media         = 4,             // 多媒体
};

NS_ASSUME_NONNULL_BEGIN

@interface TTGCSocialMessageObject : NSObject

@property (nonatomic) TTGCSocialPlateType plateType; //社交平台类型

/**
 分享内容类型
 facebook 需要设置
 messenger、whatsApp 暂时不需要设置
*/
@property (nonatomic) TTGCShareContentType contentType;

/**
 link URL
 支持类型
 facebook
 messenger: (UIImage、NSURL)
 whatsApp: (UIImage、NSURL)
*/
@property (nonatomic, copy) NSURL *contentURL;

/**
 分享图片数组
 支持类型
 facebook:（UIImage、NSURL、PHAsset）
 messenger: (UIImage、NSURL)
 whatsApp: (UIImage、NSURL)
*/
@property (nonatomic, copy) NSArray *photos;

/**
 视频资源
 支持类型
 facebook:（NSData、PHAsset、NSURL）
 messenger: (NSURL)
 whatsApp: (NSURL)
 */
/**
 video data.
*/
@property (nonatomic, strong, nullable) NSData *videoData;

/**
 The representation of the video in the Photos library.
 @return PHAsset that represents the video in the Photos library.
*/
@property (nonatomic, copy, nullable) PHAsset *videoAsset;

/**
 The file URL to the video.
 @return URL that points to the location of the video on disk
*/
@property (nonatomic, copy, nullable) NSURL *videoURL;

/**
 文字
 支持类型
 whatsApp: (NSString)
*/
@property (nonatomic, copy) NSString *contentString;


@end

NS_ASSUME_NONNULL_END
