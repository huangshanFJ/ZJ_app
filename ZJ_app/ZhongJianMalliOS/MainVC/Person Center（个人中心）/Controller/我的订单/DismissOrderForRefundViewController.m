//
//  DismissOrderForRefundViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DismissOrderForRefundViewController.h"

@interface DismissOrderForRefundViewController () {
    NSArray *reasonArr;
    
    BOOL isSelected;
    NSInteger selectedTag;
}

@end

@implementation DismissOrderForRefundViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isSelected = NO;
    selectedTag = 0;
    reasonArr = @[@"配送信息有误",@"没有使用现金红包，购物币",@"商品买错了",@"重复下单，误下单",@"不想买了",@"其他原因"];
    [self initWithBottomView];
     
}
- (void)initWithBottomView {
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT*0.37);
    //    topButton.backgroundColor = [UIColor clearColor];
    [topButton addTarget:self action:@selector(backDetailView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topButton];
    [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(KHEIGHT-(reasonArr.count+1));
        make.width.mas_offset(KWIDTH);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(30*(reasonArr.count+1));
        make.top.mas_offset(KHEIGHT-(30*reasonArr.count));
    }];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//
    
    for (int i = 0; i < reasonArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        [button setImage:[UIImage imageNamed:@"fullin_gray"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateSelected];
        button.frame = CGRectMake(10, 5+20*i, 20, 20);
        [button addTarget:self action:@selector(reasonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        
        UILabel *reasonLabel = [[UILabel alloc] init];
        reasonLabel.text = reasonArr[i];
        reasonLabel.frame = CGRectMake(40, 5+20*i, KWIDTH-40, 20);
        reasonLabel.font = [UIFont systemFontOfSize:13];
        reasonLabel.textColor = lightBlackTextColor;
        [bottomView addSubview:reasonLabel];
        
        
    }
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setTitle:@"提交" forState:UIControlStateNormal];
//    [sendButton setTitleColor: forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    sendButton.frame = CGRectMake(0, 138, KWIDTH, 44);
    sendButton.backgroundColor = redTextColor;
    [bottomView addSubview:sendButton];
 
}
- (void)sendButtonClick:(UIButton *)sender {
    
    NSDictionary *dict = @{
                           @"memo":reasonArr[selectedTag],
                           @"orderNo":_seleOrderNo
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedReason" object:nil userInfo:dict];

    [self backDetailView];
}
- (void)reasonButtonClick:(UIButton *)sender {
   
    selectedTag = sender.tag-100;
    
    if (sender!= self.selectedShopButton) {
        self.selectedShopButton.selected = NO;
        sender.selected = YES;
        self.selectedShopButton = sender;
    }else{
        self.selectedShopButton.selected = YES;
    }
 
    NSLog(@"====%ld",(long)selectedTag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backDetailView {
    printf("返回");
    self.navigationController.navigationBar.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
