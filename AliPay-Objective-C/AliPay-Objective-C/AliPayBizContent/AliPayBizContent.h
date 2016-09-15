//
//  AliPayBizContent.h
//  AliPay-Objective-C
//
//  Created by Cain on 16/9/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AliPayBizContent : NSObject

// NOTE: (非必填项)商品描述
@property (nonatomic, copy) NSString *body;

// NOTE: 商品的标题/交易标题/订单标题/订单关键字等。
@property (nonatomic, copy) NSString *subject;

// NOTE: 商户网站唯一订单号
@property (nonatomic, copy) NSString *out_trade_no;

// NOTE: 该笔订单允许的最晚付款时间，逾期将关闭交易。
//       取值范围：1m～15d m-分钟，h-小时，d-天，1c-当天(1c-当天的情况下，无论交易何时创建，都在0点关闭)
//       该参数数值不接受小数点， 如1.5h，可转换为90m。
@property (nonatomic, copy) NSString *timeout_express;

// NOTE: 订单总金额，单位为元，精确到小数点后两位，取值范围[0.01,100000000]
@property (nonatomic, copy) NSString *total_amount;

// NOTE: 收款支付宝用户ID。 如果该值为空，则默认为商户签约账号对应的支付宝用户ID (如 2088102147948060)
@property (nonatomic, copy) NSString *seller_id;

// NOTE: 销售产品码，商家和支付宝签约的产品码 (如 QUICK_MSECURITY_PAY)
@property (nonatomic, copy) NSString *product_code;

@end
