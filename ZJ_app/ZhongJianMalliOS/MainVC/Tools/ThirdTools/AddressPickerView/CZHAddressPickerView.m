//
//  CZHAddressPickerView.m
//  CZHAddressPickerView
//
//  Created by 程召华 on 2017/11/24.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHAddressPickerView.h"
#import "AddressPickerHeader.h"
#import "UIButton+CZHExtension.h"

#define TOOLBAR_BUTTON_WIDTH CZH_ScaleWidth(65)

typedef NS_ENUM(NSInteger, CZHAddressPickerViewButtonType) {
    CZHAddressPickerViewButtonTypeCancle,
    CZHAddressPickerViewButtonTypeSure
};

typedef NS_ENUM(NSInteger, CZHAddressPickerViewType) {
    //只显示省
    CZHAddressPickerViewTypeProvince = 1,
    //显示省份和城市
    CZHAddressPickerViewTypeCity,
    //显示省市区，默认
    CZHAddressPickerViewTypeArea
};

@interface CZHAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
///<#注释#>
@property (nonatomic, assign) NSInteger columnCount;
///容器view
@property (nonatomic, weak) UIView *containView;
///
@property(nonatomic, strong) UIPickerView * pickerView;
///省
@property(nonatomic, strong) NSArray * provinceArray;
@property (nonatomic,strong) NSArray *provinceIDArray;
///市
@property(nonatomic, strong) NSArray * cityArray;
@property (nonatomic,strong) NSArray *cityIDArray;

///区
@property(nonatomic, strong) NSMutableArray * areaArray;
@property (nonatomic,strong) NSMutableArray *areaIDArray;
///所有数据
@property(nonatomic, strong) NSArray * dataSource;
///记录省选中的位置
@property(nonatomic, assign) NSInteger selectProvinceIndex;
///记录省id选中的位置
@property(nonatomic, assign) NSInteger selectProvinceIDIndex;

//显示类型
@property (nonatomic, assign) CZHAddressPickerViewType showType;
///传进来的默认选中的省
@property(nonatomic, strong) NSString * selectProvince;
@property(nonatomic,strong) NSString *selectProvinceID;
///传进来的默认选中的市
@property(nonatomic, strong) NSString * selectCity;

@property(nonatomic,strong) NSString *selectCityID;

///传进来的默认选中的区
@property(nonatomic, strong) NSString * selectArea;

@property(nonatomic,strong) NSString *selectAreaID;

///省份回调
@property (nonatomic, copy) void (^provinceBlock)(NSString *province);
///城市回调
@property (nonatomic, copy) void (^cityBlock)(NSString *province, NSString *city);
///区域回调
@property (nonatomic, copy) void (^areaBlock)(NSString *province, NSString *provinceID, NSString *city,NSString *cityID, NSString *area, NSString *areaID);


@end


@implementation CZHAddressPickerView

/**
 * 只显示省份一级
 * provinceBlock : 回调省份
 */
//+ (instancetype)provincePickerViewWithProvinceBlock:(void(^)(NSString *province))provinceBlock {
//    return [CZHAddressPickerView addressPickerViewWithProvince:nil city:nil area:nil provinceBlock:provinceBlock cityBlock:nil areaBlock:nil showType:CZHAddressPickerViewTypeProvince];
//}

/**
 * 显示省份和市级
 * cityBlock : 回调省份和城市
 */
//+ (instancetype)cityPickerViewWithCityBlock:(void(^)(NSString *province, NSString *city))cityBlock {
//    return [CZHAddressPickerView addressPickerViewWithProvince:nil city:nil area:nil provinceBlock:nil cityBlock:cityBlock areaBlock:nil showType:CZHAddressPickerViewTypeCity];
//}

/**
 * 显示省份和市级和区域
 * areaBlock : 回调省份城市和区域
 */
//+ (instancetype)areaPickerViewWithAreaBlock:(void(^)(NSString *province, NSString *city, NSString *area))areaBlock {
//    return [CZHAddressPickerView addressPickerViewWithProvince:nil city:nil area:nil provinceBlock:nil cityBlock:nil areaBlock:areaBlock showType:CZHAddressPickerViewTypeArea];
//}

/**
 * 只显示省份一级
 * province : 传入了省份自动滚动到省份，没有传或者找不到默认选中第一个
 * provinceBlock : 回调省份
 */
