//
//  WebTableViewCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebTableViewCell : UITableViewCell<UIWebViewDelegate>

@property (nonatomic,strong) NSString *contentStr;
@property (nonatomic,assign) CGFloat height;
@property (strong, nonatomic) UIWebView *webView;
@end
