//
//  BusinessSignUpViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusinessSignUpViewController.h"
#import "BusniessDetailMainModel.h"
#import "UILabel+ZJAutoSize.h"
#import "PersonalAccountBalanceLogic.h"
#import "NSString+ZJDecimalNumber.h"
#import "ZJDecimalNumberTool.h"
#import "BDSignupForCourseLogic.h"
#import "PasswordAlertView.h"
#import "ZJPaymentPswLogic.h"
#import "UILabel+ZJAutoSize.h"

@interface BusinessSignUpViewController ()<PersonalAccountBalanceLogicDelegate,BDSignupForCourseLogicDelegate,PasswordAlertViewDelegate,VerifyPaymentPswDelegate>

{
    double _gold;//现金币
    double _cash;//原价格
    double _realPay;//实际支付金钱
    double _goldPay;//实际支付现金币
}

@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *timeL;
@property (nonatomic, strong) UILabel *locL;

@property (nonatomic, strong) UILabel *goldL;
@property (nonatomic, strong) UILabel *cashL;

@property (nonatomic, strong) UISwitch *sw;
@property (nonatomic, assign) BOOL isOn;

@property (nonatomic, strong) PasswordAlertView *passwordAlert;
@property (nonatomic, copy) NSString *orderNo;

@end

@implementation BusinessSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提交报名";
    self.view.backgroundColor = busniessViewBackgorundColor;

    [self initUI];
    [self setViewDataWithModel:self.model];
    
//    [self requestPersonalAccountBalance];
    
    
    NSString *elecNum = self.elecNum;
    self.goldL.text = [NSString stringWithFormat:@"可用现金币￥%@",elecNum];
    
    //处理现金币double失真问题
    _gold = [[NSString reviseString:elecNum] doubleValue];
    _cash = [[NSString reviseString:self.model.courseprice] doubleValue];
    _realPay = _cash;//初始状态
    _goldPay = 0;//switch开关初始处于关闭状态
    
    
}

- (void)initUI {
    
    __weak typeof(self) weakSelf = self;
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(50);
        make.height.mas_equalTo(120);
    }];
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [topView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(10);
        make.top.mas_equalTo(topView.mas_top).offset(10);
        make.height.and.width.mas_equalTo(100);
    }];
    _imgV = imgV;
    UILabel *nameL = [[UILabel alloc] init];
    nameL.text = @"课程名称";
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.numberOfLines = 0;
    nameL.textColor = lightgrayTextColor;
    nameL.font = [UIFont systemFontOfSize:14];
    [topView addSubview:nameL];
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgV.mas_right).offset(10);
        make.right.mas_equalTo(topView.mas_right).offset(-10);
        make.top.mas_equalTo(imgV.mas_top);
