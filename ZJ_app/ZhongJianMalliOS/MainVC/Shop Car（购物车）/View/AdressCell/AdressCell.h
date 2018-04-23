//
//  AdressCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdressCell : UITableViewCell

@property (nonatomic,strong)UILabel *adreeNameLabel;//名字
@property (nonatomic,strong)UILabel *detailAdressLabel;//详细地址
@property (nonatomic,strong)UILabel *adreePhoneLabel;//电话
@property (nonatomic,strong)UIButton *selectedButton;//选中
@property (nonatomic,strong)UIButton *deleteButton;//删除
@property (nonatomic,strong)UIImageView *selectedImage;//
@property (nonatomic,strong)UILabel *selectedAdress;//

/*
 * 选中未选中的回调
 */
@property (nonatomic,copy) dispatch_block_t selectedButtonButtonBlock;
/*
 * 删除的回调
 */
@property (nonatomic,copy) dispatch_block_t deleteButtionButtonClick;


@end
