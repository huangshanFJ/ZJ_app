//
//  ZJPageViewController.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RootViewController.h"

@protocol ZJPageViewControllerDelegate <NSObject>
- (void)scrollViewIsScrolling:(UIScrollView *)scrollView;
@end

@interface ZJPageViewController : RootViewController

@property (nonatomic, weak) id <ZJPageViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@end
