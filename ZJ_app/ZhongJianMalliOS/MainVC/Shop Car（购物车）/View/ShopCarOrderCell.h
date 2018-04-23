//
//  ShopCarOrderCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarOrderCell : UITableViewCell

@property (nonatomic,strong)UILabel *freightMoney;//运费
@property (nonatomic,strong)UILabel *redMoneyPay;//可用红包
@property (nonatomic,strong)UILabel *shopMoneyPay;//可用购物
@property (nonatomic,strong)UILabel *readyMoneyPay;//可用现金币
//@property (nonatomic,strong)UISwitch *redSwich;//现金红包
//@property (nonatomic,strong)UISwitch *shopSwich;//购物币
//@property (nonatomic,strong)UISwitch *readySwich;//现金币
@property (nonatomic,strong)UILabel *totalNumber;//订单总价
@property (nonatomic,strong)UILabel *redNumber;//抵用红包
@property (nonatomic,strong)UILabel *shopNumber;//抵用购物币
@property (nonatomic,strong)UILabel *readyNumber;//抵用现金币



@end
