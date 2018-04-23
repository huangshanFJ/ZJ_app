//
//  RecordProfitTableViewCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordProfitTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headIconImage;//头像
@property (nonatomic,strong)UILabel *kindNameLabel;//币种
@property (nonatomic,strong)UILabel *timeLabel;//时间
@property (nonatomic,strong)UILabel *fansKindLabel;//粉丝类型
@property (nonatomic,strong)UILabel *fansMoneyLabel;//分润

@end
