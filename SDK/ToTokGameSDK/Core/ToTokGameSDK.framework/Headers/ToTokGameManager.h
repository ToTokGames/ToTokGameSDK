//
//  ToTokGameManager.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/1/21.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTGCConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToTokGameManager : NSObject

+ (instancetype)defaultManager;

/**
初始化
*/
- (void)setupWithAppId:(NSString *)appid Secret:(NSString *)secret GameId:(NSString *)gameid Application:(UIApplication *)application Options:(NSDictionary *)launchOptions AnimationHandle:(TTGCLaunchCompletion)handle;

- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

#pragma mark - 登录

/**
登录用户类型
*/
- (TTGCLoginType)loginType;

/**
ToTok登录
 
@param completion 登录操作回调
*/
- (void)loginWithToTokCompletion:(TTGCUserCompletionHandler)completion;

/**
Gamecenter登录
 
@param completion 登录操作回调
*/
- (void)loginWithGameCenterCompletion:(TTGCUserCompletionHandler)completion;

/**
Facebook登录
 
@param completion 登录操作回调
*/
- (void)loginWithFacebookCompletion:(TTGCUserCompletionHandler)completion;


/**
三方应用 授权回调（必须在AppDelegate中实现）
*/
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

/**
游客登录
 
@param completion 登录操作回调
*/
- (void)guestLoginCompletion:(TTGCUserCompletionHandler)completion;

/**
拉取用户信息
 
@param completion 用户信息回调
*/
- (void)userInfoCompletion:(TTGCUserCompletionHandler)completion;

/**
登出
 
@param completion 用户登出结果回调
*/
- (void)logout:(TTGCLogoutCompleteHandler)completion;

#pragma mark - 分享

/**
 *  FB分享
 *
 *  @param messageObject  share content type @see TTGCSocialFBLink TTGCSocialFBImages
 *  @param completion   回调
 */
- (void)facebookShareMessage:(id)messageObject completion:(TTGCShareCompleteHandler)completion;

/**
 *  WhatsApp分享
 *
 *  @param messageObject  share content type @see TTGCSocialWALink TTGCSocialWAImages
 *  @param completion   回调
 */
- (void)whatsAppShareMessage:(id)messageObject completion:(TTGCShareCompleteHandler)completion;

/**
 *  调用系统相册
 *
 *  @param completion   回调
 *  回调数据 @TTGCSocialSystemPhotoCompletionHandler
 */
- (void)openSystemPhotoCompletion:(TTGCSocialSystemPhotoCompletionHandler)completion;


#pragma mark - 推送相关

/**
接收deviceToken（必须在AppDelegate中实现）
 
@param token 苹果返回的token值
*/
- (void)registerDeviceToken:(NSData *)token;

/**
移除所有通知
*/
- (void)cleanNotification;

/**
接收远程通知
*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

/**
获取远程通知信息
*/
- (void)getRemoteNotification:(TTGCNotificationCompletionHandler)completion;

/**
设置用户是否接收推送

@param pushOn YES:打开push NO:关闭push
@param handler 返回设置结果 YES:设置成功 NO:设置失败
*/
- (void)settingPush:(BOOL)pushOn Result:(void(^)(BOOL success))handler;

/**
判断用户系统推送是否打开
 
@param handler 返回系统推送是否打开 返回值布尔类型 YES:打开了通知 NO:关闭了通知
*/
- (void)checkSystemNotificationEnable:(void(^)(BOOL isOn))handler;

/**
打开系统通知设置
*/
- (void)systemNotificationSetting;

#pragma mark - ToTok消息

/**
从服务端拉取好友列表
 
@param completion 好友列表回调
*/
- (void)getFriendsFromServerCompletion:(TTGCToTokFriendsCompletionHandler)completion;

/**
从本地读取好友列表（服务端获取之后才会有本地数据）
 
@param completion 好友列表回调
*/
- (void)getFriendsCompletion:(TTGCToTokFriendsCompletionHandler)completion;


#pragma mark - 支付

/**
购买商品
 
@param sku 商品ID
@param progress 购买过程回调
@param completion 购买完成回调
*/
- (void)buyProductWithSKU:(NSString *)sku Progress:(TTGCOrderProgressHandler)progress Completion:(TTGCOrderCompletionHandler)completion;

/**
查询订单
 
@param orderID 订单id
@param completion 查询结果 回调返回订单信息
*/
- (void)queryOrderWithOrderId:(NSString *)orderID Completion:(TTGCOrderCompletionHandler)completion;

#pragma mark - 配置信息

/**
获取用户协议url
*/
- (NSString *)getAgreementUrlString;

/**
获取隐私协议url
*/
- (NSString *)getPrivacyUrlString;

/**
获取主页url
*/
- (NSString *)getHomepageUrlString;


#pragma mark - SDK 配置

#pragma - 配置域名
/**
 切换 SDK server 环境
*/
- (void)setServerDomainTest;//测试环境
- (void)setServerDomainProduction;//生产环境

/**
 获取当前 SDK server 域名前缀
*/
- (NSString *)SDKServerDomain;

#pragma - log信息
/**
 log信息输出 开启 关闭
*/
- (void)openLogInfo;
- (void)closeLogInfo;

#pragma - 支付环境
/**
 切换 支付环境
*/
- (void)setPayEnvironmentTest;//测试环境
- (void)setPayEnvironmentProduction;//生产环境

@end

NS_ASSUME_NONNULL_END
