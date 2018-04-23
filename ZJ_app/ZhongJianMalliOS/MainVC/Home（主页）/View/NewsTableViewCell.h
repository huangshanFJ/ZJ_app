//
//  NewsTableViewCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UIImageView *redHeadImage;
@property (nonatomic,strong) UILabel *headLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *timerLabel;

@end
