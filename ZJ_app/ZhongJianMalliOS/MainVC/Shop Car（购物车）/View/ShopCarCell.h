//
//  ShopCarCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarCell : UITableViewCell<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,strong)UIImageView *shopImageView;
@property (nonatomic,strong)UILabel *shopNameLabel;
@property (nonatomic,strong)UILabel *shopNormsLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *numberLabel;

/*
 * 选中未选中的回调
 */
@property (nonatomic,copy) dispatch_block_t selectedButtonButtonBlock;
/*
 * 增加的回调
 */
@property (nonatomic,copy) dispatch_block_t addShopButtonClickBlock;
/*
 * 减少的回调
 */
@property (nonatomic,copy) dispatch_block_t deleteShopButtonClickBlock;

@end
