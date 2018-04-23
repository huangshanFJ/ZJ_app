//
//  RecordCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel *kindNameLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *priceLabel;

@end
