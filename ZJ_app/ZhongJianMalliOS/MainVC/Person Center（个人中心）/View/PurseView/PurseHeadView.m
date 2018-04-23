//
//  PurseHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PurseHeadView.h"

@implementation PurseHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configHeadView];
    }
    return self;
}
- (void)configHeadView {
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    bgImage.userInteractionEnabled = YES;
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(235);
        make.right.mas_offset(0);
    }];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 100;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-1"] forState:UIControlStateNormal];
    [bgImage addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    title.text = @"我的钱包";
    title.textAlignment = 1;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:17];
    [bgImage addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
    UIButton *questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionButton addTarget:self action:@selector(questionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [questionButton setBackgroundImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
    [bgImage addSubview:questionButton];
    [questionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.mas_offset(30);
        make.height.mas_offset(22);
        make.width.mas_offset(22);
    }];
//
    UILabel *purseLabel = [[UILabel alloc] init];
    purseLabel.text = @"我的钱包";
    purseLabel.textAlignment = 1;
    purseLabel.textColor = [UIColor whiteColor];
    purseLabel.font = [UIFont systemFontOfSize:17];
    [bgImage addSubview:purseLabel];


    UIImageView *quanImageView = [[UIImageView alloc] init];
    quanImageView.clipsToBounds = YES;
    quanImageView.layer.cornerRadius = 55/2;
    quanImageView.layer.borderWidth = 2;
    quanImageView.layer.borderColor = [UIColor colorWithHexString:@"a2bffc"].CGColor;

    [bgImage addSubview:quanImageView];
    [quanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(25);
        make.width.mas_offset(55);
        make.height.mas_offset(55);
        make.top.mas_offset(80);
    }];
//    /*-------------------------------头像---------------------------------*/
    _headImage = [[UIImageView alloc] init];
    _headImage.userInteractionEnabled = YES;
    [quanImageView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(2);
        make.width.mas_offset(51);
        make.height.mas_offset(51);
        make.top.equalTo(quanImageView.mas_top).offset(2);
    }];
//    /*-------------------------------名字---------------------------------*/
    _headNameLabel = [[UILabel alloc] init];
    _headNameLabel.text = @"灰灰灰";
    _headNameLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:19.0];
    _headNameLabel.textColor = [UIColor whiteColor];
    [bgImage addSubview:_headNameLabel];
    [_headNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(quanImageView.mas_right).offset(17);
        make.height.mas_offset(24);
        make.top.equalTo(quanImageView.mas_top).offset(-2);
    }];
//    /*-------------------------------升级等级---------------------------------*/
    UIButton *wantgradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wantgradeButton setBackgroundImage:[UIImage imageNamed:@"upgrade"] forState:UIControlStateNormal];
    [wantgradeButton addTarget:self action:@selector(gradeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgImage addSubview:wantgradeButton];
    [wantgradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headNameLabel.mas_right).offset(10);
        make.width.mas_offset(75);
        make.height.mas_offset(22);
        make.bottom.equalTo(_headNameLabel.mas_bottom).offset(0);
    }];
//    /*-------------------------------免费---------------------------------*/
    _freeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"99vip_gray"]];
    [bgImage addSubview:_freeImage];
    [_freeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(quanImageView.mas_right).offset(15);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.equalTo(_headNameLabel.mas_bottom).offset(12);
    }];
    _freeLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_gary"]];
    _freeLine.backgroundColor = [UIColor whiteColor];
    [bgImage addSubview:_freeLine];
    [_freeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_freeImage.mas_centerY).offset(0);
        make.width.mas_offset(KWIDTH*0.08);
        make.height.mas_offset(2);
        make.left.equalTo(_freeImage.mas_right).offset(0);
    }];
    UILabel *freeLabel = [UILabel new];
    freeLabel.text = @"免费";
    freeLabel.textColor = [UIColor whiteColor];
    freeLabel.font = [UIFont systemFontOfSize:10];
    freeLabel.textAlignment = 1;
    [bgImage addSubview:freeLabel];
    [freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_freeImage.mas_centerX).offset(0);
        make.top.equalTo(_freeImage.mas_bottom).offset(5);
        make.height.mas_offset(12);
    }];
