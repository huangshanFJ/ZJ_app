//
//  PurseHeadView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurseHeadView : UIView

@property (nonatomic,strong)UILabel *headNameLabel;//名字
@property (nonatomic,strong)UIImageView *headImage;//头像
@property (nonatomic,strong)UIButton *gradeButton;//升级等级
@property (nonatomic,strong)UIImageView *freeImage;//免费
@property (nonatomic,strong)UIImageView *VIPImage;//VIP
@property (nonatomic,strong)UIImageView *copartnerImage;//合伙人
@property (nonatomic,strong)UIImageView *baseAgencyImage;//准代理
@property (nonatomic,strong)UIImageView *agencyImage;//代理
@property (nonatomic,strong)UILabel *totalWealthLabel;
@property (nonatomic,strong)UIImageView *freeLine;//免费线条
@property (nonatomic,strong)UIImageView *VIPLine;//VIP线条
@property (nonatomic,strong)UIImageView *copartnerLine;//合伙人线条
@property (nonatomic,strong)UIImageView *quasiagencyImage;//准代理线条
@property (nonatomic,strong)UILabel *creatTime;//绿色通道时间

/*
 * 返回的回调
 */
@property (nonatomic,copy) dispatch_block_t backButtonClickBlock;
/*
 * 升级的回调
 */
@property (nonatomic,copy) dispatch_block_t upgradeButtonClickBlock;
/*
 * 问题的回调
 */
@property (nonatomic,copy) dispatch_block_t questionButtonClickBlock;
///*
// * 升级的回调
// */
//@property (nonatomic,strong) dispatch_block_t gradeButtonClickBlock;
/*
 * 充值的回调
 */
@property (nonatomic,strong) dispatch_block_t rechargeButtonClickBlock;
/*
 * 转让的回调
 */
@property (nonatomic,strong) dispatch_block_t transferthepossessionofButtonClickBlock;
/*
 * 提现的回调
 */
@property (nonatomic,strong) dispatch_block_t withdrawalsButtonClick;
/*
 * 记录的回调
 */
@property (nonatomic,strong) dispatch_block_t documentaryfilmButtonClick;
@end
