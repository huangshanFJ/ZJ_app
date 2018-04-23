//
//  RuleWebViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RuleWebViewController.h"

@interface RuleWebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation RuleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
}

-(instancetype)initWithUrlString:(NSString *)urlStr
{
    if (self = [super init]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
}
    return self;
}
//lazy
-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64)];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 100;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    title.text = @"交易规则";
    title.textAlignment = 1;
    title.textColor = [UIColor colorWithHexString:@"444444"];
    title.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
    
    
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