//    /*-------------------------------VIP---------------------------------*/
    _VIPImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip_gary"]];
    [bgImage addSubview:_VIPImage];
    [_VIPImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_freeLine.mas_right).offset(0);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.equalTo(_freeImage.mas_top);
        //make.top.equalTo(_gradeButton.mas_bottom).offset(12);
    }];
    _VIPLine = [[UIImageView alloc] init];
//    _VIPLine.backgroundColor = [UIColor whiteColor];
    _VIPLine.image = [UIImage imageNamed:@"bg_gary"];
    [bgImage addSubview:_VIPLine];
    [_VIPLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_freeImage.mas_centerY).offset(0);
        make.width.mas_offset(KWIDTH*0.08);
        make.height.mas_offset(2);
        make.left.equalTo(_VIPImage.mas_right).offset(0);
    }];
    UILabel *vipLabel = [UILabel new];
    vipLabel.text = @"绿色通道";
    vipLabel.textColor = [UIColor whiteColor];
    vipLabel.font = [UIFont systemFontOfSize:10];
    vipLabel.textAlignment = 1;
    [bgImage addSubview:vipLabel];
    [vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_VIPImage.mas_centerX).offset(0);
        make.top.equalTo(_freeImage.mas_bottom).offset(5);
        make.height.mas_offset(12);
    }];
    /*-------------------------------合伙人---------------------------------*/
    _copartnerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"partner_gary"]];
    [bgImage addSubview:_copartnerImage];
    [_copartnerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_VIPLine.mas_right).offset(0);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.equalTo(_freeImage.mas_top);
    }];
    _copartnerLine = [[UIImageView alloc] init];
 
    _copartnerLine.image = [UIImage imageNamed:@"bg_gary"];
    [bgImage addSubview:_copartnerLine];
    [_copartnerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_copartnerImage.mas_right).offset(0);
        make.centerY.equalTo(_freeImage.mas_centerY).offset(0);
        make.width.mas_offset(KWIDTH*0.08);
        make.height.mas_offset(2);
    }];
    UILabel *copartnerLabel = [[UILabel alloc] init];
    copartnerLabel.text = @"VIP";
    copartnerLabel.textColor = [UIColor whiteColor];
    copartnerLabel.font = [UIFont systemFontOfSize:10];
    copartnerLabel.textAlignment = 1;
    [bgImage addSubview:copartnerLabel];
    [copartnerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_copartnerImage.mas_centerX).offset(0);
        make.top.equalTo(_freeImage.mas_bottom).offset(5);
        make.height.mas_offset(12);
    }];
