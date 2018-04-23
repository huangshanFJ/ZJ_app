//
//  AddShopViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddShopViewController.h"
#import "SettlementViewController.h"
#import "DetailViewController.h"


@interface AddShopViewController () {
    int  shopNumber;
    BOOL isSelected;
    
    NSInteger selectedTag;
}


//@property (nonatomic,strong)UILabel


@end

@implementation AddShopViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.view.backgroundColor = [UIColor whiteColor];
    shopNumber = 1;
    //    _classArray = [NSMutableArray array];
    isSelected = NO;
    selectedTag = 0;
    [self initBottomView];
    NSLog(@"----%p",_classArray);
    
}
- (void)initBottomView {
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //hide by zy
//    topButton.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT*0.37);
    //    topButton.backgroundColor = [UIColor clearColor];
    [topButton addTarget:self action:@selector(backDetailView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topButton];
    [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(KHEIGHT*0.37);
        make.width.mas_offset(KWIDTH);
    }];
    
    //
    //hide by zy
//    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT*0.37, KWIDTH, KHEIGHT*0.63)];
    UIView *bottom  =[[UIView alloc] init];
    //    bottom.backgroundColor = [UIColor whiteColor];
    bottom.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(KHEIGHT*0.63);
        make.top.mas_offset(KHEIGHT*0.37);
    }];
    
    _headIconImage = [[UIImageView alloc] init];
    //    _headIconImage.image = [UIImage imageNamed:@"picture1"];
    [_headIconImage sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"picture1"]];
    _headIconImage.layer.cornerRadius = 5;
    _headIconImage.layer.masksToBounds = YES;
    [bottom addSubview:_headIconImage];
    [_headIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.width.mas_offset(110);
        make.height.mas_offset(110);
        make.top.equalTo(bottom.mas_top).offset(-26);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",_prcie]];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:11.0]
                          range:NSMakeRange(0, 2)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:19]
                          range:NSMakeRange(2, _prcie.length)];
    _priceLabel.textColor = [UIColor colorWithHexString:@"ff3a00"];
    _priceLabel.attributedText = AttributedStr;
    [bottom addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(15);
        make.width.mas_offset(KWIDTH*0.5);
        make.top.equalTo(bottom.mas_top).offset(40);
        make.height.mas_offset(20);
    }];
    _miniteLabel = [[UILabel alloc] init];
    _miniteLabel.font = [UIFont systemFontOfSize:12];
    //    _miniteLabel.text = @"130积分";
    NSString *number =  [NSString stringWithFormat:@"%@",_classArray[0][@"elecNum"]];
    int show = [number intValue];
    double showNumber = (double)show/(double)2;
    _miniteLabel.text = [NSString stringWithFormat:@"%.2lf红包",showNumber];
    _miniteLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [bottom addSubview:_miniteLabel];
    [_miniteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(15);
        make.width.mas_offset(75);
        make.height.mas_offset(15);
        make.top.equalTo(_priceLabel.mas_bottom).offset(2);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [bottom addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.right.mas_offset(11);
        make.height.mas_offset(0.5);
        make.top.equalTo(_headIconImage.mas_bottom).offset(10);
    }];
    UILabel *className = [[UILabel alloc] init];
    className.textColor = [UIColor colorWithHexString:@"444444"];
    className.text = @"规格";
    className.font = [UIFont systemFontOfSize:12];
    [bottom addSubview:className];
    [className mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.width.mas_offset(KWIDTH*0.5);
        make.top.equalTo(line.mas_bottom).offset(10);
        make.height.mas_offset(15);
    }];
    //    NSArray *classArr = @[@"套餐A",@"套餐B",@"套餐C",@"套餐D",@"套餐E",@"套餐F"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 130;//用来控制button距离父视图的高
    
    NSLog(@"************%@",_classArray);
    for (NSInteger i = 0; i < _classArray.count ; i++) {
        UIButton *packageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 计算行号  和   列号
        
        packageBtn.layer.cornerRadius = 5;
        packageBtn.layer.masksToBounds = YES;
        packageBtn.layer.borderWidth = 0.5;
        packageBtn.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
        packageBtn.tag = 100+i;
        packageBtn.selected = NO;
        packageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [packageBtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [packageBtn setTitleColor:zjTextColor forState:UIControlStateSelected];
        [packageBtn setTitle:_classArray[i][@"specname"] forState:UIControlStateNormal];
        //默认第一个选中
        if ( packageBtn.tag == 100) {
            packageBtn.selected = YES;
            [self packageClick:packageBtn];
        }
        
        
        [packageBtn addTarget:self action:@selector(packageClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat length=[self returnBtnWithWithStr:_classArray[i][@"specname"]];
        
        //当button的位置超出屏幕边缘时换行  只是button所在父视图的宽度
        packageBtn.frame = CGRectMake(10 + w, h, length + 15 , 30);
        //当button的位置超出屏幕边缘时换行  只是button所在父视图的宽度
        if(10 + w + length +11 > self.view.frame.size.width){
            w = 0; //换行时将w置为0
            h = h + packageBtn.frame.size.height + 10;//距离父视图也变化
            packageBtn.frame = CGRectMake(10 + w, h, length + 11, 30);//重设button的frame
        }
        w = packageBtn.frame.size.width + packageBtn.frame.origin.x;
        [bottom addSubview:packageBtn];
        
    }
    //add by zy   在这里需要显示加入购物车按钮
    
    UIButton *addShopButton;
    if (self.isShowAddShop) {
        addShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addShopButton addTarget:self action:@selector(addtoShop) forControlEvents:UIControlEventTouchUpInside];
       
        
        addShopButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:186/255.0 blue:96/255.0 alpha:1];
        [addShopButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        addShopButton.backgroundColor =[UIColor colorWithRed:246/255.0 green:172/255.0 blue:51/255.0 alpha:1];
        addShopButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [addShopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottom addSubview:addShopButton];
        [addShopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.width.mas_offset(KWIDTH/2.0);
            make.bottom.mas_offset(0);
            make.height.mas_offset(45);
        }];
        
        
        
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottom addSubview:buyButton];
        [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(addShopButton.mas_right).mas_equalTo(0);
            make.right.mas_offset(0);
            make.bottom.mas_offset(0);
            make.height.mas_offset(45);
        }];
        