//+ (instancetype)provincePickerViewWithProvince:(NSString *)province provinceBlock:(void(^)(NSString *province))provinceBlock {
//    return [CZHAddressPickerView addressPickerViewWithProvince:province city:nil area:nil provinceBlock:provinceBlock cityBlock:nil areaBlock:nil showType:CZHAddressPickerViewTypeProvince];
//}

/**
 * 显示省份和市级
 * province,city : 传入了省份和城市自动滚动到选中的，没有传或者找不到默认选中第一个
 * cityBlock : 回调省份和城市
 */
//+ (instancetype)cityPickerViewWithProvince:(NSString *)province city:(NSString *)city cityBlock:(void(^)(NSString *province, NSString *city))cityBlock {
//    return [CZHAddressPickerView addressPickerViewWithProvince:province city:city area:nil provinceBlock:nil cityBlock:cityBlock areaBlock:nil showType:CZHAddressPickerViewTypeCity];
//}

/**
 * 显示省份和市级和区域
 * province,city : 传入了省份和城市和区域自动滚动到选中的，没有传或者找不到默认选中第一个
 * areaBlock : 回调省份城市和区域
 */
+ (instancetype)areaPickerViewWithProvince:(NSString *)province provinceID:(NSString *)provinceID city:(NSString *)city cityID:(NSString *)cityID area:(NSString *)area areaID:(NSString *)areaID areaBlock:(void(^)(NSString *province, NSString *provinceID, NSString *city,NSString *cityID, NSString *area, NSString *areaID))areaBlock {
    return [CZHAddressPickerView addressPickerViewWithProvince:province provinceID:provinceID city:city  cityID:cityID area:area areaID:areaID provinceBlock:nil cityBlock:nil areaBlock:areaBlock showType:CZHAddressPickerViewTypeArea];
    
}




+ (instancetype)addressPickerViewWithProvince:(NSString *)province provinceID:(NSString *)provinceID city:(NSString *)city cityID:(NSString *)cityID area:(NSString *)area areaID:(NSString *)areaID provinceBlock:(void(^)(NSString *province))provinceBlock cityBlock:(void(^)(NSString *province, NSString *city))cityBlock areaBlock:(void(^)(NSString *province, NSString *provinceID, NSString *city,NSString *cityID, NSString *area, NSString *areaID))areaBlock  showType:(CZHAddressPickerViewType)showType {
    
    CZHAddressPickerView *_view = [[CZHAddressPickerView alloc] init];
    
    _view.showType = showType;
    
    _view.selectProvince = province;
    
    _view.selectCity = city;
    
    _view.selectArea = area;
    
    _view.selectProvinceID = provinceID;
    
    _view.selectCityID = cityID;
    
    _view.selectAreaID = areaID;
    
    _view.provinceBlock = provinceBlock;
    
    _view.cityBlock = cityBlock;
    
    _view.areaBlock = areaBlock;
    
    [_view czh_getData];
    
    [_view showView];
    
    return _view;
    
}



- (instancetype)init {
    if (self = [super init]) {
        
        [self czh_setView];
        
    }
    return self;
}



- (void)czh_setView {
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, CZH_ScaleHeight(270));
    [self addSubview:containView];
    self.containView = containView;
    
    
    UIView *toolBar = [[UIView alloc] init];
    toolBar.frame = CGRectMake(0, 0, ScreenWidth, CZH_ScaleHeight(55));
    toolBar.backgroundColor = CZHColor(0xf6f6f6);
    [containView addSubview:toolBar];
    
    UIButton *cancleButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(0, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHColor(0x666666) titleFont:CZHGlobelNormalFont(18) title:@"取消"];
    cancleButton.tag = CZHAddressPickerViewButtonTypeCancle;
    [toolBar addSubview:cancleButton];
    
    UIButton *sureButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(toolBar.czh_width - TOOLBAR_BUTTON_WIDTH, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHThemeColor titleFont:CZHGlobelNormalFont(18) title:@"确定"];
    sureButton.tag = CZHAddressPickerViewButtonTypeSure;
    [toolBar addSubview:sureButton];
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = CZHColor(0xffffff);
    pickerView.frame = CGRectMake(0, toolBar.czh_bottom, ScreenWidth, containView.czh_height - toolBar.czh_height);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [containView addSubview:pickerView];
    self.pickerView = pickerView;
    
}

