//
//  BusniessDetailMainModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface PhotoModel : NSObject

@property (nonatomic, copy) NSString *photo;

@end

@interface CourseTypeBean : NSObject

@property (nonatomic, copy) NSString *typeName;

@end

@interface BusniessDetailMainModel : NSObject

@property (nonatomic, copy) NSString *identification;
@property (nonatomic, copy) NSString *coursename;
@property (nonatomic, copy) NSString *coursestarttime;
@property (nonatomic, copy) NSString *coursesite;
@property (nonatomic, copy) NSString *courseprice;
@property (nonatomic, copy) NSString *curstatus;
@property (nonatomic, copy) NSString *coursebrief;
@property (nonatomic, copy) NSString *coursetype;
@property (nonatomic, strong) CourseTypeBean *courseTypeBean;
@property (nonatomic, strong) NSArray *coursePhotos;

@end