//        buyButton.frame = CGRectMake(KWIDTH/2, bottom.frame.size.height -45,KWIDTH/2, 45);
        buyButton.backgroundColor = [UIColor colorWithHexString:@"6493ff"];
        [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
     
        [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyButton addTarget:self action:@selector(addShopClick:) forControlEvents:UIControlEventTouchUpInside];
        buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }else{
        //这里只显示直接购买按钮
       addShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //    [addShopButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [addShopButton setTitle:@"立即购买" forState:UIControlStateNormal];
        addShopButton.titleLabel.font = [UIFont systemFontOfSize:15];
        //    addShopButton addTarget:self action:@selector(addShopClick:) forControlEvents:<#(UIControlEvents)#>
        addShopButton.backgroundColor = [UIColor colorWithHexString:@"6493fe"];
        //    addShopButton.userInteractionEnabled = NO;
        //    addShopButton.backgroundColor = lightgrayTextColor;
        
        [addShopButton addTarget:self action:@selector(addShopClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottom addSubview:addShopButton];
        [addShopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.bottom.mas_offset(0);
            make.height.mas_offset(45);
        }];
        
    }
    

    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [bottom addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.right.mas_offset(-11);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(addShopButton.mas_top).offset(-50);
        //        make.bottom.mas_offset(-10);
    }];
    UILabel *buyNumber = [[UILabel alloc] init];
    buyNumber.text = @"购买数量";
    buyNumber.textColor = [UIColor colorWithHexString:@"444444"];
    buyNumber.font = [UIFont systemFontOfSize:12];
    [bottom addSubview:buyNumber];
    [buyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.width.mas_offset(KWIDTH*0.4);
        make.bottom.equalTo(addShopButton.mas_top).offset(-20);
        //         make.bottom.mas_offset(-20);
        make.height.mas_offset(15);
    }];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    addButton.layer.borderWidth = 0.5;
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addAndDeleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = 40;
    [bottom addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-11);
        make.width.mas_offset(27);
        make.height.mas_offset(27);
        make.centerY.equalTo(buyNumber.mas_centerY).offset(0);
    }];
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.text = @"1";
    _numberLabel.font = [UIFont systemFontOfSize:12];
    _numberLabel.textColor = zjTextColor;
    _numberLabel.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    _numberLabel.layer.borderWidth = 0.5;
    _numberLabel.textAlignment = 1;
    [bottom addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addButton.mas_left).offset(0);
        make.width.mas_offset(50);
        make.height.mas_offset(27);
        make.top.equalTo(addButton.mas_top).offset(0);
    }];
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setTitle:@"-" forState:UIControlStateNormal];
    deleteButton.layer.borderWidth = 0.5;
    deleteButton.tag = 50;
    deleteButton.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [deleteButton addTarget:self action:@selector(addAndDeleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    [bottom addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_numberLabel.mas_left).offset(0);
        make.height.mas_offset(27);
        make.width.mas_offset(27);
        make.top.equalTo(addButton.mas_top).offset(0);
    }];
 
}
-(CGFloat)returnBtnWithWithStr:(NSString *)str{
    //计算字符长度
    NSDictionary *minattributesri = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize mindetailSizeRi = [str boundingRectWithSize:CGSizeMake(100, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:minattributesri context:nil].size;
    return mindetailSizeRi.width+12;
    
}
- (void)addAndDeleteButtonClick:(UIButton *)sender {
    
    if (sender.tag == 40) {
        
        NSLog(@"增加前%d",shopNumber );
        shopNumber += 1;
        
        NSLog(@"增加后%d",shopNumber );
        _numberLabel.text = [NSString stringWithFormat:@"%d",shopNumber];
    }else {
        if (shopNumber > 1) {
            shopNumber -= 1;
            NSLog(@"%d",shopNumber);
            _numberLabel.text = [NSString stringWithFormat:@"%d",shopNumber];
        }
        
    }
    
    
}
- (void)deleteButtonClick:(UIButton *)sender {
    //    if (number>1) {
    //        number-=1;
    //        NSLog(@"%ld",number);
    //        _numberLabel.text = [NSString stringWithFormat:@"%d",number];
    //    }
}
- (void)packageClick:(UIButton *)sender {
    NSLog(@"选中的是%ld",(long)sender.tag);
    
    selectedTag = sender.tag-100;
    _prcie = [NSString stringWithFormat:@"%@",_classArray[sender.tag-100][@"price"]];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",_prcie]];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:11.0]
                          range:NSMakeRange(0, 2)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:19]
                          range:NSMakeRange(2, _prcie.length)];
    _priceLabel.textColor = [UIColor colorWithHexString:@"ff3a00"];
    _priceLabel.attributedText = AttributedStr;
    NSString *number =  [NSString stringWithFormat:@"%@",_classArray[sender.tag-100][@"elecNum"]];
    int show = [number intValue];
    double showNumber = (double)show/(double)2;
    _miniteLabel.text = [NSString stringWithFormat:@"%.2lf红包",showNumber];
    //    if (sender.tag == 100) {
    if (sender != self.selectedShopButton) {
        self.selectedShopButton.selected = NO;
        sender.selected = YES;
        self.selectedShopButton = sender;
    }else{
        self.selectedShopButton.selected = YES;
    }
    
    
}

