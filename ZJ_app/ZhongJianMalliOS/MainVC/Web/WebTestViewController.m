//
//  WebTestViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WebTestViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "DirectUpgradesViewController.h"
@interface WebTestViewController ()<UIWebViewDelegate> {
    UIWebView *webView;
}


//@property (nonatomic,strong)u
@end

@implementation WebTestViewController
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    webView = [[UIWebView alloc] initWithFrame:self.view.frame];
  
    NSString *url = _requestString;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    webView.delegate = self;
    
    [self.view addSubview: webView];
    
    [webView loadRequest:request];
    
 
    
}
#pragma mark - UIWebViewDelegate
- (void)key  {
//    NSString *info = [NSString stringWithFormat:@"你好 %@, 很高兴见到你",key];
//    NSLog(@"%@",info);
    NSLog(@"11111");

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"===%@",NSStringFromSelector(_cmd));

    //OC调用JS是基于协议拦截实现的 下面是相关操作
    NSString *absolutePath = request.URL.absoluteString;

    NSString *scheme = @"myscheme://";

    if ([absolutePath hasPrefix:scheme]) {
        NSString *subPath = [absolutePath substringFromIndex:scheme.length];

        if ([subPath containsString:@"?"]) {//1个或多个参数

            if ([subPath containsString:@"&"]) {//多个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];

                NSString *methodName = [components firstObject];

                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);

                NSString *parameter = [components lastObject];
                NSArray *params = [parameter componentsSeparatedByString:@"&"];

                if (params.count == 2) {
                    if ([self respondsToSelector:sel]) {
                        [self performSelector:sel withObject:[params firstObject] withObject:[params lastObject]];
                    }
                }


            } else {//1个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];

                NSString *methodName = [components lastObject];
//                methodName = [methodName stringByReplacingOccurrencesOfString:@"=" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);

                NSString *parameter = [components lastObject];

//                if ([self respondsToSelector:sel]) {
//                    [self performSelector:sel withObject:parameter];
//                }
                if ([parameter stringByAppendingString:@"key=mykey"]) {
                    [self pushNext];
                }
            }

        } else {//没有参数
            NSString *methodName = [subPath stringByReplacingOccurrencesOfString:@"_" withString:@":"];
            SEL sel = NSSelectorFromString(methodName);

            if ([self respondsToSelector:sel]) {
                [self performSelector:sel];
            }
        }
    }

    return YES;
}
#pragma mark - JS调用OC方法列表
- (void)pushNext {

    NSLog(@"1111");
    [self.navigationController pushViewController:[DirectUpgradesViewController new] animated:YES];
    

}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"----%@",NSStringFromSelector(_cmd));
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"-=-=%@",NSStringFromSelector(_cmd));
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