//    /*-------------------------------准代理---------------------------------*/
    _baseAgencyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quasiagency_gary"]];
    [bgImage addSubview:_baseAgencyImage];
    [_baseAgencyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_copartnerLine.mas_right).offset(0);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.equalTo(_freeImage.mas_top);
    }];
    _quasiagencyImage= [UIImageView new];
    _quasiagencyImage.image = [UIImage imageNamed:@"bg_gary"];
    [bgImage addSubview:_quasiagencyImage];
    [_quasiagencyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_baseAgencyImage.mas_right).offset(0);
        make.centerY.equalTo(_freeImage.mas_centerY).offset(0);
        make.width.mas_offset(KWIDTH*0.08);
        make.height.mas_offset(2);
    }];
    UILabel *quasiagencyLabel = [[UILabel alloc] init];
    quasiagencyLabel.text = @"准代理";
    quasiagencyLabel.textColor = [UIColor whiteColor];
    quasiagencyLabel.font = [UIFont systemFontOfSize:10];
    quasiagencyLabel.textAlignment = 1;
    [bgImage addSubview:quasiagencyLabel];
    [quasiagencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_baseAgencyImage.mas_centerX).offset(0);
        make.top.equalTo(_freeImage.mas_bottom).offset(5);
        make.height.mas_offset(12);
    }];
    /*-------------------------------代理---------------------------------*/
    _agencyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"agent_gary"]];
    [bgImage addSubview:_agencyImage];
    [_agencyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_quasiagencyImage.mas_right).offset(0);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.equalTo(_freeImage.mas_top);
    }];
    UILabel *agencyLabel = [[UILabel alloc] init];
    agencyLabel.text = @"代理";
    agencyLabel.textColor = [UIColor whiteColor];
    agencyLabel.font = [UIFont systemFontOfSize:10];
    agencyLabel.textAlignment = 1;
    [bgImage addSubview:agencyLabel];
    [agencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_agencyImage.mas_centerX).offset(0);
        make.top.equalTo(_freeImage.mas_bottom).offset(5);
        make.height.mas_offset(12);
    }];
    
    _creatTime = [[UILabel alloc] init];
    _creatTime.textColor = [UIColor whiteColor];
    _creatTime.font = [UIFont systemFontOfSize:10];
    [bgImage addSubview:_creatTime];
    [_creatTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(freeLabel.mas_left).offset(0);
        make.top.equalTo(agencyLabel.mas_bottom).offset(2);
        make.height.mas_offset(14);
    }];
    
    /*-------------------------------我的财富---------------------------------*/
    UIImageView *myWealth = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my wealth"]];
    myWealth.userInteractionEnabled = YES;
    [self addSubview:myWealth];
    [myWealth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.top.equalTo(bgImage.mas_top).offset(176);
        make.height.mas_offset(210);
    }];
    
    _totalWealthLabel = [[UILabel alloc] init];
    _totalWealthLabel.textAlignment = 1;
    _totalWealthLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:24];
    _totalWealthLabel.textColor = lightBlackTextColor;
    [myWealth addSubview:_totalWealthLabel];
    [_totalWealthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.height.mas_offset(25);
        make.top.equalTo(myWealth.mas_top).offset(70);
    }];
    UILabel *moneyLabel = [UILabel new];
    moneyLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:13];
    moneyLabel.textColor = lightBlackTextColor;
    moneyLabel.textAlignment = 2;
    moneyLabel.text = @"￥";
    [myWealth addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_totalWealthLabel.mas_left).offset(-5);
        make.height.mas_offset(12);
        make.centerY.equalTo(_totalWealthLabel.mas_centerY).offset(2);
    }];

    UILabel *kindMoney = [[UILabel alloc] init];
    kindMoney.text = @"现金币";
    kindMoney.textColor = lightBlackTextColor;
    kindMoney.font = [UIFont systemFontOfSize:12];
    [myWealth addSubview:kindMoney];
    [kindMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.equalTo(_totalWealthLabel.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    /*-------------------------------充值---------------------------------*/
    
    UIImageView *moneyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"money"]];
    moneyImage.userInteractionEnabled = YES;
    [myWealth addSubview:moneyImage];
    [moneyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWealth.mas_left).offset(KWIDTH*0.1);
        make.width.mas_offset(22);
        make.height.mas_offset(22);
        make.top.equalTo(kindMoney.mas_bottom).offset(15);
    }];
    UILabel *rechargeLabel = [UILabel new];
    rechargeLabel.text = @"充值";
    rechargeLabel.font = [UIFont systemFontOfSize:12];
    rechargeLabel.textColor = lightBlackTextColor;
    rechargeLabel.textAlignment = 1;
    [myWealth addSubview:rechargeLabel];
    [rechargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(moneyImage.mas_centerX).offset(0);
        make.height.mas_offset(15);
        make.top.equalTo(moneyImage.mas_bottom).offset(5);
    }];
    UIButton *rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeButton.backgroundColor = [UIColor clearColor];
    [rechargeButton addTarget:self action:@selector(rechargrButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [myWealth addSubview:rechargeButton];
    [rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWealth.mas_left).offset(30);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.top.equalTo(kindMoney.mas_bottom).offset(15);
    }];
    /*-------------------------------转让---------------------------------*/
    UIImageView *transferthepossessionofImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transferthepossessionof"]];
    transferthepossessionofImage.userInteractionEnabled = YES;
    [myWealth addSubview:transferthepossessionofImage];
    [transferthepossessionofImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyImage.mas_right).offset(KWIDTH*0.18);
        make.width.mas_offset(22);
        make.height.mas_offset(22);
        make.top.equalTo(kindMoney.mas_bottom).offset(15);
    }];
    UILabel *transferthepossessionofLabel = [UILabel new];
    transferthepossessionofLabel.textAlignment = 1;
    transferthepossessionofLabel.textColor = lightBlackTextColor;
    transferthepossessionofLabel.text = @"转让";
    transferthepossessionofLabel.font = [UIFont systemFontOfSize:12];
    [myWealth addSubview:transferthepossessionofLabel];
    [transferthepossessionofLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(transferthepossessionofImage.mas_centerX).offset(0);
        make.height.mas_offset(15);
        make.top.equalTo(moneyImage.mas_bottom).offset(5);
    }];
    UIButton *transferthepossessionofButton = [UIButton buttonWithType:UIButtonTypeCustom];
    transferthepossessionofButton.backgroundColor = [UIColor clearColor];
    [transferthepossessionofButton addTarget:self action:@selector(transferthepossessionofButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [myWealth addSubview:transferthepossessionofButton];
    [transferthepossessionofButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyImage.mas_right).offset(60);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.top.equalTo(kindMoney.mas_bottom).offset(15);
    }];
