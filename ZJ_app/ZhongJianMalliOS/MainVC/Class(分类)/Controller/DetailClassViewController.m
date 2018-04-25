//
//  DetailClassViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DetailClassViewController.h"
//#import "SpecialgiftTableViewCell.h"
//#import "SpecialModel.h"
#import "MemberTableViewCell.h"
#import "DetailClassModel.h"
#import "DetailViewController.h"

@interface DetailClassViewController ()<UITableViewDelegate,UITableViewDataSource> {
//    NSMutableArray *detailClassDataArr;
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


@property (nonatomic,strong)UITableView *detailClassTable;

@end
static NSString *const giftCellID = @"MemberTableViewCell";

@implementation DetailClassViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
//    detailClassDataArr = [NSMutableArray arrayWithCapacity:0];
    _dataArray = [NSMutableArray array];

    selectedPrice = NO;
    selectedMinite = NO;
    selectedType = @"1";
    _pageNum = 0;
    is_noMore = NO;
    
 
    [self createData:NO];
    [self initNav];
    [self initClassTableView];
    
}
#pragma mark -- UI
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
    if (_titleText == nil) {
        _titleText = @"";
    };
    title.text = _titleText;
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
#pragma mark - 获取数据
- (void)createData:(BOOL)isMore {
    if (!isMore) {
        _pageNum = 0;
        
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
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/ProductManager/getProductOfCategory/",_categoryId];
    NSDictionary *dic = @{
//                          @"SubCategoryId":_categoryId,
                          @"type":selectedType,
                          @"page":page,
                          @"pageNum":@"20"
                          };
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            NSMutableArray *dataArr = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            for (NSDictionary *dict in dataArr) {
                DetailClassModel *model = [[DetailClassModel alloc] init];
                model.beLongToVIP = [NSString stringWithFormat:@"%@",dict[@"beLongToVIP"]];
                model.elecnum = [NSString stringWithFormat:@"%@",dict[@"product"][@"elecnum"]];
                model.productID = [NSString stringWithFormat:@"%@",dict[@"product"][@"id"]];
                model.oldprice = [NSString stringWithFormat:@"%@",dict[@"product"][@"oldprice"]];
                model.price = [NSString stringWithFormat:@"%@",dict[@"product"][@"price"]];
                model.productname = [NSString stringWithFormat:@"%@",dict[@"product"][@"productname"]];
                if ([dict[@"product"][@"productphotos"] count] > 0) {
                    model.productphotos = [NSString stringWithFormat:@"%@%@",HTTPUrl,dict[@"product"][@"productphotos"][0][@"photo"]];
                }else {
                    model.productphotos = @"";
                }
                
                [_dataArray addObject:model];
            }
            if (dataArr.count < 20) {
                is_noMore = YES;
            }else
            {
                is_noMore = NO;
            }
            
        }
        [_detailClassTable reloadData];
        [hud hideAnimated:YES];
        [self endRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@",error);
        [self endRefresh];
        [hud hideAnimated:YES];
    }];
    
    
    //    }
    
}
//- (void)httpRequest {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer new];
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//
//    [manager.requestSerializer setValue:@"application/json"
//                     forHTTPHeaderField:@"Content-Type"];
//    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/ProductManager/getProductOfCategory/",_categoryId];
//
//    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"成功=%@",responseObject[@"data"]);
//        detailClassDataArr = [NSMutableArray arrayWithArray:responseObject[@"data"]];
//        if (detailClassDataArr.count > 0) {
//            [_detailClassTable reloadData];
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败=%@",error);
//    }];
//
//
//}

- (void)initClassTableView {
    
    _detailClassTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+47, KWIDTH, KHEIGHT-47-64) style:UITableViewStylePlain];
    _detailClassTable.delegate = self;
    _detailClassTable.dataSource = self;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 1)];
    _detailClassTable.tableFooterView = line;
    _detailClassTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _detailClassTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self createData:NO];
    }];
    _detailClassTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self createData:YES];
    }];
    [self.view addSubview:_detailClassTable];
    
    
}
- (void)initNav {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 47)];
    headView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"销量",@"价格",@"评价",@"积分"];//,@"筛选"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(KWIDTH-20)/4*i, 10, KWIDTH/6, 20);
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberTableViewCell *cell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:giftCellID];
    if (!cell) {
        cell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:giftCellID];
    }
//
//    if (detailClassDataArr.count > 0) {
//        NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,detailClassDataArr[indexPath.row][@"productphotos"][0][@"photo"]];
//        NSURL *url = [NSURL URLWithString:urlStr];
//        [cell.giftImage sd_setImageWithURL:url];
//
//        cell.giftNameLabel.text = [NSString stringWithFormat:@"%@",detailClassDataArr[indexPath.row][@"productname"]];
//        cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",detailClassDataArr[indexPath.row][@"price"]];
//
//        NSString *number = [NSString stringWithFormat:@"%@",detailClassDataArr[indexPath.row][@"elecnum"]];
//        int miniteNumber = [number intValue];
//
//        double showNumber = (double)miniteNumber/(double)2;
//
//        cell.miniteLabel.text = [NSString stringWithFormat:@"%.2lf",showNumber];
//    }
    if (_dataArray.count != 0) {
        DetailClassModel *model = [[DetailClassModel alloc] init];
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
        NSLog(@"======%@",model.beLongToVIP);
        if ([model.beLongToVIP intValue] == 0) {
            cell.redpacker.hidden = YES;
        }else {
            cell.redpacker.text = [NSString stringWithFormat:@"积分：%@",model.elecnum];
        }
        
        cell.miniteLabel.attributedText = strMatt;
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (void)titleLableButtonClick:(UIButton *)sender {
    CGFloat labelWidth = [sender.titleLabel.text sizeWithFont:sender.titleLabel.font].width;
    //    CGFloat lineX = (sender.frame.size.width-[sender.titleLabel.text sizeWithFont:sender.titleLabel.font].width)/2+KWIDTH/5*(sender.tag-200)+11;
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
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailClassModel *model = [[DetailClassModel alloc] init];
    model = _dataArray[indexPath.row];
    
    DetailViewController *shopVC = [DetailViewController new];
    shopVC.productId = model.productID;
    [self.navigationController pushViewController:shopVC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 开始进入刷新状态
- (void)endRefresh
{
    [_detailClassTable.mj_header endRefreshing];
    
    if (is_noMore == YES) {
        [_detailClassTable.mj_footer endRefreshingWithNoMoreData];
//        _detailClassTable.mj_footer.hidden = YES;
    }else {
        [_detailClassTable.mj_footer endRefreshing];
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
