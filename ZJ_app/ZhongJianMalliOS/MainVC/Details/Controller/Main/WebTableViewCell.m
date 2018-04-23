//
//  WebTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WebTableViewCell.h"

@implementation WebTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSLog(@"%@",NSStringFromCGRect(self.contentView.bounds));
        
        // 高度必须提前赋一个值 >0
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.userInteractionEnabled = NO;
        self.webView.scrollView.bounces = NO;
        self.webView.delegate = self;
        self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
        self.webView.scalesPageToFit = YES;
        [self.contentView addSubview:self.webView];
    }
    return self;
}

// contentStr 用于更新值
-(void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:contentStr]]];
//    [self.webView loadHTMLString:contentStr baseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 如果要获取web高度必须在网页加载完成之后获取
    
    // 方法一
    CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
    
    // 方法二
    //    CGSize fittingSize = webView.scrollView.contentSize;
    NSLog(@"webView:%@",NSStringFromCGSize(fittingSize));
    
    self.height = fittingSize.height;
    NSLog(@"-------------%f",webView.frame.size.height);
    self.webView.frame = CGRectMake(0, 0, fittingSize.width, fittingSize.height);
    
    // 用通知发送加载完成后的高度
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WEBVIEW_HEIGHT" object:self userInfo:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
