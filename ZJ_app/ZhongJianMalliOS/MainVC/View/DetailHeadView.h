//
//  DetailHeadView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeadView : UIView

@property (nonatomic,strong) UILabel *shopClassLabel;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UILabel *praiseLabel;
/*
 * 返回的回调
 */
@property (nonatomic,copy) dispatch_block_t selectedButtonClickNextBlock;

@end
