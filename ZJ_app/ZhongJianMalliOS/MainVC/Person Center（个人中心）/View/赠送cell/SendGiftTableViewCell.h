//
//  SendGiftTableViewCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendGiftTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *levLabel;
@property (nonatomic,strong)UILabel *sendLabel;
@property (nonatomic,strong)UIButton *sendButton;


/*
 * 赠送的回调
 */
@property (nonatomic,copy) dispatch_block_t sendGiftButtonClickBlock;

@end
