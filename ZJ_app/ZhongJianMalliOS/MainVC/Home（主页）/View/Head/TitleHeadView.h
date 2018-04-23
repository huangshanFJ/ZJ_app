//
//  TitleHeadView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleHeadView : UICollectionReusableView

@property (nonatomic,strong)UILabel *titleShowLabel;


/*
 * 表头的回调
 */
@property (nonatomic,copy) dispatch_block_t headButtonClickBlock;

@end