- (void)packageButtonClick:(UIButton *)sender {
    
}
- (void)addShopClick:(UIButton *)sender {
    //    NSLog(@"")
//    [self requestData];
    NSString *specname = [NSString stringWithFormat:@"%@",_classArray[selectedTag][@"specname"]];
    NSString *shopNum = [NSString stringWithFormat:@"%d",shopNumber];
    NSString *elecNum =  [NSString stringWithFormat:@"%@",_classArray[selectedTag][@"elecNum"]];
    NSString *specId = [NSString stringWithFormat:@"%@",_classArray[selectedTag][@"id"]];
//    NSString *price = _prcie;
    NSDictionary *shopDic = @{
                              @"specname":specname,
                              @"shopNum":shopNum, //购买数量
                              @"elecNum":elecNum,//积分
                              @"price":_prcie,
                              @"imageUrl":_imageUrl,
                              @"specId":specId
                              };
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:shopDic forKey:@"ordrerDic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(AddShopViewControllerDelegatePushVC)]) {
        [_delegate AddShopViewControllerDelegatePushVC];
    }
    
    
//    NSString *number =  @""
    
    
}

- (void)requestData {//Index:(NSInteger)index
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSUserDefaults *userDefa = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefa objectForKey:@"userToken"];
    NSString *SpecId = [NSString stringWithFormat:@"%@",_classArray[selectedTag][@"id"]];
    //    NSInteger speid = [SpecId integerValue];
    NSString *productNum = [NSString stringWithFormat:@"%d",shopNumber];
    //    NSInteger preID = [_productId integerValue];
    NSString *url = [NSString stringWithFormat:@"%@%@/%@/%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/updateShoppingCartInfo",_productId,SpecId];
    NSDictionary *dic = @{
                          @"token":token,
                          @"productNum":productNum
                          };
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] integerValue] == 0) {
            [self dismissViewControllerAnimated:NO completion:nil];
            //hide by zy
//            if (_delegate && [_delegate respondsToSelector:@selector(AddShopViewControllerDelegatePushVC)]) {
//                [_delegate AddShopViewControllerDelegatePushVC];
//            }
            if (_delegate && [_delegate respondsToSelector:@selector(AddShopViewControllerSucess)]) {
                [_delegate AddShopViewControllerSucess];
            }
            
        }else if ([responseObject[@"error_code"] integerValue] == 3){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该账号已在其他手机登陆" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
}


- (void)backDetailView {
    printf("返回");
    self.navigationController.navigationBar.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 加入购物车
-(void)addtoShop{
    
    [self requestData];

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

