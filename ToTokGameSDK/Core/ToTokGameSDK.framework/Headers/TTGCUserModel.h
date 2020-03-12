//
//  TTGCUserModel.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/16.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户类型
 */
typedef NS_ENUM(NSInteger, TTGCUserType) {
    TTGCUserType_ToTok            = 1,             // ToTok用户
    TTGCUserType_GameCenter       = 2,             // GameCenter用户
    TTGCUserType_Facebook         = 3,             // Facebook用户
    TTGCUserType_Guest            = 4,             // 游客
};

NS_ASSUME_NONNULL_BEGIN

@interface TTGCUserModel : NSObject

@property (nonatomic) TTGCUserType userType; //用户类型
@property (nonatomic, copy) NSString *userId; //游戏中心用户id
@property (nonatomic, copy) NSString *nickname; //昵称
@property (nonatomic, copy) NSString *photoUrl; //头像
@property (nonatomic, copy) NSString *pushOff; //push开关,0:push打开，1:push关闭


@end

NS_ASSUME_NONNULL_END
