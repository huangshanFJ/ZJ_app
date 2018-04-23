//
//  BusinessSchViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusinessSchViewController.h"
#import "ZJScrollPageView.h"
#import "SDCycleScrollView.h"

#import "BusinessSchHomeLogic.h"
#import "BusinessHomeSegmentModel.h"

#import "BusinessSegmentChildVC.h"


@interface BusinessSchViewController ()<BusinessSchHomeLogicDelegate,ZJScrollPageViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIImageView *bigImgView;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
//@property (nonatomic, strong) SDCycleScrollView *cycleView;

@property (nonatomic, strong) NSArray *segments;
@property (nonatomic, copy) NSString *picUrl;

@end

@implementation BusinessSchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    self.title = @"商学院";
    
    [self requestData];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark --------- request Data
- (void)requestData {
    
    [MBProgressHUD showActivityMessageInView:@"数据加载中"];
    BusinessSchHomeLogic *logic = [[BusinessSchHomeLogic alloc] init];
    logic.delegate = self;
    [logic requestBusinessSchHomepageData];
    
}

#pragma mark ============ UI ============
- (void)initUI {
    
    [self setBigHeaderImgView];
    [self setScrollpageView];
    
}

- (void)setBigHeaderImgView {
    
    CGRect frame = CGRectMake(0, 7, self.view.width, 188);
    self.bigImgView = [[UIImageView alloc] initWithFrame:frame];
    [self.bigImgView setImageWithURL:[NSURL URLWithString:self.picUrl] placeholder:[UIImage imageNamed:@"placeHoderImage"]];
    [self.view addSubview:self.bigImgView];
    
}

- (void)setScrollpageView {
    
    NSMutableArray *titles = [NSMutableArray array];
    for (BusinessHomeSegmentModel *segment in self.segments) {
        [titles addObject:segment.name];
    }
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.normalTitleColor = [UIColor colorWithHexString:@"444444"];
    style.selectedTitleColor = [UIColor colorWithHexString:@"6493ff"];
    style.scrollLineColor = [UIColor colorWithHexString:@"6493ff"];
    style.scrollTitle = NO;
    style.showLine = YES;
    style.segmentHeight = 40;
    style.scrollContentView = NO;
    style.titleFont = [UIFont systemFontOfSize:13];
    CGRect scrollPageViewFrame = CGRectMake(0, 202, self.view.width, self.view.height - 202);
    self.scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:titles parentViewController:self delegate:self];
    [self.view addSubview:self.scrollPageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

#pragma mark ============ delegate ============
- (NSInteger)numberOfChildViewControllers {
    return self.segments.count;// 传入页面的总数, 推荐使用titles.count
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    BusinessSegmentChildVC *childVc = (BusinessSegmentChildVC *)reuseViewController;
    // 这里一定要判断传过来的是否是nil, 如果为nil直接使用并返回
    // 如果不为nil 就创建
    NSLog(@"%@",NSStringFromCGRect(self.scrollPageView.contentView.frame));
    if (childVc == nil) {
        childVc = [BusinessSegmentChildVC new];
        childVc.frame = self.scrollPageView.contentView.frame;
        childVc.type = index+1;
    }
    return childVc;
}



#pragma mark ============ logic delegate ============
- (void)requestBusinessSchHomepageDataCompletedSegment:(NSArray *)segments picture:(NSString *)picurl {
    
    self.segments = segments;
    self.picUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,picurl];
    
    //加载UI
    [self initUI];

}

@end
