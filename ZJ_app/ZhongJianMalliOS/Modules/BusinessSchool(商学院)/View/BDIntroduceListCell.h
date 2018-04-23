//
//  BDIntroduceListCell.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntroduceList;
@interface BDIntroduceListCell : UITableViewCell

- (void)updateIntroduceLstWithList:(IntroduceList *)model;

@end
