//
//  BusinessHomeSegmentModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusinessHomeSegmentModel.h"

@implementation BusinessHomeSegmentModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        
        self.name = dic[@"typename"];
        self.identification = dic[@"id"];
    }
    return self;
}

+ (instancetype)segmentModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc] initWithDictionary:dic];
}

@end
