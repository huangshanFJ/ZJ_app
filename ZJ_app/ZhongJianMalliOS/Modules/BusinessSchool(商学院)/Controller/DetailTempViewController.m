//
//  DetailTempViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DetailTempViewController.h"
#import "CDListViewController.h"
#import "CDLecturerViewController.h"
#import "CDIntroductionViewController.h"
#import "BusinessSignUpViewController.h"
#import "ZJScrollPageView.h"
#import "SDCycleScrollView.h"

#import "BusniessDetailMainLogic.h"
#import "BusniessDetailMainModel.h"

#import "ZJPageViewController.h"
#import "PersonalAccountBalanceLogic.h"

static CGFloat const segmentViewHeight = 44.0;
static CGFloat const navBarHeight = 0.0;
static CGFloat headViewHeight = 235.0;

NSString *const ZJParentTableViewDidLeaveFromTopNotification = @"ZJParentTableViewDidLeaveFromTopNotification";

@interface ZJCustomGestureTableView : UITableView
@end

@implementation ZJCustomGestureTableView
//返回YES同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}


@end

@interface DetailTempViewController () <ZJScrollPageViewDelegate,SDCycleScrollViewDelegate,BusniessDetailMainLogicDelegate,ZJPageViewControllerDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,PersonalAccountBalanceLogicDelegate>

@property (nonatomic, weak) UILabel *centerNameL;
@property (nonatomic, weak) UILabel *priceL;
//@property (nonatomic, weak) UIView *signView;
//@property (nonatomic, weak) UILabel *signLable;
@property (nonatomic, weak) UIButton *signUpButton;
@property (nonatomic, weak) ZJScrollPageView *scrollPage;
@property (nonatomic, strong) NSArray *childVcs;
@property (nonatomic, strong) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) ZJContentView *contentView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;

@property (nonatomic, strong) NSArray *scrollPhotos;


@property (nonatomic, strong) UIScrollView *childScrollView;
@property (nonatomic, strong) ZJCustomGestureTableView *customTable;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) BusniessDetailMainModel *bdMainModel;

@end

@implementation DetailTempViewController

static NSString *const CourseDetailVcCell = @"CourseDetailVcCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestDetailMainData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    self.title = @"课程详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.childVcs = [self setupChildVcs];
    [self.view addSubview:self.customTable];
    
    [self initUI];
    
//    [self requestDetailMainData];
}

#pragma ZJScrollPageViewDelegate 代理方法
- (NSInteger)numberOfChildViewControllers {
    return self.childVcs.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController *childVc = reuseViewController;
    if (childVc == nil) {
        childVc = self.childVcs[index];
        
    }
    return childVc;
}

#pragma mark  - ZJPageViewControllerDelegate
- (void)scrollViewIsScrolling:(UIScrollView *)scrollView {
    _childScrollView = scrollView;
    if (self.customTable.contentOffset.y < headViewHeight) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    }
    else {
        self.customTable.contentOffset = CGPointMake(0, headViewHeight);
        scrollView.showsVerticalScrollIndicator = YES;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.childScrollView && _childScrollView.contentOffset.y > 0) {
        self.customTable.contentOffset = CGPointMake(0, headViewHeight);
    }
    //禁止下拉
    if (scrollView.contentOffset.y <= 0) {
        CGPoint point = scrollView.contentOffset;
        point.y = 0;
        scrollView.contentOffset = point;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if ((offsetY < headViewHeight)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZJParentTableViewDidLeaveFromTopNotification object:nil];
    }
}

#pragma mark - uitableviewdelegate ,datasourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetailVcCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CourseDetailVcCell];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.contentView];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.segmentView;
}

#pragma mark - setter getter
- (ZJScrollSegmentView *)segmentView {
    if (_segmentView == nil) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.scrollTitle = NO;
        style.showLine = YES;
        style.selectedTitleColor = [UIColor colorWithHexString:@"6493ff"];
        style.scrollLineColor = [UIColor colorWithHexString:@"6493ff"];
        style.normalTitleColor = [UIColor colorWithHexString:@"444444"];
        style.titleFont = [UIFont systemFontOfSize:12];

        //    style.segmentHeight = 40;
        style.scrollContentView = NO;
        
        NSArray *titles;
        if (self.canApply == NO) {
            titles = @[@"简介"];
        } else {
            titles = @[@"简介",@"讲师",@"目录"];
        }
        
        __weak typeof(self) weakSelf = self;
        ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, navBarHeight + headViewHeight, self.view.bounds.size.width, segmentViewHeight) segmentStyle:style delegate:self titles:titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0) animated:YES];
        }];
        segment.backgroundColor = [UIColor whiteColor];
        _segmentView = segment;
    }
    return _segmentView;
}

