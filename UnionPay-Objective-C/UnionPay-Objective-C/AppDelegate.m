//
//  AppDelegate.m
//  UnionPay-Objective-C
//
//  Created by Cain on 17/9/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "AppDelegate.h"
#import "UPPaymentControl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    [[UPPaymentControl defaultControl] handlePaymentResult:url
                                             completeBlock:^(NSString *code, NSDictionary *data) {
        
                                                 //结果code为成功时，先校验签名，校验成功后做后续处理
                                                 if([code isEqualToString:@"success"]) {
            
                                                     //判断签名数据是否存在
                                                     if(data == nil){
                                                         //如果没有签名数据，建议商户app后台查询交易结果
                                                         return;
                                                     }
            
                                                     //数据从NSDictionary转换为NSString
                                                     NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                                                        options:0
                                                                                                          error:nil];
                                                     NSString *sign = [[NSString alloc] initWithData:signData
                                                                                            encoding:NSUTF8StringEncoding];
            
                                                     NSLog(@"Sign: %@", sign);
            
                                                     //验签证书同后台验签证书
                                                     //此处的verify，商户需送去商户后台做验签
                                                     //支付成功且验签成功，展示支付成功提示
                                                     //验签失败，交易结果数据被篡改，商户app后台查询交易结果
                                                     
                                                 } else if([code isEqualToString:@"fail"]) {
                                                     //交易失败
                                                 } else if([code isEqualToString:@"cancel"]) {
                                                     //交易取消
                                                 }
                                             }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
