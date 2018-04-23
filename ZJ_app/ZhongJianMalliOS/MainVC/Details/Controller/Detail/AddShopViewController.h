//
//  AddShopViewController.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddShopViewControllerDelegate <NSObject>

- (void)AddShopViewControllerDelegatePushVC;
//add by zy
- (void)AddShopViewControllerSucess;

@end

@interface AddShopViewController : UIViewController
@property (nonatomic,strong)UIImageView *headIconImage;
@property (nonatomic,strong)NSString *imageUrl;
@property (nonatomic,strong)UILabel *priceLabel;//价格
@property (nonatomic,strong)NSString *prcie;
@property (nonatomic,strong)UILabel *miniteLabel;//积分
//@property (nonatomic,strong)UILabel *reserveLabel;//库存
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)NSMutableArray *classArray;
@property (nonatomic,strong)UIButton *selectedShopButton;

@property (nonatomic,strong)NSString *productId;
@property (nonatomic,assign) id <AddShopViewControllerDelegate>delegate;

//判断底部加入购物车按钮是否显示
@property (nonatomic,assign) BOOL isShowAddShop;

@end

