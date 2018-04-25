//
//  BasePhotoModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface Photo : NSObject

@property (nonatomic, copy) NSString *photo;

@end


@interface BasePhotoModel : BaseModel

@property (nonatomic, strong) NSArray *coursePhotos;

@end
