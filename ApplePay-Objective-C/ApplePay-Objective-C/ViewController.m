//
//  ViewController.m
//  ApplePay-Objective-C
//
//  Created by Cain on 2016/9/26.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController () <PKPaymentAuthorizationViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)applePayAction:(UIButton *)sender {
    
    if ([PKPaymentAuthorizationViewController canMakePayments]) {
        
        NSLog(@"开始Apple Pay");

        PKPaymentRequest *request = [[PKPaymentRequest alloc] init];
        
        PKPaymentSummaryItem *widgetOne = [PKPaymentSummaryItem summaryItemWithLabel:@"widget1"
                                                                              amount:[NSDecimalNumber decimalNumberWithString:@"0.93"]];
        
        PKPaymentSummaryItem *widgetTwo = [PKPaymentSummaryItem summaryItemWithLabel:@"widget2"
                                                                              amount:[NSDecimalNumber decimalNumberWithString:@"1.00"]];

        PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:@"COMPANY NAME"
                                                                              amount:[NSDecimalNumber decimalNumberWithString:@"1.93"]];

        request.paymentSummaryItems = @[widgetOne, widgetTwo, total];
        request.countryCode = @"US"; // 国家代码
        request.currencyCode = @"USD"; // 货币代码
        request.supportedNetworks = @[PKPaymentNetworkAmex,
                                      PKPaymentNetworkChinaUnionPay,
                                      PKPaymentNetworkDiscover,
                                      PKPaymentNetworkInterac,
                                      PKPaymentNetworkMasterCard,
                                      PKPaymentNetworkPrivateLabel,
                                      PKPaymentNetworkVisa];
        
        request.merchantIdentifier = @"merchant.com.pay.applepay.demo";
        request.merchantCapabilities = PKMerchantCapabilityEMV;
        request.requiredBillingAddressFields = PKAddressFieldEmail | PKAddressFieldPostalAddress;
        
        PKPaymentAuthorizationViewController *paymentAuthorizationController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
        
        paymentAuthorizationController.delegate = self;
        
        [self presentViewController:paymentAuthorizationController animated:YES completion:nil];
    } else {
        
        NSLog(@"不支持Apple Pay");
    }
}

// PKPaymentAuthorization View Controller Delegate
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus))completion {
    
    NSLog(@"Payment was authorized: %@", payment);
    
    NSLog(@"%@", payment.token);
    
    BOOL asyncSuccessful = NO;
    
    if (asyncSuccessful) {
        completion(PKPaymentAuthorizationStatusSuccess);
        
        NSLog(@"Apple Pay支付成功");
    } else {
        
        completion(PKPaymentAuthorizationStatusFailure);
        
        NSLog(@"Apple Pay支付失败");
    }
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    
    NSLog(@"paymentAuthorizationViewControllerDidFinish");
    
    [controller dismissViewControllerAnimated:YES
                                   completion:nil];
}

@end
