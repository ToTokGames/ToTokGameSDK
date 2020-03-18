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
    TTGCSocialPlate_WhatsApp       = 2,             // WhatsApp
    
    //以下内容暂未开放
    TTGCSocialPlate_Messenger      = 3,             // Messenger
    TTGCSocialPlate_ToTokApp       = 4,             // ToTokApp
    TTGCSocialPlate_ToTokApi       = 5              // ToTokApi
};

/**
 *  分享内容类型
 */
typedef NS_ENUM(NSInteger, TTGCShareContentType) {
    TTGCShareContent_Link          = 1,             // 链接
    TTGCShareContent_Photo         = 2,             // 图片
    
    //以下内容暂未开放
    TTGCShareContent_Video         = 3,             // 视频
    TTGCShareContent_Media         = 4,             // 多媒体
};

/**
 *  分享自定义模板
 */
typedef NS_ENUM(NSInteger, TTGCShareTemplate) {
    TTGCShareTemplate_Default        = 1,             // 默认为游戏详情link
    TTGCShareTemplate_Invite         = 2,             // 邀请
};

NS_ASSUME_NONNULL_BEGIN

//TTGCSocialMessageObject模型暂时为内部使用，接入人员无需关注
@interface TTGCSocialMessageObject : NSObject

/**
 社交平台类型
 分享必传字段
*/
@property (nonatomic) TTGCSocialPlateType plateType;

/**
 分享内容类型
 分享必传字段
*/
@property (nonatomic) TTGCShareContentType contentType;

/**
 分享自定义模板
 当分享内容类型为 TTGCShareContent_Link 为必传字段
*/
@property (nonatomic) TTGCShareTemplate shareTemplate;

/**
 link URL
 目前link内容由SDK根据 shareTemplate 定义，开发人员无需传入。
*/
@property (nonatomic, copy, nullable) NSURL *contentURL;

/**
 Some quote text of the link.（Facebook）
If specified, the quote text will render with custom styling on top of the link.
*/
@property (nonatomic, copy, nullable) NSString *quote;

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
 分享文字描述
 支持类型
 whatsApp: (NSString)
*/
@property (nonatomic, copy) NSString *contentString;


@end

/************************* Facebook ******************************/

// FacebookInvite模型
@interface TTGCSocialFBInvite : NSObject

@property (nonatomic, copy, nullable) NSString *quote; // Some quote text of the link

@end

// Facebook图片模型
@interface TTGCSocialFBImages : NSObject

@property (nonatomic, copy) NSArray *photos; // 分享图片数组（NSData、PHAsset、NSURL）

@end

/************************* WhatsApp ******************************/

// WhatsApp链接模型
@interface TTGCSocialWAInvite : NSObject

@property (nonatomic, copy) NSString *contentString; // 分享文字描述

@end

// WhatsApp图片模型
@interface TTGCSocialWAImages : NSObject

@property (nonatomic, copy) NSArray *photos; // 分享图片数组（NSData、PHAsset、NSURL）

@end


NS_ASSUME_NONNULL_END