//获取数据
- (void)czh_getData {
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"provinceData" ofType:@"json"]];
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    _dataSource = dataArray;
    
    NSMutableArray * tempArray = [NSMutableArray array];
    NSMutableArray *provinceID = [NSMutableArray array];
    
    for (int i = 0; i < dataArray.count; i++)
    {
        //TODO 为啥不判断 dataArray[i] = nil ?
        [tempArray addObject:dataArray[i][@"provincename"]];
        [provinceID addObject:dataArray[i][@"id"]];
    }
    //省
    self.provinceArray = [tempArray copy];
    self.provinceIDArray = [provinceID copy];
    
    //市
    _cityArray = [self getCityNamesFromProvinceIndex:0];
    _cityIDArray = [self getCityNamesFromProvinceIDIndex:0];
    //区
    _areaArray = [self getAreaNamesFromProvinceIndex:0 cityIndex:0];
    _areaIDArray = [self getAreaNamesFromProvinceIDIndex:0 cityIDIndex:0];
    
    //如果没有传入默认选中的省市区，默认选中各个数组的第一个
    if (!self.selectProvince.length) {
        self.selectProvince = [self.provinceArray firstObject];
        self.selectProvinceID = [self.provinceIDArray firstObject];
    }
    if (!self.selectCity.length) {
        self.selectCity = [self.cityArray firstObject];
        self.selectCityID = [self.cityIDArray firstObject];
    }
    if (!self.selectArea.length) {
        self.selectArea = [self.areaArray firstObject];
        self.selectAreaID = [self.areaIDArray firstObject];
    }
    
    
    NSInteger provinceIndex = 0;
    NSInteger cityIndex = 0;
    NSInteger areaIndex = 0;
    
    
    for (NSInteger p = 0; p < self.provinceArray.count; p++) {
        if ([self.provinceArray[p] isEqualToString:self.selectProvince]) {
            self.selectProvinceIndex = p;
            self.selectProvinceIDIndex = p;
            provinceIndex = p;
            self.cityArray = [self getCityNamesFromProvinceIndex:p];
            self.cityIDArray = [self getCityNamesFromProvinceIDIndex:p];
            for (NSInteger c = 0; c < self.cityIDArray.count; c++) {
                if ([self.cityIDArray[c] isEqualToString:self.selectCity]) {
                    cityIndex = c;
                    self.areaArray = [self getAreaNamesFromProvinceIndex:p cityIndex:c];
                    
                    self.areaIDArray = [self getAreaNamesFromProvinceIDIndex:p cityIDIndex:c];
                    for (NSInteger a = 0; a < self.areaIDArray.count; a++) {
                        if ([self.areaIDArray[a] isEqualToString:self.selectArea]) {
                            areaIndex = a;
                        }
                    }
                }
            }
        }
    }
    
    
    if (self.showType == CZHAddressPickerViewTypeProvince) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
    } else if (self.showType == CZHAddressPickerViewTypeCity) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:cityIndex inComponent:1 animated:YES];
    } else if (self.showType == CZHAddressPickerViewTypeArea) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
        //        [s]
        [self.pickerView selectRow:cityIndex inComponent:1 animated:YES];
        [self.pickerView selectRow:areaIndex inComponent:2 animated:YES];
    }
    
}
//- (NSArray *)getCityIDFromProvinceIndex:(NSInteger)provinceIDIndex  {
//    NSMutableArray * cityArray = [NSMutableArray array];
//    if (self.provinceArray.count > 0 && (provinceIDIndex < self.provinceArray.count) && (provinceIDIndex > 0 || provinceIDIndex == 0))
//    {
//        // 判端 dataSource.cout > 0
//        NSDictionary *citysDict = [[self dataSource] objectAtIndex:provinceIDIndex];
//        NSArray *citysArray = [citysDict objectForKey:@"citys"];
//        if (citysArray.count > 0)
//        {
//            for (NSDictionary *cityDict in citysArray)
//            {
//                //TODO cityDict 不为 nil 且不能为null
//                if (cityDict != nil )
//                {
//                    NSString *cityName = [NSString stringWithFormat:@"%@",[cityDict objectForKey:@"id"]];
//                    ////TODO cityName 不为 nil 且不能为null
//                    if (cityName.length > 0 && cityName)
//                    {
//                        [cityArray addObject:cityName];
//                    }
//                    else
//                    {
//                        continue;
//                    }
//                }
//                else
//                {
//                    continue;
//                }
//            }
//        }
//    }
//
//
//    return [cityArray copy];
//}
//- (NSArray *)getAreaIDFromProvinceIndex:(NSInteger)provinceIndex
//                              cityIndex:(NSInteger)cityIndex {
//    NSMutableArray * areaArray = [NSMutableArray array];
//    if (self.provinceArray.count > 0 && (provinceIndex < self.provinceArray.count) && (provinceIndex > 0 || provinceIndex == 0))
//    {
//        // 判端 dataSource.cout > 0
//        NSDictionary *citysDict = [[self dataSource] objectAtIndex:provinceIndex];
//        NSArray *citysArray = [citysDict objectForKey:@"citys"];
//        NSString *cityName = [self.cityArray objectAtIndex:cityIndex];
//        if (citysArray.count > 0)
//        {
//            for (NSDictionary *cityDict in citysArray)
//            {
//                //TODO cityDict 不为 nil 且不能为null
//                if (cityDict)
//                {
//
//                    NSString *cityname = [NSString stringWithFormat:@"%@",[cityDict objectForKey:@"id"]];
//                    if (cityName.length > 0 && cityname.length > 0)
//                    {
//                        if ([cityName isEqualToString:cityname] || [cityName containsString:cityname])
//                        {
//                            NSArray *regionsArray = [cityDict objectForKey:@"regions"];
//                            ////TODO cityName 不为 nil 且不能为null
//                            if (regionsArray > 0 && regionsArray)
//                            {
//                                for (NSDictionary *regionsDict in regionsArray)
//                                {
//                                    NSString *regionName = [regionsDict objectForKey:@"id"];
//                                    if (regionName.length > 0)
//                                    {
//                                        [areaArray addObject:regionName];
//                                    }
//                                    else
//                                    {
//                                        continue;
//                                    }
//
//                                }
//                            }
//                            else
//                            {
//                                continue;
//                            }
//                        }
//                        else
//                        {
//                            continue;
//                        }
//                    }
//
//                }
//                else
//                {
//                    continue;
//                }
//            }
//        }
//    }
//
//    return [areaArray copy];
//}
//获取plist区域数组
- (NSMutableArray *)getAreaNamesFromProvinceIndex:(NSInteger)provinceIndex
                                 cityIndex:(NSInteger)cityIndex
{
    
    
    NSMutableArray * areaArray = [NSMutableArray array];
    if (self.provinceArray.count > 0 && (provinceIndex < self.provinceArray.count) && (provinceIndex > 0 || provinceIndex == 0))
    {
        // 判端 dataSource.cout > 0
        NSDictionary *citysDict = [[self dataSource] objectAtIndex:provinceIndex];
        NSArray *citysArray = [citysDict objectForKey:@"citys"];
        NSString *cityName = [self.cityArray objectAtIndex:cityIndex];
        
        
        if (citysArray.count > 0)
        {
            for (NSDictionary *cityDict in citysArray)
            {
                //TODO cityDict 不为 nil 且不能为null
                if (cityDict)
                {
                    
                    NSString *cityname = [cityDict objectForKey:@"cityname"];
                    if (cityName.length > 0 && cityname.length > 0)
                    {
                        if ([cityName isEqualToString:cityname] || [cityName containsString:cityname])
                        {
                            NSArray *regionsArray = [cityDict objectForKey:@"regions"];
                            ////TODO cityName 不为 nil 且不能为null
                            if (regionsArray > 0 && regionsArray)
                            {
                                for (NSDictionary *regionsDict in regionsArray)
                                {
                                    NSString *regionName = [regionsDict objectForKey:@"regionname"];
                                    if (regionName.length > 0)
                                    {
                                        [areaArray addObject:regionName];
                                    }
                                    else
                                    {
                                        continue;
                                    }
                                    
                                }
                            }
                            else
                            {
                                continue;
                            }
                        }
                        else
                        {
                            continue;
                        }
                    }
                    
                }
                else
                {
                    continue;
                }
            }
        }
    }
    
    return [areaArray copy];
}
//获取plist区域ID数组
- (NSMutableArray *)getAreaNamesFromProvinceIDIndex:(NSInteger)provinceIndex
                                 cityIDIndex:(NSInteger)cityIndex
{
    
    
    NSMutableArray * areaArray = [NSMutableArray array];
    if (self.provinceArray.count > 0 && (provinceIndex < self.provinceArray.count) && (provinceIndex > 0 || provinceIndex == 0))
    {
        // 判端 dataSource.cout > 0
        NSDictionary *citysDict = [[self dataSource] objectAtIndex:provinceIndex];
        NSArray *citysArray = [citysDict objectForKey:@"citys"];
        NSString *cityName = [NSString stringWithFormat:@"%@",[_cityIDArray objectAtIndex:cityIndex]];
        
        
        if (citysArray.count > 0)
        {
            for (NSDictionary *cityDict in citysArray)
            {
                //TODO cityDict 不为 nil 且不能为null
                if (cityDict)
                {
                    
                    NSString *cityname = [NSString stringWithFormat:@"%@",[cityDict objectForKey:@"id"]];
                    if (cityName.length > 0 && cityname.length > 0)
                    {
                        if ([cityName isEqualToString:cityname] || [cityName containsString:cityname])
                        {
                            NSArray *regionsArray = [cityDict objectForKey:@"regions"];
                            ////TODO cityName 不为 nil 且不能为null
                            if (regionsArray > 0 && regionsArray)
                            {
                                for (NSDictionary *regionsDict in regionsArray)
                                {
                                    NSString *regionName = [NSString stringWithFormat:@"%@",[regionsDict objectForKey:@"id"]];
                                    if (regionName.length > 0)
                                    {
                                        [areaArray addObject:regionName];
                                    }
                                    else
                                    {
                                        continue;
                                    }
                                    
                                }
                            }
                            else
                            {
                                continue;
                            }
                        }
                        else
                        {
                            continue;
                        }
                    }
                    
                }
                else
                {
                    continue;
                }
            }
        }
    }
    
    return [areaArray copy];
}

