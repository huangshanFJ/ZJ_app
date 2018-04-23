//
//  ZJPageViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJPageViewController.h"

@interface ZJPageViewController ()<UIScrollViewDelegate>

@end

@implementation ZJPageViewController

extern NSString *const ZJParentTableViewDidLeaveFromTopNotification;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leaveFromTop) name:ZJParentTableViewDidLeaveFromTopNotification object:nil];
    
}

- (void)leaveFromTop {
    _scrollView.contentOffset = CGPointZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = scrollView;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewIsScrolling:)]) {
        [self.delegate scrollViewIsScrolling:scrollView];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
