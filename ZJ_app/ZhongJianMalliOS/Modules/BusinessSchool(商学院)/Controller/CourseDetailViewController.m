//
//  CourseDetailViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CDListViewController.h"
#import "CDLecturerViewController.h"
#import "CDIntroductionViewController.h"
#import "BusinessSignUpViewController.h"
#import "ZJScrollPageView.h"
#import "SDCycleScrollView.h"

#import "BusniessDetailMainLogic.h"
#import "BusniessDetailMainModel.h"

@interface CourseDetailViewController ()<ZJScrollPageViewDelegate,SDCycleScrollViewDelegate,BusniessDetailMainLogicDelegate>


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

@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    self.title = @"课程详情";
    
    self.childVcs = [self setupChildVcs];
    [self initUI];
    
    [self requestDetailMainData];
}

#pragma mark ============ request data ============
- (void)requestDetailMainData {
    
    BusniessDetailMainLogic *logic = [[BusniessDetailMainLogic alloc] init];
    logic.delegate = self;
    [logic requestDetailMainDataWithCourseId:@"1"];
}

#pragma mark ----- logic delegate -------
- (void)busniessDetailMainRequestCompleted:(BusniessDetailMainModel *)model {
    
    NSMutableArray *photos = [NSMutableArray array];
    for (PhotoModel *pic in model.coursePhotos) {
        NSString *str = [NSString stringWithFormat:@"%@%@",HTTPUrl,pic.photo];
        NSURL *url = [NSURL URLWithString:str];
        [photos addObject:url];
    }
    self.cycleView.imageURLStringsGroup = photos;
    
    
    self.centerNameL.text = model.coursename;
    self.priceL.text = [NSString stringWithFormat:@"￥ %@",model.courseprice];
    if ([[NSString stringWithFormat:@"%ld",model.curstatus] isEqualToString:@"1"]) {
        self.signUpButton.backgroundColor = [UIColor lightGrayColor];
        [self.signUpButton setTitle:@"未开讲" forState:UIControlStateNormal];
        self.signUpButton.enabled = NO;
    } else {
        
        BusniessDetailMainLogic *logic = [[BusniessDetailMainLogic alloc] init];
        logic.delegate = self;
        [logic requestCourseIsSignUp:[NSString stringWithFormat:@"%d",model.identification]];
    }
    
}

- (void)busniessCouresIsSignup:(BOOL)isSignup {

#pragma error 测试阶段
    isSignup = NO;
    
    if (isSignup) {
        self.signUpButton.backgroundColor = [UIColor blueColor];
        [self.signUpButton setTitle:@"已经报名" forState:UIControlStateNormal];
        self.signUpButton.enabled = NO;
    } else {
        self.signUpButton.backgroundColor = [UIColor blueColor];
        [self.signUpButton setTitle:@"我要报名" forState:UIControlStateNormal];
        self.signUpButton.enabled = YES;
    }
}

#pragma mark ============ UI ============

- (NSArray *)setupChildVcs {
    
    CDIntroductionViewController *introdVC = [[CDIntroductionViewController alloc] init];
    CDLecturerViewController *lectuerVC = [[CDLecturerViewController alloc] init];
    CDListViewController *listVC = [[CDListViewController alloc] init];
    
    NSArray *arr = @[introdVC,lectuerVC,listVC];
    
    return arr;
}

- (void)initUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupHeaderView];
    [self setupSegmentView];
    [self setupContentView];
    [self setupBottomView];
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
    
    NSArray *titles = @[@"简介",@"讲师",@"目录"];
    
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 240, self.view.width, 25) segmentStyle:style delegate:self titles:titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0) animated:YES];
    }];
    segment.backgroundColor = [UIColor whiteColor];
    self.segmentView = segment;
    [self.view addSubview:self.segmentView];
}

- (void)setupContentView {
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, 275, self.view.width, self.view.height) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
}

- (void)setupBottomView {
    
    UIButton *bottomButton = [[UIButton alloc] init];
    _signUpButton = bottomButton;
    bottomButton.backgroundColor = [UIColor lightGrayColor];
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
    
//    UIView *bottomView = [[UIView alloc] init];
//    _signView = bottomView;
//    bottomView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:bottomView];
//    __weak typeof(self) weakSelf = self;
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
//        make.height.mas_equalTo(40);
//        make.left.mas_equalTo(weakSelf.view.mas_left);
//        make.right.mas_equalTo(weakSelf.view.mas_right);
//    }];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wantSignUp:)];
//    [bottomView addGestureRecognizer:tap];
//
//    UILabel *signUpLabel = [[UILabel alloc] init];
//    _signLable = signUpLabel;
//    signUpLabel.textAlignment = NSTextAlignmentCenter;
//    signUpLabel.textColor = [UIColor whiteColor];
//    signUpLabel.font = [UIFont systemFontOfSize:17];
//    signUpLabel.text = @"我要报名";
//    [bottomView addSubview:signUpLabel];
//    [signUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(bottomView.mas_centerX);
//        make.centerY.mas_equalTo(bottomView.mas_centerY);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(20);
//    }];
    
}

#pragma mark ============ 点击报名 ============
- (void)wantSignUp:(id)tap {
    NSLog(@"点击了报名");
    BusinessSignUpViewController *signUpVC = [[BusinessSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUpVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ============ 代理方法 ============
- (NSInteger)numberOfChildViewControllers {
    return 3;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController *childVc = reuseViewController;
    if (childVc == nil) {
        childVc = self.childVcs[index];
        
    }
    return childVc;
}


@end
