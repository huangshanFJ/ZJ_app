//
//  HeadImageCollection.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImageCollection : UICollectionReusableView

@property (nonatomic,strong)UIImageView *headImage;//头像
@property (nonatomic,strong)UILabel *membrelevelLabel;//会与等级
@property (nonatomic,strong)UILabel *nameLabel;//名字
@property (nonatomic,strong)UILabel *nameIDLabel;//ID

/*
 * 设置的回调
 */
@property (nonatomic,copy) dispatch_block_t newsButtonClickBlock;
/*
 * 头像的回调
 */
@property (nonatomic,copy) dispatch_block_t headButtonClickBlock;


@end
