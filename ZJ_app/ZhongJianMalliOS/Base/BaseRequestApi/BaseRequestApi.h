//
//  BaseRequestApi.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YTKRequest.h"

@interface BaseRequestApi : YTKRequest

@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, copy) NSString *error_message;
@property (nonatomic, copy) NSString *error_code;
@property (nonatomic, copy) NSDictionary *result;
//@property (nonatomic, copy) NSDictionary *bodyDatatemp;

@end