//        make.height.mas_equalTo(20);
    }];
    _nameL = nameL;
    UILabel *locL = [[UILabel alloc] init];
    locL.text = @"开课时间:";
    locL.textColor = lightgrayTextColor;
    locL.font = [UIFont systemFontOfSize:14];
    [topView addSubview:locL];
    [locL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameL.mas_left);
        make.right.mas_equalTo(topView.mas_right).offset(-10);
        make.bottom.mas_equalTo(imgV.mas_bottom);
        make.height.mas_equalTo(15);
    }];
    _locL = locL;
    UILabel *timeL = [[UILabel alloc] init];
    timeL.text = @"开课地点:";
    timeL.textColor = lightgrayTextColor;
    timeL.font = [UIFont systemFontOfSize:14];
    [topView addSubview:timeL];
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameL.mas_left);
        make.bottom.mas_equalTo(locL.mas_top).offset(-3);
        make.right.mas_equalTo(locL.mas_right);
        make.height.mas_equalTo(15);
    }];
    _timeL = timeL;
    
    
    UIView *centerV = [[UIView alloc] init];
    [self.view addSubview:centerV];
    centerV.backgroundColor = [UIColor whiteColor];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(15);
        make.left.mas_equalTo(topView.mas_left);
        make.right.mas_equalTo(topView.mas_right);
        make.height.mas_equalTo(40);
    }];
    UILabel *goldL = [[UILabel alloc] init];
    goldL.text = @"可用xxx现金币抵用";
    goldL.textColor = lightgrayTextColor;
    goldL.font = [UIFont systemFontOfSize:14];
    [centerV addSubview:goldL];
    [goldL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(centerV.mas_left).offset(5);
        make.centerY.mas_equalTo(centerV.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(250);
    }];
    _goldL = goldL;
    UISwitch *sw = [[UISwitch alloc] init];
    [centerV addSubview:sw];
    [sw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(centerV.mas_right).offset(-15);
        make.centerY.mas_equalTo(centerV.mas_centerY);
        
    }];
    _sw = sw;
    [sw addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
    }];
    UILabel *cashL = [[UILabel alloc] init];
    cashL.text = @"￥0.00";
    cashL.textColor = lightgrayTextColor;
    cashL.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:cashL];
    [cashL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(200);
    }];
    _cashL = cashL;
    UIButton *payButton = [[UIButton alloc] init];
    [payButton setTitle:@"去付款" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payButton.backgroundColor = zjTextColor;
    [bottomView addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bottomView.mas_right);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(bottomView.mas_top);
    }];
    [payButton setTarget:self action:@selector(paymentOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)setViewDataWithModel:(BusniessDetailMainModel *)model {
    
    self.nameL.text = [NSString stringWithFormat:@"课程名称:%@",model.coursename];
    //更新nameLabel高度
    CGFloat height = ceilf([self.nameL sizeForTextFontMaxSize:CGSizeMake(KScreenWidth-130, 65) font:self.nameL.font].height);
    [self.nameL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    self.timeL.text = [NSString stringWithFormat:@"开课时间:%@",model.coursestarttime];
    self.locL.text = [NSString stringWithFormat:@"开课地点:%@",model.coursesite];
    self.cashL.text = [NSString stringWithFormat:@"￥ %@",self.model.courseprice];
    
    NSURL *imgUrl = [[NSURL alloc] init];
    if (model.coursePhotos.count > 0) {
        PhotoModel *pic = model.coursePhotos[0];
        NSString *imgStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,pic.photo];
        imgUrl = [NSURL URLWithString:imgStr];
    } else {
        
    }
    [self.imgV setImageURL:imgUrl];
}



#pragma mark - logic
- (void)requestPersonalAccountBalance {

    PersonalAccountBalanceLogic *logic = [[PersonalAccountBalanceLogic alloc] init];
    logic.delegate = self;
    [logic getPersonalAccountBalance];

}

#pragma mark - logic delegate
- (void)getPersonalAccountBalanceCompletedWithRemainElecNum:(NSString *)elecNum {
    
  
}



#pragma mark --- switch
- (void)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch *)sender;
    BOOL isSwitchOn = [switchButton isOn];
    if (isSwitchOn) {
        NSLog(@"switch打开");
        
        NSDecimalNumber *cashNum = [ZJDecimalNumberTool decimalNumber:_cash];
        NSDecimalNumber *goldNum = [ZJDecimalNumberTool decimalNumber:_gold];
        
        NSDecimalNumber *realPayNum;
        NSDecimalNumber *goldPayNum;

        //总价格 - 现金币
        if (_cash > _gold) {
            realPayNum = [cashNum decimalNumberBySubtracting:goldNum];
            self.cashL.text = [NSString stringWithFormat:@"￥ %@",[realPayNum stringValue]];
            goldPayNum = goldNum;
        } else {
            goldPayNum = cashNum;
            realPayNum = [ZJDecimalNumberTool decimalNumber:0.00];
            self.cashL.text = @"￥ 0.00";
        }
        
        _realPay = [realPayNum doubleValue];
        _goldPay = [goldPayNum doubleValue];
        
    } else {
        NSLog(@"switch关闭");
        
        NSDecimalNumber *cashNum = [ZJDecimalNumberTool decimalNumber:_cash];
        self.cashL.text = [NSString stringWithFormat:@"￥ %@",[cashNum stringValue]];
        _realPay = [cashNum doubleValue];
        _goldPay = [[ZJDecimalNumberTool decimalNumber:0.00] doubleValue];
        
    }
}


