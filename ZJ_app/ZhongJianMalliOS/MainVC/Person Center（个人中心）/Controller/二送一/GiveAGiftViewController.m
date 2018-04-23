//
//  GiveAGiftViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GiveAGiftViewController.h"
#import "GiftTableViewCell.h"
#import "SYPasswordView.h"
#import "SetPassViertyViewController.h"
#import "GiftPassViewController.h"

@interface GiveAGiftViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSDictionary *dataDiction;
    NSMutableArray *dataArr;
}


@property (nonatomic,strong)UITableView *sendGiftTable;
@property (nonatomic,strong)UITextField *giftText;

@end
static NSString *const cellID = @"GiftTableViewCell";
@implementation GiveAGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    dataArr = [NSMutableArray arrayWithCapacity:0];
    dataDiction = [NSDictionary dictionary];
    [self configNav];
    [self headView];
    [self configTableView];
    [self bottomView];
//    [self requestData];
    //键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    /**
     * 添加键盘的监听事件
     *
     */
    [self registerForKeyboardNotifications];
}
- (void)bottomView {
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.backgroundColor = zjTextColor;
    shareButton.layer.cornerRadius = 45/2;
    shareButton.layer.masksToBounds = YES;
    [shareButton setTitle:@"立即赠送" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [shareButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-39);
        make.width.mas_equalTo(KWIDTH*0.76);
    }];
    
}
- (void)requestData {
   
    
    
    
}
- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 100;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    title.text = @"名额赠送";
    title.textAlignment = 1;
    title.textColor = [UIColor colorWithHexString:@"444444"];
    title.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(63);
        make.height.mas_offset(1);
    }];
}
- (void)headView {
    UIView *gray = [[UIView alloc] init];
    gray.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:gray];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(70);
        make.width.mas_offset(KWIDTH);
        make.top.mas_offset(64);
    }];
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [gray addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.top.equalTo(gray.mas_top).offset(20);
        make.height.mas_offset(40);
    }];
    
    _giftText = [[UITextField alloc] init];
    _giftText.font = [UIFont systemFontOfSize:13];
    _giftText.textColor = lightBlackTextColor;
    _giftText.keyboardType = UIKeyboardTypeNumberPad;
    _giftText.placeholder = @"请输入对方的众健号";
    [whiteView addSubview:_giftText];
    [_giftText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.width.mas_offset(KWIDTH*0.5);
        make.top.equalTo(whiteView.mas_top).offset(0);
        make.height.mas_offset(40);
    }];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.backgroundColor = zjTextColor;
    searchButton.layer.masksToBounds = YES;
    searchButton.layer.cornerRadius = 5;
    [searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_offset(90);
        make.height.mas_offset(30);
        make.centerY.equalTo(whiteView.mas_centerY).offset(0);
    }];
    
    
    
}
- (void)configTableView {
    _sendGiftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+70,KWIDTH , KHEIGHT-64-70) style:UITableViewStylePlain];
    _sendGiftTable.delegate = self;
    _sendGiftTable.dataSource = self;
    _sendGiftTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_sendGiftTable];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return dataArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    GiftTableViewCell *cell = [[GiftTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//    if ( cell == nil) {
//        cell = [[GiftTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//    }
//    NSLog(@"dataArr===%@",dataArr);
//    if (dataArr.count > 0) {
    
//
//        cell.nameLabel.text = @"111";//nameStr;
//        cell.phoneLabel.text = phoneStr;
//        cell.zjNumberLabel.text = number;
//    }
//    cell.nameLabel.text = @"111";
   
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"giftID"];
    if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"giftID"];
    }
    UIImageView *_headImageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
    _headImageIcon.layer.masksToBounds = YES;
    _headImageIcon.layer.cornerRadius = 30;
    _headImageIcon.backgroundColor = [UIColor blueColor];
    [cell addSubview:_headImageIcon];
    [_headImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.height.mas_offset(60);
        make.top.mas_offset(10);
        make.width.mas_offset(60);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = lightgrayTextColor;
    nameLabel.text = @"111";
    nameLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageIcon.mas_right).offset(10);
        make.top.equalTo(_headImageIcon.mas_top).offset(0);
        make.height.mas_offset(20);
        make.width.mas_offset(KWIDTH*0.4);
    }];
    UILabel *_phoneLabel = [[UILabel alloc] init];
    _phoneLabel.textColor = lightgrayTextColor;
    _phoneLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageIcon.mas_right).offset(10);
        make.height.mas_offset(20);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.width.mas_offset(KWIDTH*0.4);
    }];
    UILabel *_zjNumberLabel = [[UILabel alloc] init];
    _zjNumberLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold"  size:14];
    _zjNumberLabel.textColor = lightBlackTextColor;
    _zjNumberLabel.textAlignment = 2;
    [cell addSubview:_zjNumberLabel];
    [_zjNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.centerY.mas_offset(0);
        make.width.mas_offset(KWIDTH*0.4);
    }];
    
    if (dataArr.count > 0) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataDiction[@"HeadPhoto"]];
        NSString *nameStr = [NSString stringWithFormat:@"%@",dataDiction[@"TrueName"]];
        NSString *phoneStr = [NSString stringWithFormat:@"%@",dataDiction[@"UserName"]];
        NSString *number = [NSString stringWithFormat:@"众健号：%@",dataDiction[@"SysID"]];
        [_headImageIcon sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        nameLabel.text = nameStr;
        _phoneLabel.text = phoneStr;
        _zjNumberLabel.text = number;
        NSLog(@"--===%@/====---%@/====----%@/",nameLabel.text,_phoneLabel.text,_zjNumberLabel.text);
    }
    NSLog(@"--%@/---%@/----%@/",nameLabel.text,_phoneLabel.text,_zjNumberLabel.text);

    
    return cell;
}
- (void)searchButtonClick:(UIButton *)sender {
    if (_giftText.text.length > 0) {
        [dataArr removeAllObjects];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer new];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
        NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/MemberShip/getMemberBySysId/",token];
        NSDictionary *parame = @{
                                 @"SysID":_giftText.text
                                 };
        [manager GET:url parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSString *show = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            if ([responseObject[@"error_code"] integerValue] == 0) {
                NSDictionary *dict = responseObject[@"data"];
                [dataArr addObject:dict];
                dataDiction = dict;
                [_sendGiftTable reloadData];
            }else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:show message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
            }
            
           
            [hud hideAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
            [hud hideAnimated:YES];
        }];
    }
    
}
- (void)sendButtonClick:(UIButton *)sender {
    if (dataArr.count > 0) {
         NSString *sysID = [NSString stringWithFormat:@"%@",dataArr[0][@"Id"]];
        GiftPassViewController *gift = [GiftPassViewController new];
        
        [self presentViewController:gift animated:YES completion:^{
            gift.passiveUserId = sysID;
            gift.sendHeadId = _sendID;
//            @"":_sendID
        }];
        
        
    }
 
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark--注册监听键盘的的通知
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark-- 键盘出现的通知

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    //键盘高度
    
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (KHEIGHT < 600) {
        if ([_giftText isFirstResponder]) {
            self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
            
        }else{
            
            self.view.frame = CGRectMake(0, -100, KWIDTH, KHEIGHT );
        }
        
    }
    
    
}
#pragma mark-- 键盘消失的通知

-(void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
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
