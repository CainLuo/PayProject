//
//  AliPayOther.m
//  AliPay-Objective-C
//
//  Created by Cain on 16/9/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "AliPayOther.h"

@implementation AliPayOther

- (NSString *)orderInfoEncoded:(BOOL)bEncoded {
    
    if (_app_id.length <= 0) {
        return nil;
    }
    
    // NOTE: 增加不变部分数据
    NSMutableDictionary *tmpDict = [NSMutableDictionary new];
    
    [tmpDict addEntriesFromDictionary:@{@"app_id" : _app_id,
                                        @"method" : _method ? : @"alipay.trade.app.pay",
                                        @"charset" : _charset ? : @"utf-8",
                                        @"timestamp" : _timestamp ? : @"",
                                        @"version" : _version ? : @"1.0",
                                        @"biz_content" : _biz_content.description ? : @"",
                                        @"sign_type" : _sign_type ? : @"RSA"}];
    
    
    // NOTE: 增加可变部分数据
    if (_format.length > 0) {
        
        [tmpDict setObject:_format
                    forKey:@"format"];
    }
    
    if (_return_url.length > 0) {
        
        [tmpDict setObject:_return_url
                    forKey:@"return_url"];
    }
    
    if (_notify_url.length > 0) {
        
        [tmpDict setObject:_notify_url
                    forKey:@"notify_url"];
    }
    
    if (_app_auth_token.length > 0) {
        
        [tmpDict setObject:_app_auth_token
                    forKey:@"app_auth_token"];
    }
    
    // NOTE: 排序，得出最终请求字串
    NSArray *sortedKeyArray = [[tmpDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    
    for (NSString *key in sortedKeyArray) {
        
        NSString *orderItem = [self orderItemWithKey:key
                                            andValue:[tmpDict objectForKey:key]
                                             encoded:bEncoded];
        
        if (orderItem.length > 0) {
            
            [tmpArray addObject:orderItem];
        }
    }
    
    return [tmpArray componentsJoinedByString:@"&"];
}

- (NSString*)orderItemWithKey:(NSString *)key
                     andValue:(NSString *)value
                      encoded:(BOOL)bEncoded {
    
    if (key.length > 0 && value.length > 0) {
        
        if (bEncoded) {
            value = [self encodeValue:value];
        }
        
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
    
    return nil;
}

- (NSString *)encodeValue:(NSString *)value {
    
    NSString *encodedValue = value;
    
    if (value.length > 0) {
        
        encodedValue = (__bridge_transfer  NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (__bridge CFStringRef)value,
                                                                                             NULL,
                                                                                             (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                             kCFStringEncodingUTF8);
    }
    
    return encodedValue;
}

@end
