//
//  AliPayBizContent.m
//  AliPay-Objective-C
//
//  Created by Cain on 16/9/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "AliPayBizContent.h"

@implementation AliPayBizContent

- (NSString *)description {
    
    NSMutableDictionary *tmpDict = [NSMutableDictionary new];
    
    // NOTE: 增加不变部分数据
    [tmpDict addEntriesFromDictionary:@{@"subject" : _subject ? : @"",
                                        @"out_trade_no" : _out_trade_no ? : @"",
                                        @"total_amount" : _total_amount ? : @"",
                                        @"seller_id" : _seller_id ? : @"",
                                        @"product_code" : _product_code ? : @"QUICK_MSECURITY_PAY"}];
    
    // NOTE: 增加可变部分数据
    if (_body.length > 0) {
        [tmpDict setObject:_body
                    forKey:@"body"];
    }
    
    if (_timeout_express.length > 0) {
        [tmpDict setObject:_timeout_express
                    forKey:@"timeout_express"];
    }
    
    // NOTE: 转变得到json string
    NSData *tmpData = [NSJSONSerialization dataWithJSONObject:tmpDict
                                                      options:0
                                                        error:nil];
    NSString *tmpStr = [[NSString alloc]initWithData:tmpData
                                            encoding:NSUTF8StringEncoding];
    
    return tmpStr;
}

@end
