//
//  MyCourseDetailCellModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
@property (nonatomic, copy) NSString *photo;
@end

@interface MyCourseDetailCellModel : NSObject

@property (nonatomic, copy) NSString *Identification;
@property (nonatomic, copy) NSString *coursename;
@property (nonatomic, copy) NSString *courseprice;
@property (nonatomic, copy) NSString *curstatus;
@property (nonatomic, copy) NSString *coursebrief;
@property (nonatomic, strong) NSArray *coursePhotos;

@end

@interface MyCourseModels : NSObject

@property (nonatomic, strong) NSArray *courses;

@end
