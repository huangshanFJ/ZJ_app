//
//  OrderNumberCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNumberCell : UITableViewCell

@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *costClassLabel;
/*
 * 增加的回调
 */
@property (nonatomic,copy) dispatch_block_t addButtonClickBlock;
/*
 * 减少的回调
 */
@property (nonatomic,copy) dispatch_block_t deleteButtonClickBlock;

@end