- (ZJContentView *)contentView {
    if (_contentView == nil) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:self.view.bounds segmentView:self.segmentView parentViewController:self delegate:self];
        _contentView = content;
    }
    return _contentView;
}

- (UIView *)headView {
    if (_headView == nil) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headViewHeight)];
        _headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        
        CGRect frame = CGRectMake(0, 0, self.view.width, 190);
        self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:[UIImage imageNamed:@"placeHoderImage"]];
        self.cycleView.autoScrollTimeInterval = 5.;// 自动滚动时间间隔
        self.cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;// 翻页
        [SDCycleScrollView clearImagesCache];// 清除缓存。
        [_headView addSubview:self.cycleView];
        
        
        UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 190, self.view.width, 40)];
        centerView.backgroundColor = [UIColor whiteColor];
        [_headView addSubview:centerView];
        UILabel *centerNameL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        centerNameL.text = @"课程名称";
        centerNameL.font = [UIFont systemFontOfSize:13];
        centerNameL.textColor = [UIColor colorWithHexString:@"444444"];
        centerNameL.textAlignment = NSTextAlignmentLeft;
        [centerView addSubview:centerNameL];
        _centerNameL = centerNameL;
        UILabel *priceL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 160, 10, 150, 20)];
        priceL.text = @"￥ 298.00";
        priceL.font = [UIFont systemFontOfSize:13];
        priceL.textColor = [UIColor colorWithHexString:@"444444"];
        priceL.textAlignment = NSTextAlignmentRight;
        [centerView addSubview:priceL];
        _priceL = priceL;
        
        if (self.canApply == NO) {
            centerView.hidden = YES;
            headViewHeight = 195;
        } else {
            centerView.hidden = NO;
            headViewHeight = 235;
        }
    
    }
    return _headView;
}

- (ZJCustomGestureTableView *)customTable {
    if (!_customTable) {
        CGRect frame = CGRectMake(0, navBarHeight, self.view.bounds.size.width, self.view.bounds.size.height);
        ZJCustomGestureTableView *customTable = [[ZJCustomGestureTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        //设置tableView的headerView
        customTable.tableHeaderView = self.headView;
//        customTable.tableFooterView = [UIView new];
        customTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //设置cell行高位contentView高度
        customTable.rowHeight = self.contentView.bounds.size.height;
        customTable.delegate = self;
        customTable.dataSource = self;
        //设置tableview的sectionHeadHeight为segmentViewHeight
        customTable.sectionHeaderHeight = segmentViewHeight;
        customTable.showsVerticalScrollIndicator = false;
        _customTable = customTable;
    }
    return _customTable;
}

#pragma mark ============ request data ============
- (void)requestDetailMainData {
    
    BusniessDetailMainLogic *logic = [[BusniessDetailMainLogic alloc] init];
    logic.delegate = self;
    [logic requestDetailMainDataWithCourseId:self.courseid];
}

#pragma mark ----- logic delegate -------
- (void)busniessDetailMainRequestCompleted:(BusniessDetailMainModel *)model {
    
    self.bdMainModel = model;
    
    NSMutableArray *photos = [NSMutableArray array];
    for (PhotoModel *pic in model.coursePhotos) {
        NSString *str = [NSString stringWithFormat:@"%@%@",HTTPUrl,pic.photo];
        NSURL *url = [NSURL URLWithString:str];
        [photos addObject:url];
    }
    self.cycleView.imageURLStringsGroup = photos;
    
    
    self.centerNameL.text = model.coursename;
    self.priceL.text = [NSString stringWithFormat:@"￥ %@",model.courseprice];
    if ([model.curstatus isEqualToString:@"1"]) {
        self.signUpButton.backgroundColor = [UIColor lightGrayColor];
        [self.signUpButton setTitle:@"授课中" forState:UIControlStateNormal];
        self.signUpButton.enabled = NO;
    } else {
        
        BusniessDetailMainLogic *logic = [[BusniessDetailMainLogic alloc] init];
        logic.delegate = self;
        [logic requestCourseIsSignUp:model.identification];
    }
    
}

- (void)busniessCouresIsSignup:(BOOL)isSignup {
    
    if (isSignup) {
        self.signUpButton.backgroundColor = [UIColor lightGrayColor];
        [self.signUpButton setTitle:@"已经报名" forState:UIControlStateNormal];
        self.signUpButton.enabled = NO;
    } else {
        self.signUpButton.backgroundColor = [UIColor colorWithHexString:@"6493ff"];
        [self.signUpButton setTitle:@"我要报名" forState:UIControlStateNormal];
        self.signUpButton.enabled = YES;
    }
}

#pragma mark ============ UI ============

- (NSArray *)setupChildVcs {
    
    NSMutableArray *childVcs = [NSMutableArray array];
    CDIntroductionViewController *introdVC = [[CDIntroductionViewController alloc] init];
    introdVC.courseid = self.courseid;
    [childVcs addObject:introdVC];
    
    if (self.canApply != NO) {
        CDLecturerViewController *lectuerVC = [[CDLecturerViewController alloc] init];
        lectuerVC.courseid = self.courseid;
         [childVcs addObject:lectuerVC];
        CDListViewController *listVC = [[CDListViewController alloc] init];
        listVC.courseid = self.courseid;
        [childVcs addObject:listVC];
    }
    
    NSArray *arr = [NSArray arrayWithArray:childVcs];
    
    return arr;
}

- (void)initUI {
    
//    [self setupHeaderView];
//    [self setupSegmentView];
//    [self setupContentView];
    if (self.canApply != NO) {
        [self setupBottomView];
    }
    
}

- (void)setupHeaderView {
    
    CGRect frame = CGRectMake(0, 0, self.view.width, 190);
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:[UIImage imageNamed:@"placeHoderImage"]];
    self.cycleView.autoScrollTimeInterval = 5.;// 自动滚动时间间隔
    self.cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;// 翻页
    [SDCycleScrollView clearImagesCache];// 清除缓存。
    [self.view addSubview:self.cycleView];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 190, self.view.width, 40)];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    UILabel *centerNameL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    centerNameL.text = @"课程名称";
    centerNameL.textAlignment = NSTextAlignmentLeft;
    [centerView addSubview:centerNameL];
    _centerNameL = centerNameL;
    UILabel *priceL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 160, 10, 150, 20)];
    priceL.text = @"￥ 298.00";
    priceL.textAlignment = NSTextAlignmentRight;
    [centerView addSubview:priceL];
    _priceL = priceL;
    
}

