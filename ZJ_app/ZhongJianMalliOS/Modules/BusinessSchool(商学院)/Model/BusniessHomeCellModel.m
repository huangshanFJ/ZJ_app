//
//  BusniessHomeCellModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusniessHomeCellModel.h"

@implementation BusniessHomeCellModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        
        self.identification = dic[@"id"];
        self.coursename = dic[@"coursename"];
        self.coursestartTime = dic[@"coursestartTime"];
        self.courseprice = dic[@"courseprice"];
        self.curstatus = dic[@"curstatus"];
        self.coursebrief = dic[@"coursebrief"];
        self.coursePhotos = dic[@"coursePhotos"];
        
    }
    return self;
}

+ (instancetype)busniesshomemodelWithDictionary:(NSDictionary *)dic {
    return [[self alloc] initWithDictionary:dic];
}

@end
