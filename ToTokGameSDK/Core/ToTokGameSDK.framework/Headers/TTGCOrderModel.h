//
//  TTGCOrderModel.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/16.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTGCOrderModel : NSObject


@property (nonatomic, copy) NSString *orderId; //订单id
@property (nonatomic, copy) NSString *orderRef; //支付订单第三方订单id

@property (nonatomic, copy) NSString *channel; //支付渠道
@property (nonatomic, copy) NSString *env; //支付环境
@property (nonatomic, copy) NSString *sku; //商品代码
@property (nonatomic, copy) NSString *amount; //金额

@property (nonatomic, copy) NSString *createTime; //创建时间
@property (nonatomic, copy) NSString *payTime; //支付时间
@property (nonatomic, copy) NSString *cancelTime; //取消时间

@property (nonatomic, copy) NSString *status; //支付状态


@end

NS_ASSUME_NONNULL_END
