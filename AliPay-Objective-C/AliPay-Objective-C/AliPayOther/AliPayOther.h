//
//  AliPayOther.h
//  AliPay-Objective-C
//
//  Created by Cain on 16/9/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AliPayBizContent.h"

@interface AliPayOther : NSObject

// NOTE: 支付宝分配给开发者的应用ID(如2014072300007148)
@property (nonatomic, copy) NSString *app_id;

// NOTE: 支付接口名称
@property (nonatomic, copy) NSString *method;

// NOTE: (非必填项)仅支持JSON
@property (nonatomic, copy) NSString *format;

// NOTE: (非必填项)HTTP/HTTPS开头字符串
@property (nonatomic, copy) NSString *return_url;

// NOTE: 参数编码格式，如utf-8,gbk,gb2312等
@property (nonatomic, copy) NSString *charset;

// NOTE: 请求发送的时间，格式"yyyy-MM-dd HH:mm:ss"
@property (nonatomic, copy) NSString *timestamp;

// NOTE: 请求调用的接口版本，固定为：1.0
@property (nonatomic, copy) NSString *version;

// NOTE: (非必填项)支付宝服务器主动通知商户服务器里指定的页面http路径
@property (nonatomic, copy) NSString *notify_url;

// NOTE: (非必填项)商户授权令牌，通过该令牌来帮助商户发起请求，完成业务(如201510BBaabdb44d8fd04607abf8d5931ec75D84)
@property (nonatomic, copy) NSString *app_auth_token;

// NOTE: 具体业务请求数据
@property (nonatomic, strong) AliPayBizContent *biz_content;

// NOTE: 签名类型
@property (nonatomic, copy) NSString *sign_type;


/**
 *  获取订单信息串
 *
 *  @param bEncoded       订单信息串中的各个value是否encode
 *                        非encode订单信息串，用于生成签名
 *                        encode订单信息串 + 签名，用于最终的支付请求订单信息串
 */
- (NSString *)orderInfoEncoded:(BOOL)bEncoded;

@end
