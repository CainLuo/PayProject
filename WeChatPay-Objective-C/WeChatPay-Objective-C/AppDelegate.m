//
//  AppDelegate.m
//  WeChatPay-Objective-C
//
//  Created by Cain on 11/9/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Description就按照你自己的来写吧
    [WXApi registerApp:@"wxb4ba3c02aa476ea1"
       withDescription:@"WeChatPay"];
    
    return YES;
}

- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[PayResp class]]) {
        
        NSString *stringMessage = @"支付结果";
        NSString *stringTitle  = @"支付结果";
        
        switch (resp.errCode) {
            case WXSuccess:
                
                stringMessage = @"支付结果: 成功!";
                
                NSLog(@"支付成功 - PaySuccess, retCode = %d", resp.errCode);
                
                break;
            default:
                
                stringMessage = [NSString stringWithFormat:@"支付结果: 失败!, retcode = %d, retstr = %@", resp.errCode, resp.errStr];
                
                break;
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:stringTitle
                                                            message:stringMessage
                                                           delegate:nil
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil, nil];
        
        [alertView show];
    }
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url {
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    return [WXApi handleOpenURL:url delegate:self];
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
