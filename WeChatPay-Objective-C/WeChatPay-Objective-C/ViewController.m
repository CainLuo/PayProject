//
//  ViewController.m
//  WeChatPay-Objective-C
//
//  Created by Cain on 11/9/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)weChatPay:(UIButton *)sender {
    
    NSString *urlString = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               
                               if (data != nil) {
                                   
                                   NSError *error;
                                   NSMutableDictionary *dictionart = NULL;
                                   
                                   dictionart = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:NSJSONReadingMutableLeaves
                                                                            error:&error];
                                   
                                   NSLog(@"URL: %@", urlString);
                                   
                                   if (dictionart != nil) {
                                       
                                       NSMutableString *retCode = [dictionart objectForKey:@"retcode"];
                                       
                                       if (retCode.integerValue == 0) {
                                           
                                           NSMutableString *stamp = [dictionart objectForKey:@"timestamp"];
                                           
                                           // 调起微信支付
                                           PayReq *req   = [[PayReq alloc] init];
                                           req.partnerId = [dictionart objectForKey:@"partnerid"];
                                           req.prepayId  = [dictionart objectForKey:@"prepayid"];
                                           req.nonceStr  = [dictionart objectForKey:@"noncestr"];
                                           req.timeStamp = stamp.intValue;
                                           req.package   = [dictionart objectForKey:@"package"];
                                           req.sign      = [dictionart objectForKey:@"sign"];
                                           
                                           [WXApi sendReq:req];
                                           
                                           // 日志输出
                                           NSLog(@"appid = %@", [dictionart objectForKey:@"appid"]);
                                           NSLog(@"partnerId = %@", req.partnerId);
                                           NSLog(@"prepayId = %@", req.prepayId);
                                           NSLog(@"nonceStr = %@", req.nonceStr);
                                           NSLog(@"timeStamp = %d", req.timeStamp);
                                           NSLog(@"package = %@", req.package);
                                           NSLog(@"sign = %@", req.sign);
                                           
                                       } else {
                                           
                                           NSLog(@"retmsg: %@", [dictionart objectForKey:@"retmsg"]);
                                       }
                                   } else {
                                       
                                       NSLog(@"服务器返回错误, 未获取到JSON对象");
                                   }
                               } else {
                                   
                                   NSLog(@"服务器返回错误");
                               }
                           }];
}

@end
