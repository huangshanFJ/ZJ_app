//
//  MyOrderFooterView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderFooterView : UIView
@property (nonatomic,strong)UILabel *needPriceLabel;//需付款
@property (nonatomic,strong)UILabel *totalNumberLabel;//商品
@property (nonatomic,strong)UIButton *rightButton;
@property (nonatomic,strong)UIButton *leftButton;

/*
 *  （右边按钮）的回调
 */
@property (nonatomic,copy) dispatch_block_t rightButtonClickBlock;


/*
 *   （左边按钮）的回调
 */
@property (nonatomic,copy) dispatch_block_t leftButtonClickBlock;

@end
