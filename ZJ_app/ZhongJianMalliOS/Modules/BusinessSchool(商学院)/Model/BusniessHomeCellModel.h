//
//  BusniessHomeCellModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePhotoModel.h"

@interface BusniessHomeCellModel : BasePhotoModel

//@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *coursename;
@property (nonatomic, copy) NSString *courseprice;
@property (nonatomic, copy) NSString *curstatus;
@property (nonatomic, copy) NSString *coursebrief;
//@property (nonatomic, strong) NSArray *coursePhotos;
@property (nonatomic, assign) BOOL canApply;

@end
