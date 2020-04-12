//
//  AppDelegate.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/1/22.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "AppDelegate.h"
#import <ToTokGameSDK/ToTokGameSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
    

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // set SDK Api Enviroment
    [[ToTokGameManager defaultManager] setServerDomainTest];
    // open log
    [[ToTokGameManager defaultManager] openLogInfo];
    
    // launch SDK
    NSString *appId = @"LTAIe4EmdMyxioiR";
    NSString *appSecret = @"d96b2c8baa2a1bf6671ad29cfd3fb566";
    NSString *gameid = @"126847495400849409";
    [[ToTokGameManager defaultManager] setupWithAppId:appId Secret:appSecret GameId:gameid Application:application Options:launchOptions AnimationHandle:^(BOOL isFinish) {
        //启动动画完成 可以这里添加启动自己的页面
        
    }];
                
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[ToTokGameManager defaultManager] application:app openURL:url options:options];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[ToTokGameManager defaultManager] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[ToTokGameManager defaultManager] application:application didReceiveRemoteNotification:userInfo];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[ToTokGameManager defaultManager] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[ToTokGameManager defaultManager] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[ToTokGameManager defaultManager] applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[ToTokGameManager defaultManager] applicationWillTerminate:application];
}

#pragma mark Universal Link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [[ToTokGameManager defaultManager] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}


@end