- (void)setupSegmentView {
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.scrollTitle = NO;
    style.showLine = YES;
    style.scrollLineColor = [UIColor blueColor];
    //    style.segmentHeight = 40;
    style.scrollContentView = NO;
    style.titleFont = [UIFont systemFontOfSize:13];
    
    NSArray *titles;
    if (self.canApply == NO) {
        titles = @[@"简介"];
    } else {
        titles = @[@"简介",@"讲师",@"目录"];
    }
    
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, headViewHeight, self.view.width, 25) segmentStyle:style delegate:self titles:titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0) animated:YES];
    }];
    segment.backgroundColor = [UIColor whiteColor];
    self.segmentView = segment;
    [self.view addSubview:self.segmentView];
}

- (void)setupContentView {
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, headViewHeight + 5, self.view.width, self.view.height) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
}

- (void)setupBottomView {
    
    UIButton *bottomButton = [[UIButton alloc] init];
    _signUpButton = bottomButton;
    bottomButton.backgroundColor = [UIColor colorWithHexString:@"6493ff"];
    [bottomButton setTitle:@"我要报名" forState:UIControlStateNormal];
    bottomButton.enabled = NO;
    [self.view addSubview:bottomButton];
    __weak typeof(self) weakSelf = self;
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
    }];
    [bottomButton addTarget:self action:@selector(wantSignUp:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark ============ 点击报名 ============
- (void)wantSignUp:(id)tap {
    NSLog(@"点击了报名");

//先判断账号是否异常
    [self requestPersonalAccountBalance];

}

- (void)requestPersonalAccountBalance {
    
    PersonalAccountBalanceLogic *logic = [[PersonalAccountBalanceLogic alloc] init];
    logic.delegate = self;
    [logic getPersonalAccountBalance];
    
}

- (void)getPersonalAccountCompletedWithErrorMessage:(NSString *)message {
    [MBProgressHUD showErrorMessage:message];
}

- (void)getPersonalAccountBalanceCompletedWithRemainElecNum:(NSString *)elecNum {
    
    BusinessSignUpViewController *signUpVC = [[BusinessSignUpViewController alloc] init];
    //    [signUpVC setViewDataWith:self.bdMainModel];
    signUpVC.elecNum = elecNum;
    signUpVC.model = self.bdMainModel;
    [self.navigationController pushViewController:signUpVC animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