//获取plist城市数组
- (NSArray *)getCityNamesFromProvinceIndex:(NSInteger)provinceIndex
{
    
    NSMutableArray * cityArray = [NSMutableArray array];
    if (self.provinceArray.count > 0 && (provinceIndex < self.provinceArray.count) && (provinceIndex > 0 || provinceIndex == 0))
    {
        // 判端 dataSource.cout > 0
        NSDictionary *citysDict = [[self dataSource] objectAtIndex:provinceIndex];
        NSArray *citysArray = [citysDict objectForKey:@"citys"];
        //        NSArray *cityIDArray = [citysDict objectForKey:@""];
        
        
        
        if (citysArray.count > 0)
        {
            for (NSDictionary *cityDict in citysArray)
            {
                //TODO cityDict 不为 nil 且不能为null
                if (cityDict != nil )
                {
                    NSString *cityName = [cityDict objectForKey:@"cityname"];
                    ////TODO cityName 不为 nil 且不能为null
                    if (cityName.length > 0 && cityName)
                    {
                        [cityArray addObject:cityName];
                    }
                    else
                    {
                        continue;
                    }
                }
                else
                {
                    continue;
                }
            }
        }
    }
    
    
    return [cityArray copy];
}
//获取plist城市ID数组
- (NSArray *)getCityNamesFromProvinceIDIndex:(NSInteger)provinceIDIndex
{
    
    NSMutableArray * cityArray = [NSMutableArray array];
    if (self.provinceArray.count > 0 && (provinceIDIndex < self.provinceArray.count) && (provinceIDIndex > 0 || provinceIDIndex == 0))
    {
        // 判端 dataSource.cout > 0
        NSDictionary *citysDict = [[self dataSource] objectAtIndex:provinceIDIndex];
        NSArray *citysArray = [citysDict objectForKey:@"citys"];
        //        NSArray *cityIDArray = [citysDict objectForKey:@""];
        
        
        
        if (citysArray.count > 0)
        {
            for (NSDictionary *cityDict in citysArray)
            {
                //TODO cityDict 不为 nil 且不能为null
                if (cityDict != nil )
                {
                    NSString *cityName = [NSString stringWithFormat:@"%@",[cityDict objectForKey:@"id"]];
                    ////TODO cityName 不为 nil 且不能为null
                    if (cityName.length > 0 && cityName)
                    {
                        [cityArray addObject:cityName];
                    }
                    else
                    {
                        continue;
                    }
                }
                else
                {
                    continue;
                }
            }
        }
    }
    
    
    return [cityArray copy];
}
- (void)buttonClick:(UIButton *)sender {
    
    [self hideView];
    
    if (sender.tag == CZHAddressPickerViewButtonTypeSure) {
        
        if (_provinceBlock) {
            _provinceBlock(self.selectProvince);
        }
        if (_cityBlock) {
            _cityBlock(self.selectProvince, self.selectCity);
        }
        if (_areaBlock) {
            //            _areaBlock(self.selectProvince, self.selectCity, self.selectArea);
            _areaBlock(self.selectProvince,self.selectProvinceID,self.selectCity, self.selectCityID, self.selectArea,self.selectAreaID);
        }
    }
}