- (void)paymentOrder:(id)sender {
    NSLog(@"点击了付款按钮\n_gold = %f\n_cash = %f\n_remainMoney = %f/n_remainGold = %f",_gold,_cash,_realPay,_goldPay);
    
    BDSignupForCourseLogic *logic = [[BDSignupForCourseLogic alloc] init];
    logic.delegate = self;
    
    NSString *courseid = self.model.identification;
    NSString *elecnum = [ZJDecimalNumberTool stringWithDecimalNumber:_goldPay];
    NSString *realpay = [ZJDecimalNumberTool stringWithDecimalNumber:_realPay];
    
    [logic requetSignupForCourseWithCourseid:courseid elecnum:elecnum realpay:realpay];
    
}

#pragma mark - logic delegate
- (void)requetSignupForCourseCompletedWithType:(NSString *)type info:(NSString *)info {
    
    if ([type isEqualToString:@"1"]) {
        //现金币支付
        self.orderNo = info;
        [self.passwordAlert show];
        
    } else if ([type isEqualToString:@"2"]) {
        //支付宝支付
        NSString *appScheme = @"com.zhongjianAlipay";
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:info fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    } else if ([type isEqualToString:@"3"]) {
        //混合支付
        NSString *appScheme = @"com.zhongjianAlipay";
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:info fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
    
}

- (void)signupForCourseCompletedWithErrormessage:(NSString *)message {
    
    [MBProgressHUD showInfoMessage:message];
}

#pragma mark ============ lazy passwordAlert ============
- (PasswordAlertView *)passwordAlert {
    if (!_passwordAlert) {
        _passwordAlert = [[PasswordAlertView alloc] initWithType:PasswordAlertViewType_default];
        _passwordAlert.delegate = self;
        _passwordAlert.titleLable.text = @"请输入密码";
        _passwordAlert.tipsLalbe.text = @"您输入的密码不正确";
    }
    return _passwordAlert;
}

#pragma mark - PasswordAlertViewDelegate
//点击了确定按钮或者是完成了6位密码的输入
- (void)PasswordAlertViewCompleteInputWith:(NSString *)password {
    
    ZJPaymentPswLogic *payLogic = [ZJPaymentPswLogic new];
    payLogic.delegate = self;
    
    [payLogic verifyPaymentPassWord:password];
}

#pragma mark ============ paymentPswLogicDelegate ============
- (void)verfyPaymentPswCompleted:(VerfyPaymentPswStatus)status {
    switch (status) {
        case 1://验证成功
            //隐藏支付框
            [self.passwordAlert hide];
            [self syncHandleOrdercc:self.orderNo];
            break;
        case 2://密码错误
        {
            [self.passwordAlert passwordError];
            break;
        }
        case 3://密码未设置
        {
            [self.passwordAlert passwordNotSetting];
            break;
        }
        default:
            break;
    }
    
}


#pragma mark - 商学院课程同步支付接口
- (void)syncHandleOrdercc:(NSString *)orderNo {
    
    BDSignupForCourseLogic *logic = [[BDSignupForCourseLogic alloc] init];
    logic.delegate = self;
    [logic syncHandleOrderccWithOrderNo:orderNo];
}

- (void)syncHandleOrderccCompleted:(NSString *)message {
    
    [MBProgressHUD showInfoMessage:@"报名成功"];
    //2秒后返回
    __weak typeof(self) weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



