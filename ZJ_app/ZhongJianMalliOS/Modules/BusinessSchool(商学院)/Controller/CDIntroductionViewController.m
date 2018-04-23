//
//  CDIntroductionViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CDIntroductionViewController.h"
#import "CDIntroductionMainLogic.h"
#import "BDIntroductionMainModel.h"
#import "RootWebViewController.h"

@interface CDIntroductionViewController ()<CDIntroductionMainLogicDelegate,UIWebViewDelegate>

@property (nonatomic, weak) UILabel *timeL;
@property (nonatomic, weak) UILabel *locationL;

@property (nonatomic, weak) UILabel *srcTitleL;

@property (nonatomic, copy) NSString *srcStr;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation CDIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    [self requestIntroduceMainData];
    [self initUI];
    
}

- (void)requestIntroduceMainData {
    
    CDIntroductionMainLogic *logic = [[CDIntroductionMainLogic alloc] init];
    logic.delegate = self;
    [logic requestIntroductionMainDataWithCourseid:self.courseid];
}

- (void)initUI {
    
    [self setupCenterView];
    [self setupIntroduceView];
}

- (void)setupCenterView {
    
    UIView *centerV = [[UIView alloc] init];
    centerV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerV];
    centerV.frame = CGRectMake(0, 5, self.view.width, 55);
    
    UILabel *timeL = [[UILabel alloc] init];
    [centerV addSubview:timeL];
    timeL.text = @"开课时间:";
    timeL.textColor = [UIColor colorWithHexString:@"444444"];
    timeL.font = [UIFont systemFontOfSize:12];
    timeL.textAlignment = NSTextAlignmentLeft;
    _timeL = timeL;
    UILabel *locationL = [[UILabel alloc] init];
    [centerV addSubview:locationL];
    locationL.text = @"开课地点:";
    locationL.textColor = [UIColor colorWithHexString:@"444444"];
    locationL.font = [UIFont systemFontOfSize:12];
    locationL.textAlignment = NSTextAlignmentLeft;
    _locationL = locationL;
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(centerV.mas_left).offset(10);
        make.top.mas_equalTo(centerV.mas_top).offset(10);
        make.width.mas_equalTo(centerV.mas_width);
        make.height.mas_equalTo(15);
    }];
    [locationL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeL.mas_left);
        make.top.mas_equalTo(timeL.mas_bottom).offset(5);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(centerV.mas_width);
    }];
    
}

- (void)setupIntroduceView {
    
//    UIView *introduceView = [[UIView alloc] initWithFrame:CGRectMake(0, 52, self.view.width, self.view.height - 52 - 275 - 40)];
    UIView *introduceView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.width, self.view.height)];
    introduceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:introduceView];
    UILabel *introduceL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.width, 40)];
    introduceL.text = @"课程图文介绍";
    introduceL.textColor = [UIColor colorWithHexString:@"444444"];
    introduceL.textAlignment = NSTextAlignmentLeft;
    [introduceView addSubview:introduceL];
    _srcTitleL = introduceL;
    UITapGestureRecognizer *tapRecognizerSrc=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openURL:)];
    introduceL.userInteractionEnabled=YES;
    [introduceL addGestureRecognizer:tapRecognizerSrc];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, introduceView.frame.size.height)];
    web.scrollView.showsVerticalScrollIndicator = NO;
//    web.scrollView.scrollEnabled = NO;
    //协议://域名:端口   +   /html/courseDetails.html?courseid=  +  课程id  （课程图文详情
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/html/courseDetails.html?courseid=",self.courseid];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [introduceView addSubview:web];
//    web.delegate = self;
    _webView = web;
    
}

#pragma mark ============ logic deledate ============
- (void)requestIntroductionMainDataCompleted:(BDIntroductionMainModel *)model {
    
    self.timeL.text = [NSString stringWithFormat:@"开课时间:%@",model.course.coursestarttime];
    self.locationL.text = [NSString stringWithFormat:@"开课地点:%@",model.course.coursesite];
    
    if (model.coursedatalist.count > 0) {
        CourseList *list = model.coursedatalist[0];
        self.srcTitleL.text = list.title;
        self.srcStr = list.src;
    } else {
//        self.srcTitleL.text = @"";
    }
}

//课程详细介绍
- (void)openURL:(id)tap {
    
    //"/html/courseData.html?id=1"
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,self.srcStr];
    RootWebViewController *web = [[RootWebViewController alloc] initWithUrl:urlStr];
    [self.navigationController pushViewController:web animated:YES];

}

#pragma mark ============ webviewdelegate ============
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
//    self.webView.frame = CGRectMake(0, 40, self.view.width, height);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
