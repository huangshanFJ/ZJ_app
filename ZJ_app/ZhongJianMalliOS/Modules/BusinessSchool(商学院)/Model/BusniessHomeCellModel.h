//
//  BusniessHomeCellModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusniessHomeCellModel : NSObject


@property (nonatomic, copy) NSString *identification;
@property (nonatomic, copy) NSString *coursename;
@property (nonatomic, copy) NSString *coursestartTime;
@property (nonatomic, copy) NSString *courseprice;
@property (nonatomic, copy) NSString *curstatus;
@property (nonatomic, copy) NSString *coursebrief;
@property (nonatomic, strong) NSArray *coursePhotos;



- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)busniesshomemodelWithDictionary:(NSDictionary *)dic;

@end
