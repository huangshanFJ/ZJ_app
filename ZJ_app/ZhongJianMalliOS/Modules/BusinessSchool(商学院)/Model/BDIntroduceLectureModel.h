//
//  BDIntroduceLectureModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lecture : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *headpic;
@property (nonatomic, copy) NSString *synopsis;

@end

@interface BDIntroduceLectureModel :NSObject

@property (nonatomic, strong) NSArray *lectures;

@end
