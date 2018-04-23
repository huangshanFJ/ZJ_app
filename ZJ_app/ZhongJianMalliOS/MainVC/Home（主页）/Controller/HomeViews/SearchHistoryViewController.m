//
//  SearchHistoryViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SearchHistoryViewController.h"
#import "MemberTableViewCell.h"
#import "SearchModel.h"
#import "DetailViewController.h"
@interface SearchHistoryViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *dataArray;
    UIView *noDataImageview;
}
@property (nonatomic,strong)UITableView *searchHistoryTable;

@end
static NSString *MemberTableViewCellID = @"MemberTableViewCell";
@implementation SearchHistoryViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    dataArray = [NSMutableArray arrayWithCapacity:0];
    noDataImageview = [[UIView alloc] init];
    [self configNav];
    [self configView];
    
    [self requestData];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/ProductManager/searchProduct"];
    NSDictionary *dic = @{
                          @"key":_showText
                          };
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *dataArr = [NSArray arrayWithArray:responseObject[@"data"]];
        if (dataArr.count > 0) {
            for (NSDictionary *dict in dataArr) {
                SearchModel *model = [[SearchModel alloc] init];
                model.ElecNum = [NSString stringWithFormat:@"%@",dict[@"product"][@"elecnum"]];
                model.OldPrice = [NSString stringWithFormat:@"%@",dict[@"product"][@"oldprice"]];
                if ([dict[@"product"][@"productphotos"] count] > 0) {
                      model.Photo = [NSString stringWithFormat:@"%@%@",HTTPUrl,dict[@"product"][@"productphotos"][0][@"photo"]];
                }else {
                    model.Photo = @"";
                }
              
                model.Price = [NSString stringWithFormat:@"%@",dict[@"product"][@"price"]];
                model.ProductName = [NSString stringWithFormat:@"%@",dict[@"product"][@"productname"]];
                model.Tag = [NSString stringWithFormat:@"%@",dict[@"product"][@"tag"]];
                model.Id = [NSString stringWithFormat:@"%@",dict[@"product"][@"id"]];
                model.beLongToVIP = [NSString stringWithFormat:@"%@",dict[@"beLongToVIP"]];
                [dataArray addObject:model];
            }
        }
        if (dataArray.count == 0) {
//
        }else {
//
        }
        [_searchHistoryTable reloadData];
        
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
 
}
- (void)initWithNilView {
    noDataImageview.frame = CGRectMake(0, 104, KWIDTH, KHEIGHT-104);
    noDataImageview.tag = 1111;
    
    [self.view addSubview:noDataImageview];
    UIImageView *noDataImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-104)];
//    noDataImage.image = [UIImage imageNamed:@"圆角矩形1"];
    //    noDataImage.hidden
    [noDataImageview addSubview:noDataImage];
    
    
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
    title.text = @"搜索";
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
- (void)configView {
    
    _searchHistoryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _searchHistoryTable.delegate = self;
    _searchHistoryTable.dataSource = self;
    _searchHistoryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_searchHistoryTable];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberTableViewCell *cell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MemberTableViewCellID];
    if (!cell) {
        cell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MemberTableViewCellID];
    }
    if (dataArray.count != 0) {
        SearchModel *model = [[SearchModel alloc] init];
        model = dataArray[indexPath.row];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",model.Price]];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:11.0]
                              range:NSMakeRange(0, 2)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:17]
                              range:NSMakeRange(2, model.Price.length)];
        cell.priceLabel.textColor = [UIColor colorWithHexString:@"ff3a00"];
        cell.priceLabel.attributedText = AttributedStr;
        [cell.giftImage sd_setImageWithURL:[NSURL URLWithString:model.Photo]];
        cell.giftNameLabel.text = model.ProductName;
        
        int miniteNumber = [model.ElecNum intValue];
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
            cell.redpacker.text = [NSString stringWithFormat:@"积分：%@",model.ElecNum];
        }
        
        cell.miniteLabel.attributedText = strMatt;
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchModel *model = [[SearchModel alloc] init];
    model = dataArray[indexPath.row];
   
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.productId = model.Id;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
