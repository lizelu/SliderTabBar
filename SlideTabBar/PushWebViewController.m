//
//  PushWebViewController.m
//  SlideTabBar
//
//  Created by Mr.LuDashi on 15/6/26.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "PushWebViewController.h"

@interface PushWebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PushWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    if (_url != nil) {
        NSURL *url = [NSURL URLWithString:_url];;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        self.webView.delegate=self;
        [self.webView loadRequest:request];
    }
    
}
- (IBAction)tapCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeBlack];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[SVProgressHUD showSuccessWithStatus:@"加载成功"];
    //[SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[ViewControllerTools showAlterViewWithString: @"加载失败,请稍后再试"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
