//
//  ShopDetailHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShopDetailHeadView.h"

@implementation ShopDetailHeadView

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//
//    }
//    return self;
//}
-(void)setProductId:(NSString *)productId
{
    _productId = productId;
    [self creatHeadView];
}
- (void)creatHeadView {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *shopDetailLabel = [[UILabel alloc] init];
    shopDetailLabel.text = @"商品详情";
    shopDetailLabel.textColor = [UIColor colorWithHexString:@"444444"];
    shopDetailLabel.font = [UIFont systemFontOfSize:13];
    shopDetailLabel.textAlignment = 1;
    [self addSubview:shopDetailLabel];
    [shopDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(80);
        make.height.mas_offset(40);
        make.top.mas_offset(0);
    }];
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2"]];
    [self addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(shopDetailLabel.mas_left).offset(0);
        make.top.mas_offset(16);
        make.height.mas_offset(8);
        make.width.mas_offset(25);
    }];
    UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1"]];
    [self addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopDetailLabel.mas_right).offset(0);
        make.top.mas_offset(16);
        make.width.mas_offset(25);
        make.height.mas_offset(8);
    }];
    UIWebView *webview = [[UIWebView alloc] init];
    webview.delegate = self;
    NSString *str = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/productdetails.html?productId=%@",self.productId];
    NSLog(@"self.product=%@",self.productId);
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    CGFloat webViewHeight = [[webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webview.frame = CGRectMake(0, 40, KWIDTH, webViewHeight);
//    webview.scrollView.scrollEnabled = NO;
    NSLog(@"webviewheight=%f",webViewHeight);
    [self addSubview:webview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
