//
//  ChangeTableCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeTableCell : UITableViewCell

@property (nonatomic,strong)UILabel *changeNameLabel;//
//@property (nonatomic,strong)UIButton *headImageButton;//头像
@property (nonatomic,strong)UIImageView *nextImage;//
@property (nonatomic,strong)UILabel *detailNameLabel;//姓名
@property (nonatomic,strong)UILabel *numberLabel;//众健号
@property (nonatomic,strong)UITextField *changeTextField;//输入框

/*
 *  选中照片的回调
 */
@property (nonatomic,copy) dispatch_block_t selectedPhotoButtonClick;



@end
