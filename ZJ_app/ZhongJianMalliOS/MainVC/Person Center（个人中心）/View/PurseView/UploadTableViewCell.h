//
//  UploadTableViewCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *kindNameLabel;
@property (nonatomic,strong)UIButton *identityButton;
@property (nonatomic,strong)UIButton *deleteButtonOne;
@property (nonatomic,strong)UIButton *deleteButtonTwo;

/*
 * 第一个的回调
 */
@property (nonatomic,copy) dispatch_block_t selectedPhotoClick;
/*
 * 第二个的回调
 */
@property (nonatomic,copy) dispatch_block_t selectedIdentityClick;


@end
