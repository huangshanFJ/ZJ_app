//
//  SiftCollectionHeadView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiftCollectionHeadView : UICollectionReusableView

@property (nonatomic,strong)UITextField *maxPriceTF;//最高价
@property (nonatomic,strong)UITextField *minPriceTF;//最低价

@property (nonatomic,strong)UIButton *placeButton;//发货地方

@end
