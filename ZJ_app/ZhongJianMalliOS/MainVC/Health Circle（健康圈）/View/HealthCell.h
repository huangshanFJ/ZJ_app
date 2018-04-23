//
//  HealthCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel *headTitleLabel;
@property (nonatomic,strong)UILabel *detailTitleLabel;
@property (nonatomic,strong)UILabel *kindNameLabel;

@end