//    /*-------------------------------提现---------------------------------*/
    UIImageView *withdrawalsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"withdrawals"]];
    [myWealth addSubview:withdrawalsImage];
    withdrawalsImage.userInteractionEnabled = YES;
    [withdrawalsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(transferthepossessionofImage.mas_right).offset(KWIDTH*0.18);
        make.width.mas_offset(22);
        make.height.mas_offset(22);
        make.top.equalTo(kindMoney.mas_bottom).offset(15);
    }];
    UILabel *withdrawalsLabel = [[UILabel alloc] init];
    withdrawalsLabel.text = @"提现";
    withdrawalsLabel.font = [UIFont systemFontOfSize:12];
    withdrawalsLabel.textColor = lightBlackTextColor;
    withdrawalsLabel.textAlignment = 1;
    [myWealth addSubview:withdrawalsLabel];
    [withdrawalsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(withdrawalsImage.mas_centerX).offset(0);
        make.height.mas_offset(15);
        make.top.equalTo(moneyImage.mas_bottom).offset(5);
    }];
    UIButton *withdrawalsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    withdrawalsButton.backgroundColor = [UIColor clearColor];
    [withdrawalsButton addTarget:self action:@selector(withdrawalsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [myWealth addSubview:withdrawalsButton];
    [withdrawalsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(transferthepossessionofImage.mas_right).offset(60);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.top.equalTo(kindMoney.mas_bottom).offset(15);
    }];
//    /*-------------------------------记录---------------------------------*/
    UIImageView *documentaryfilmImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"documentaryfilm"]];
    [myWealth addSubview:documentaryfilmImage];
    documentaryfilmImage.userInteractionEnabled = YES;
    [documentaryfilmImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(withdrawalsImage.mas_right).offset(KWIDTH*0.18);
        make.width.mas_offset(22);
        make.height.mas_offset(22);
        make.top.equalTo(kindMoney.mas_bottom).offset(15);
    }];
    UILabel *documentaryfilmLabel = [UILabel new];
    documentaryfilmLabel.text = @"记录";
    documentaryfilmLabel.font = [UIFont systemFontOfSize:12];
    documentaryfilmLabel.textColor = lightBlackTextColor;
    documentaryfilmLabel.textAlignment = 1;
    [myWealth addSubview:documentaryfilmLabel];
    [documentaryfilmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(documentaryfilmImage.mas_centerX).offset(0);
        make.height.mas_offset(15);
        make.top.equalTo(moneyImage.mas_bottom).offset(5);
    }];
    UIButton *documentaryfilmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    documentaryfilmButton.backgroundColor = [UIColor clearColor];
    [documentaryfilmButton addTarget:self action:@selector(documentaryfilmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [myWealth addSubview:documentaryfilmButton];
    [documentaryfilmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(withdrawalsImage.mas_right).offset(55);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.top.equalTo(kindMoney.mas_bottom).offset(15);
    }];
    
}
//返回
- (void)backButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_backButtonClickBlock ? : _backButtonClickBlock();
}
//问题
- (void)questionButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_questionButtonClickBlock ? : _questionButtonClickBlock();
}
//升级
- (void)gradeButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_upgradeButtonClickBlock ? : _upgradeButtonClickBlock();
}
//充值
- (void)rechargrButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_rechargeButtonClickBlock ? : _rechargeButtonClickBlock();
}
//转让
- (void)transferthepossessionofButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_transferthepossessionofButtonClickBlock ? : _transferthepossessionofButtonClickBlock();
}
//提现
- (void)withdrawalsButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_withdrawalsButtonClick ? : _withdrawalsButtonClick();
}
//记录
- (void)documentaryfilmButtonClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    !_documentaryfilmButtonClick ? : _documentaryfilmButtonClick();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
