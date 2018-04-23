//
//  BusinessHomeSegmentModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessHomeSegmentModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *identification;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)segmentModelWithDictionary:(NSDictionary *)dic;

@end
