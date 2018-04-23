//
//  InformationCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationCell : UITableViewCell

@property (nonatomic,strong)UILabel *kindName;
@property (nonatomic,strong)UILabel *informationLabel;
@property (nonatomic,strong)UITextField *infoTextField;
@property (nonatomic,strong)UIButton *getCodeButton;
@property (nonatomic,strong)UIImageView *nextImage;


@end
