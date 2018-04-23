//
//  MyCourseViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyCourseViewController.h"
#import "MyCourseDetailViewController.h"
#import "ZJScrollPageView.h"

@interface MyCourseViewController () <ZJScrollPageViewDelegate>

@property (nonatomic, strong) NSArray *childVcs;
@property (nonatomic, strong) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) ZJContentView *contentView;

@end

@implementation MyCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    self.title = @"我的课程";
    self.navigationController.navigationBar.hidden = NO;

    self.childVcs = [self setupChildVcs];
    [self initUI];
    
}
#pragma mark ============ UI ============
- (NSArray *)setupChildVcs {
    MyCourseDetailViewController *detailVc_all = [[MyCourseDetailViewController alloc] init];
    detailVc_all.type = MyCoursesTypeALL;
    MyCourseDetailViewController *detailVc_wait = [[MyCourseDetailViewController alloc] init];
    detailVc_wait.type = MyCoursesTypeWait;
    MyCourseDetailViewController *detailVc_start = [[MyCourseDetailViewController alloc] init];
    detailVc_start.type = MyCoursesTypeStart;
    MyCourseDetailViewController *detailVc_over = [[MyCourseDetailViewController alloc] init];
    detailVc_over.type = MyCoursesTypeOver;

    NSArray *arr = @[detailVc_all,detailVc_wait,detailVc_start,detailVc_over];
    return arr;
}

- (void)initUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSegmentView];
    [self setupContentView];

}

- (void)setupSegmentView {
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.normalTitleColor = [UIColor colorWithHexString:@"444444"];
    style.selectedTitleColor = [UIColor colorWithHexString:@"444444"];
    style.scrollTitle = NO;
    style.showLine = YES;
    style.scrollLineColor = [UIColor blueColor];
    //    style.segmentHeight = 40;
    style.scrollContentView = NO;
    style.titleFont = [UIFont systemFontOfSize:13];
    
    NSArray *titles = @[@"全部",@"待开课",@"进行中",@"已结束"];
    
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 5, self.view.width, 35) segmentStyle:style delegate:self titles:titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0) animated:YES];
    }];
    segment.backgroundColor = [UIColor whiteColor];
    self.segmentView = segment;
    [self.view addSubview:self.segmentView];
}

- (void)setupContentView {
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, 42, self.view.width, self.view.height - 42) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
}


#pragma mark ============ ZJScrollPageViewDelegate ============
- (NSInteger)numberOfChildViewControllers {
    return self.childVcs.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
   
    MyCourseDetailViewController *childVc = (MyCourseDetailViewController *)reuseViewController;
    if (childVc == nil) {
        childVc = self.childVcs[index];
    }
    return childVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