#pragma mark -- UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.columnCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
        return self.cityArray.count;
    }else if (component == 2){
        return self.areaArray.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = self.provinceArray[row];
    }else if (component == 1){
        label.text = self.cityArray[row];
    }else if (component == 2){
        label.text = self.areaArray[row];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//选择省
        self.selectProvinceIndex = row;
        self.selectProvinceIDIndex = row;
        if (self.showType == CZHAddressPickerViewTypeProvince) {
            self.selectProvince = self.provinceArray[row];
            self.selectProvinceID = self.provinceIDArray[row];
            self.selectCity = @"";
            //            self.selectProvinceID = @"";
            self.selectArea = @"";
            self.selectAreaID = @"";
        } else if (self.showType == CZHAddressPickerViewTypeCity) {
            self.cityArray = [self getCityNamesFromProvinceIndex:row];
            self.cityIDArray = [self getCityNamesFromProvinceIDIndex:row];
            //            self.cityIDArray = [self getCityIDFromProvinceIDIndex:row];
            
            
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            
            self.selectProvince = self.provinceArray[row];
            self.selectProvinceID = self.provinceIDArray[row];
            
            self.selectCity = self.cityArray[0];
            self.selectCityID = self.cityIDArray[0];
            self.selectArea = @"";
            self.selectAreaID = @"";
        } else if (self.showType == CZHAddressPickerViewTypeArea) {
            
            _cityArray = [self getCityNamesFromProvinceIndex:row];
            _cityIDArray = [self getCityNamesFromProvinceIDIndex:row];
            
            _areaArray = [self getAreaNamesFromProvinceIndex:_selectProvinceIndex cityIndex:0];
            _areaIDArray = [self getAreaNamesFromProvinceIDIndex:_selectProvinceIDIndex cityIDIndex:0];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            _selectProvince = self.provinceArray[row];
            _selectProvinceID = self.provinceIDArray[row];
            
            self.selectCity = self.cityArray[0];
            self.selectArea = self.areaArray[0];
        }
    }else if (component == 1){//选择市
        
        if (self.showType == CZHAddressPickerViewTypeCity) {
            
            self.selectCity = self.cityArray[row];
            self.selectCityID = self.cityIDArray[row];
            self.selectArea = @"";
            self.selectAreaID = @"";
        } else if (self.showType == CZHAddressPickerViewTypeArea) {
            
            _areaArray = [self getAreaNamesFromProvinceIndex:_selectProvinceIndex cityIndex:row];
            _areaIDArray = [self getAreaNamesFromProvinceIDIndex:_selectProvinceIDIndex cityIDIndex:row];
            //[self getAreaIDFromProvinceIndex:self.selectProvinceIndex cityIndex:row];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            self.selectCity = self.cityArray[row];
            self.selectCityID = self.cityIDArray[row];
            self.selectArea = self.areaArray[0];
        }
    }else if (component == 2){//选择区
        
        if (self.showType == CZHAddressPickerViewTypeArea) {
            self.selectArea = _areaArray[row];
            self.selectAreaID = _areaIDArray[row];
        }
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}




- (void)showView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = CZHRGBColor(0x000000, 0.3);
        self.containView.czh_bottom = ScreenHeight;
    }];
}

- (void)hideView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containView.czh_y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)setShowType:(CZHAddressPickerViewType)showType {
    _showType = showType;
    self.columnCount = showType;
    
    [self.pickerView reloadAllComponents];
}



- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}


- (NSArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSArray array];
    }
    return _provinceArray;
}

- (NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

- (NSMutableArray *)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
    }
    return _areaArray;
}
- (NSMutableArray *)areaIDArray
{
    if (!_areaIDArray) {
        _areaIDArray = [NSMutableArray array];
    }
    return _areaIDArray;
}
- (NSArray *)cityIDArray
{
    if (!_cityIDArray) {
        _cityIDArray = [NSArray array];
    }
    return _cityIDArray;
}
- (NSArray *)provinceIDArray
{
    if (!_provinceIDArray) {
        _provinceIDArray = [NSArray array];
    }
    return _provinceIDArray;
}
@end
