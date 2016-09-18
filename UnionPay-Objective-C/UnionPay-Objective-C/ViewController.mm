//
//  ViewController.m
//  UnionPay-Objective-C
//
//  Created by Cain on 17/9/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ViewController.h"
#import "UPPaymentControl.h"

@interface ViewController () <UIAlertViewDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)unionPay:(UIButton *)sender {
    
    [self startNetWithURL:[NSURL URLWithString:@"http://101.231.204.84:8091/sim/getacptn"]];
}

- (void)startNetWithURL:(NSURL *)url {
    
    [self showAlertWait];
    
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:url];
    
    NSURLConnection *urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest
                                                               delegate:self];
    
    [urlConn start];
}

- (void)showAlertWait {
    
    [self hideAlert];
    
    _alertView = [[UIAlertView alloc] initWithTitle:@"正在获取TN,请稍后..."
                                           message:@""
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:nil, nil];
    [_alertView show];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    activityIndicatorView.center = CGPointMake(_alertView.frame.size.width / 2.0f - 15,
                                               _alertView.frame.size.height / 2.0f + 10);
    
    [activityIndicatorView startAnimating];
    
    [_alertView addSubview:activityIndicatorView];
}

- (void)hideAlert {
    
    if (_alertView != nil) {
        
        [_alertView dismissWithClickedButtonIndex:0
                                         animated:NO];
        
        _alertView = nil;
    }
}

- (void)showAlertMessage:(NSString *)message {
    
    [self hideAlert];
    
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                            message:message
                                           delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil, nil];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    _alertView = nil;
}

#pragma mark - connection
- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
    
    NSHTTPURLResponse *rsp = (NSHTTPURLResponse*)response;
    
    NSInteger code = [rsp statusCode];
    
    NSLog(@"Code: %zd", code);
    
    if (code != 200) {
        
        [self showAlertMessage:@"网络错误"];
        [connection cancel];
        
    } else {
        
        _responseData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [self hideAlert];
    
    NSString *tn = [[NSMutableString alloc] initWithData:_responseData
                                                encoding:NSUTF8StringEncoding];
    
    if (tn != nil && tn.length > 0) {
        
        NSLog(@"TN: %@",tn);
        
        [[UPPaymentControl defaultControl] startPay:tn
                                         fromScheme:@"UnionPay-Objective-C"
                                               mode:@"01"
                                     viewController:self];
    }
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error {
    
    [self showAlertMessage:@"网络错误"];
}

@end
