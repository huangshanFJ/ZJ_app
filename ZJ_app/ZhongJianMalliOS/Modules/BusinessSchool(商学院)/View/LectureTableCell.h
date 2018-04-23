//
//  LectureTableCell.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Lecture;
@interface LectureTableCell : UITableViewCell

- (void)updateLectureCellWithModel:(Lecture *)model;

+ (CGFloat)cell_heightForModel:(Lecture *)model;

@end
