//
//  TTGCConfig.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/1.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTGCUserModel.h"
#import "TTGCFriendModel.h"
#import "TTGCOrderModel.h"
#import "TTGCSocialMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  支付过程回调状态
 */
typedef NS_ENUM(NSInteger, TTGCOderStatus) {
    TTGCOrderStatus_ProductQuerying          = 1, //查询商品中
    TTGCOrderStatus_Generating               = 2, //订单生成中
    TTGCOrderStatus_ProductPurchasing        = 3, //正在交易
    TTGCOrderStatus_ProductPurchased         = 4, //交易成功
    TTGCOrderStatus_ReceiptChecking          = 5, //订单校验中
};

/**
 *  启动动画完成回调
 *
 *  @param isFinish 动画完成
 *
 */
typedef void (^TTGCLaunchCompletion)(BOOL isFinish);

/**
 *  登录操作
 *
 *  @param actionType 表示操作类型
 *
 */
typedef void (^TTGCLoginAction)(TTGCLoginType actionType);

/**
 *  登录操作的回调
 *
 *  @param userInfo 表示用户信息 类型<TTGCUserModel>
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCUserCompletionHandler)(id _Nullable userInfo, NSError *_Nullable error);

/**
 *  Social平台授权操作的回调
 *
 *  @param loginResult 表示用户信息 类型<NSDictionary>
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCSocialPlateLoginCompletionHandler)(id _Nullable loginResult, NSError *_Nullable error);

/**
 *  Social平台取消授权操作的回调
 *
 *  @param logoutResult 表示用户信息 类型<NSDictionary>
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCSocialPlateLogoutCompletionHandler)(id _Nullable logoutResult, NSError *_Nullable error);

/**
 *  收到通知的回调
 *
 *  @param result 表示通知消息
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCNotificationCompletionHandler)(id _Nullable result, NSError *_Nullable error);

/**
 *  调用系统相册回调
 *
 *  @param mediaInfo 表示返回media信息 类型<NSDictionary>
 *  mediaInfo中对应的key和数据类型：
 *  MediaType       <NSString>  图片：public.image 视频：public.movie
 *  ImageURL        <NSURL>
 *  OriginalImage   <UIImage>
 *  ReferenceURL    <NSURL>an NSURL that references an asset
 *
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCSocialSystemPhotoCompletionHandler)(id _Nullable mediaInfo, NSError *_Nullable error);

/**
 *  登出的回调
 *
 *  @param success 表示是否成功
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCLogoutCompleteHandler)(BOOL success, NSError *_Nullable error);

/**
 *  获取好友列表的回调
 *
 *  @param list 表示好友列表数据
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCToTokFriendsCompletionHandler)(id _Nullable list, NSError *_Nullable error);

/**
 *  分享的回调
 *
 *  @param success 表示分享是否成功
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCShareCompleteHandler)(BOOL success, NSError *_Nullable error);

/**
 *  Universal Link Handle
 *
 *  @param url 表示UniversalUrl
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCUniversalLinkHandler)(NSURL *url, NSError *_Nullable error);

/**
 *  支付过程的回调
 *
 *  @param orderStatus 表示支付过程状态
 */
typedef void (^TTGCOrderProgressHandler)(TTGCOderStatus orderStatus);

/**
 *  支付结束的回调
 *
 *  @param orderInfo 表示订单信息
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCOrderCompletionHandler)(id _Nullable orderInfo, NSError *_Nullable error);

/**
 *  通用操作的回调
 *
 *  @param result 表示返回的结果
 *  @param error  表示回调的错误信息
 */
typedef void (^TTGCCompletionHandler)(id _Nullable result, NSError *_Nullable error);


/////////////////////////////////////////////////////////////////////////////
//平台的失败错误码--start
/////////////////////////////////////////////////////////////////////////////
/**
 *  返回错误类型
 */
typedef NS_ENUM(NSInteger, TTGCPlatformErrorType) {
    TTGCPlatformErrorType_Unknow            = 2000,             // 未知错误
    TTGCPlatformErrorType_AuthorizeFailed   = 2001,             // 授权失败
    TTGCPlatformErrorType_ForUserInfoFailed = 2002,             // 请求用户信息失败
    TTGCPlatformErrorType_LoginFailed       = 2003,             // 登录失败
    TTGCPlatformErrorType_FriendsListFailed = 2004,             // 获取好友列表失败
    TTGCPlatformErrorType_MessageSendFailed = 2005,             // 消息发送失败
    TTGCPlatformErrorType_PayFailed         = 2006,             // 支付失败
    TTGCPlatformErrorType_ShareFailed       = 2007,             // 分享失败
    TTGCPlatformErrorType_NotInstall        = 2008,             // 应用未安装
    TTGCPlatformErrorType_NotNetWork        = 2009,             // 网络异常
    TTGCPlatformErrorType_SourceError       = 2010,             // 第三方错误
};

/** The domain name used for the TTGCPlatformErrorType */
extern NSString* const TTGCPlatformErrorDomain;

/////////////////////////////////////////////////////////////////////////////
//平台的失败错误码--end
/////////////////////////////////////////////////////////////////////////////


@interface TTGCConfig : NSObject

/**
 *  创建错误类型
 *
 *  @param errorType 平台类型
 *  @param userInfo  用户的自定义信息userInfo
 *
 *  @return 返回错误对象
 */
+ (NSError *)errorWithTTGCErrorType:(TTGCPlatformErrorType)errorType userInfo:(id)userInfo;

@end


NS_ASSUME_NONNULL_END
