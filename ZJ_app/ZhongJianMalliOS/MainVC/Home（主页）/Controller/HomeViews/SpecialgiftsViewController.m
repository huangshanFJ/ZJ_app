//
//  SpecialgiftsViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SpecialgiftsViewController.h"
#import "SpecialgiftTableViewCell.h"
#import "SiftViewController.h"
#import "SpecialModel.h"
#import "DetailViewController.h"

@interface SpecialgiftsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL selectedPrice;
    BOOL selectedMinite;
    UIView *lineBottom;
    NSString *selectedType;
    //是否是最后一页
    BOOL is_noMore;
    //页数
    int _pageNum;
    NSMutableArray *_dataArray;

}

@property (nonatomic,strong)UITableView *specialgiftTable;
//@property (nonatomic,strong)SiftViewController *siftVC;

@end
static NSString *const giftCellID = @"SpecialgiftTableViewCell";

@implementation SpecialgiftsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectedPrice = NO;
    selectedMinite = NO;
    selectedType = @"1";
    _pageNum = 0;
     is_noMore = NO;
    _dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createData:NO];
    [self creatNavUI];
    [self creatTableView];
    [self initNav];
}
#pragma mark - 获取数据
- (void)createData:(BOOL)isMore {
    if (!isMore) {
        _pageNum = 0;
        [_dataArray removeAllObjects];
    }else if(is_noMore == NO)
    {
        _pageNum++;
    }
    if (_pageNum == 0) {
        [_dataArray removeAllObjects];
    }
    NSLog(@"%d",_pageNum);
    NSString *page = [NSString stringWithFormat:@"%d",_pageNum];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    if ([_selectedTag isEqualToString:@""]) {
//
//    }else {
        NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/HomePage/AreaProducts"];
         NSDictionary *dic = @{
                               @"tag":_selectedTag,
                               @"type":selectedType,
                               @"page":page,
                               @"pageNum":@"10"
                               };
        [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功%@",responseObject);
            if ([responseObject[@"error_code"] intValue] == 0) {
                NSArray *dataArr = [NSArray arrayWithArray:responseObject[@"data"]];
                for (NSDictionary *dict in dataArr) {
                    SpecialModel *model = [[SpecialModel alloc] init];
                    model.elecnum = [NSString stringWithFormat:@"%@",dict[@"elecnum"]];
                    model.productID = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.oldprice = [NSString stringWithFormat:@"%@",dict[@"oldprice"]];
                    model.price = [NSString stringWithFormat:@"%@",dict[@"price"]];
                    model.productname = [NSString stringWithFormat:@"%@",dict[@"productname"]];
                    if ([dict[@"productphotos"]count] > 0) {
                        model.productphotos = [NSString stringWithFormat:@"%@%@",HTTPUrl,dict[@"productphotos"][0][@"photo"]];
                    }else {
                        model.productphotos = @"";
                    }
                    
//                    model.productphotos = [NSString stringWithFormat:@"%@%@",HTTPUrl,dict[@"productphotos"][0][@"photo"]];
                    [_dataArray addObject:model];
                }
                if (dataArr.count < 10) {
                    is_noMore = YES;
                }else
                {
                    is_noMore = NO;
                }
                
            }
            [_specialgiftTable reloadData];
            [hud hideAnimated:YES];
            [self endRefresh];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败%@",error);
            [self endRefresh];
            [hud hideAnimated:YES];
        }];
        
        
//    }
    
}
- (void)initNav {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 47)];
    headView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"销量",@"价格",@"评价",@"积分"];//,@"筛选"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(KWIDTH-20)/titleArr.count*i, 10, KWIDTH/6, 20);
        [button setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = 200+i;
        [button addTarget:self action:@selector(titleLableButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat labelWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
        
        if ( i == 0 ) {
            lineBottom = [[UIView alloc] init];
            lineBottom.backgroundColor = zjTextColor;
            
            lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
            [button.titleLabel addSubview:lineBottom];
            
        }else {
        }
        if ( i == 1 || i == 3) {
            if (i == 1) {
                [button setSelected:selectedPrice];
                [button setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -13, 0,13)];
                [button setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth)];
            }else {
                [button setSelected:selectedMinite];
                [button setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -13, 0,13)];
                [button setImageEdgeInsets:UIEdgeInsetsMake(0,labelWidth, 0, -labelWidth)];
            }
            
        }
        //        if (i == 4) {
        //            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -13, 0,13)];
        //        }
        
        [headView addSubview:button];
        
    }
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, KWIDTH, 7)];
    footView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [headView addSubview:footView];
    [self.view addSubview:headView];
}
- (void)creatNavUI {
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
    if (_showTitle != nil) {
        title.text = _showTitle;
    }else {
        title.text = @"";
    }
    
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
        make.top.equalTo(title.mas_bottom).offset(-0.5);
        make.height.mas_offset(0.5);
    }];
}
- (void)creatTableView {

    self.specialgiftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+47, KWIDTH, KHEIGHT-64-47) style:UITableViewStylePlain];
    self.specialgiftTable.delegate = self;
    self.specialgiftTable.dataSource = self;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 1)];
    self.specialgiftTable.tableFooterView = line;
    self.specialgiftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    __weak typeof(self) weakSelf = self;
    self.specialgiftTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self createData:NO];
    }];
    self.specialgiftTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self createData:YES];
    }];
    
    [self.view addSubview:self.specialgiftTable];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 47;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    SpecialgiftTableViewCell *cell = [[SpecialgiftTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:giftCellID];
    if (!cell) {
        cell = [[SpecialgiftTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:giftCellID];
    }
    
    if (_dataArray.count != 0) {
        SpecialModel *model = [[SpecialModel alloc] init];
        model = _dataArray[indexPath.row];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",model.price]];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:11.0]
                              range:NSMakeRange(0, 2)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:17]
                              range:NSMakeRange(2, model.price.length)];
        cell.priceLabel.textColor = [UIColor colorWithHexString:@"ff3a00"];
        cell.priceLabel.attributedText = AttributedStr;
        [cell.giftImage sd_setImageWithURL:[NSURL URLWithString:model.productphotos]];
        cell.giftNameLabel.text = model.productname;
        
        int miniteNumber = [model.elecnum intValue];
        double showNumber = (double)miniteNumber/(double)2;
        NSString *numberStr = [NSString stringWithFormat:@"%.2lf",showNumber];
        NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attach.bounds = CGRectMake(0, 0, 12, 12);
        attach.image = [UIImage imageNamed:@"redpacket"];
        
        NSAttributedString *strAtt = [NSAttributedString attributedStringWithAttachment:attach];
        
        NSMutableAttributedString *strMatt = [[NSMutableAttributedString alloc] initWithString:numberStr];
        [strMatt insertAttributedString:strAtt atIndex:0];
        
        cell.miniteLabel.attributedText = strMatt;
        
     
    }
    return cell;
}
- (void)titleLableButtonClick:(UIButton *)sender {
    CGFloat labelWidth = [sender.titleLabel.text sizeWithFont:sender.titleLabel.font].width;

    if (sender.tag == 200) {
        NSLog(@"销量");
        lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
        selectedType = @"1";
        [_dataArray removeAllObjects];
        [self createData:YES];
    }else if (sender.tag == 201) {
        NSLog(@"价格");
        lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
        selectedPrice = !selectedPrice;
        sender.selected = selectedPrice;
        if (selectedPrice == YES) {
            NSLog(@"从高到低");
            [sender setImage:[UIImage imageNamed:@"down"] forState:UIControlStateSelected];
            selectedType = @"2";
            [_dataArray removeAllObjects];
            [self createData:YES];
            
        }else{
             NSLog(@"从低到高");
            [sender setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
            selectedType = @"3";
            [_dataArray removeAllObjects];
            [self createData:YES];
        }
    }else if (sender.tag == 202) {
        NSLog(@"评价");
        lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
        selectedType = @"4";
         [_dataArray removeAllObjects];
        [self createData:YES];
        
    }else if (sender.tag == 203) {
        NSLog(@"积分");
        lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
        selectedMinite = !selectedMinite;
        sender.selected = selectedMinite;
        if (selectedMinite == YES) {
             NSLog(@"从高到低");
            [sender setImage:[UIImage imageNamed:@"down"] forState:UIControlStateSelected];
            selectedType = @"5";
             [_dataArray removeAllObjects];
            [self createData:YES];
            
        }else{
              NSLog(@"从低到高");
            [sender setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
            selectedType = @"6";
             [_dataArray removeAllObjects];
            [self createData:YES];
        }
    }
//    else {
//        NSLog(@"筛选");
//        lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
//        [sender.titleLabel addSubview:lineBottom];
//        SiftViewController *sift = [[SiftViewController alloc] init];
//        sift.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        [self presentViewController:sift animated:NO completion:^{
//
//            sift.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//
//        }];
//
//    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecialModel *model = [[SpecialModel alloc] init];
    model = _dataArray[indexPath.row];
    DetailViewController *shopVC = [DetailViewController new];
    shopVC.productId = model.productID;
    
    [self.navigationController pushViewController:shopVC animated:YES];
}
- (void)backButtonClick {
	self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 开始进入刷新状态
- (void)endRefresh
{
    [_specialgiftTable.mj_header endRefreshing];
    if (is_noMore == YES) {
        [_specialgiftTable.mj_footer endRefreshingWithNoMoreData];
//        _specialgiftTable.mj_footer.hidden = YES;

    }else {
        [_specialgiftTable.mj_footer endRefreshing];
    }
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

