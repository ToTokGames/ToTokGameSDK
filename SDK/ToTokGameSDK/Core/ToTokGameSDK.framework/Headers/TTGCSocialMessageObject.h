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
 *  Social platform type
 */
typedef NS_ENUM(NSInteger, TTGCSocialPlateType) {
    TTGCSocialPlate_Facebook       = 1,             // Facebook
    TTGCSocialPlate_WhatsApp       = 2,             // WhatsApp
    
    //The following content is not open yet
    TTGCSocialPlate_Messenger      = 3,             // Messenger
    TTGCSocialPlate_ToTokApp       = 4,             // ToTokApp
    TTGCSocialPlate_ToTokApi       = 5              // ToTokApi
};

/**
 *  Share content type
 */
typedef NS_ENUM(NSInteger, TTGCShareContentType) {
    TTGCShareContent_Link          = 1,
    TTGCShareContent_Photo         = 2,
    
    //The following content is not open yet
    TTGCShareContent_Video         = 3,
    TTGCShareContent_Media         = 4,
};

/**
 *  Share custom templates
 */
typedef NS_ENUM(NSInteger, TTGCShareTemplate) {
    TTGCShareTemplate_Default        = 1,             // the link of game page
    TTGCShareTemplate_Invite         = 2,             // invite link
};

NS_ASSUME_NONNULL_BEGIN

//TTGCSocialMessageObject
//The model is temporarily internal, so game developers do n’t need to pay attention
@interface TTGCSocialMessageObject : NSObject

/**
 Social platform type
 Share required fields
*/
@property (nonatomic) TTGCSocialPlateType plateType;

/**
 Share content type
 Share required fields
*/
@property (nonatomic) TTGCShareContentType contentType;

/**
 Share custom templates
 When the sharing content type is TTGCShareContent_Link is a required field
*/
@property (nonatomic) TTGCShareTemplate shareTemplate;

/**
 link URL
 Currently the link content is defined by the SDK based on the shareTemplate, and developers do not need to use.
*/
@property (nonatomic, copy, nullable) NSURL *contentURL;

/**
 Some quote text of the link.（Facebook）
If specified, the quote text will render with custom styling on top of the link.
*/
@property (nonatomic, copy, nullable) NSString *quote;

/**
 Share photos array
 
 Supported types
 facebook:（UIImage、NSURL、PHAsset）
 messenger: (UIImage、NSURL)
 whatsApp: (UIImage、NSURL)
*/
@property (nonatomic, copy) NSArray *photos;

/**
 Video
 
 Supported types
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
 Share content string
 
 Supported types
 whatsApp: (NSString)
*/
@property (nonatomic, copy) NSString *contentString;


@end

/************************* Facebook ******************************/

// FacebookInvite Model
@interface TTGCSocialFBInvite : NSObject

@property (nonatomic, copy, nullable) NSString *quote; // Some quote text of the link

@end

// Facebook Image Model
@interface TTGCSocialFBImages : NSObject

@property (nonatomic, copy) NSArray *photos; // share images array（NSData、PHAsset、NSURL）

@end

/************************* WhatsApp ******************************/

// WhatsApp Link Model
@interface TTGCSocialWAInvite : NSObject

@property (nonatomic, copy) NSString *contentString; // share content string

@end

// WhatsApp Image Model
@interface TTGCSocialWAImages : NSObject

@property (nonatomic, copy) NSArray *photos; // share images array（NSData、PHAsset、NSURL）

@end


NS_ASSUME_NONNULL_END
