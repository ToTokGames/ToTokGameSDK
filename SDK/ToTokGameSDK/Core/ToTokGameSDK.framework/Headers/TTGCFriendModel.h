//
//  TTGCFriendModel.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/16.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTGCFriendModel : NSObject

@property (nonatomic, copy) NSString *ttkUid; //totok 用户id，或者群组id，802开头为群组
@property (nonatomic, copy) NSString *totokId; //totokID
@property (nonatomic, copy) NSString *name; //昵称
@property (nonatomic, copy) NSString *photoUrl; //头像

@end

NS_ASSUME_NONNULL_END
