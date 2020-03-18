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
- (void)setupWithAppId:(NSString *)appid Secret:(NSString *)secret Application:(UIApplication *)application Options:(NSDictionary *)launchOptions AnimationHandle:(TTGCLaunchCompletion)handle;

#pragma mark - 登录

/**
登录状态
YES：表示已经登录
 NO：没有登录
*/
- (BOOL)isLogin;

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
 分享到ToTok方法 固定模板link类型内容

 @param ttkUid 分享到好友的totok 用户id或者群组id
 @param templateId 消息模板id
 @param img 消息icon
 @param title 标题
 @param des 描述
 @param buttonTitle 点击动作名称
 @param link 消息链接
 @param completion 分享回调
 */
- (void)shareTottkUid:(NSString *)ttkUid
           TemplateId:(NSString *)templateId
                Image:(NSString *)img
                Title:(NSString *)title
          Description:(NSString *)des
          ButtonTitle:(NSString *)buttonTitle
                 Link:(NSString *)link
           Completion:(TTGCShareCompleteHandler)completion;

/**
 *  三方平台分享
 *
 *  @param messageObject  分享的content @see TTGCSocialMessageObject
 *  @param completion   回调
 */
- (void)shareMessageObject:(TTGCSocialMessageObject *)messageObject completion:(TTGCShareCompleteHandler)completion;

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
- (void)SystemNotificationSetting;

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

/**
 指定ToTok好友发送模板消息

 @param ttkUid 分享到好友的totok 用户id或者群组id
 @param templateId 消息模板id
 @param imgUrl 图片url
 @param title 标题
 @param des 描述
 @param buttonTitle 点击动作名称
 @param link 消息链接
 @param completion 分享回调
 */
- (void)sendToTokMessageTottkUid:(NSString *)ttkUid
                      TemplateId:(NSString *)templateId
                        ImageUrl:(NSString *)imgUrl
                           Title:(NSString *)title
                     Description:(NSString *)des
                     ButtonTitle:(NSString *)buttonTitle
                            Link:(NSString *)link
                      Completion:(TTGCShareCompleteHandler)completion;

#pragma mark - 支付

/**
购买商品
 
@param sku 商品ID
@param progress 购买过程回调
@param completion 购买完成回调
*/
- (void)buyProductWithSKU:(NSString *)sku Progress:(TTGCOrderProgressHandler)progress Completion:(TTGCOrderCompletionHandler)completion;

#pragma mark - 配置信息
- (void)loadConfig:(TTGCCompletionHandler _Nullable)handler;
- (void)openAgreement;
- (void)openPrivacy;
- (void)openHomepage;

#pragma mark - Universal Link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler;

/**
获取UniversalLink
 
@param handler 回调 URL
*/
- (void)handleUniversalLink:(TTGCUniversalLinkHandler)handler;

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
