//
//  MyOrderViewCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImage;//头像
@property (nonatomic,strong)UILabel *orderNameLabel;//姓名
@property (nonatomic,strong)UILabel *orderPriceLabel;//价格
@property (nonatomic,strong)UILabel *orderNumberLabel;//数量



///*
// *  立即支付（右边按钮）的回调
// */
//@property (nonatomic,copy) dispatch_block_t payButtonButtonBlock;
//
//
///*
// *  取消订单（左边按钮）的回调
// */
//@property (nonatomic,copy) dispatch_block_t cancelButtonButtonBlock;

@end
