//
//  CommercialCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommercialCell : UITableViewCell

@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *headTitleLabel;
@property (nonatomic,strong)UILabel *isOnLineLabel;
@property (nonatomic,strong)UILabel *detailTitleLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *numberPeopleLabel;

@end
