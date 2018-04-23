//
//  ApplicationFormViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/2.
//  Copyright © 2018年 apple. All rights reserved.
//
 

#import "ApplicationFormViewController.h"
#import "UploadTableViewCell.h"
#import "ApplicationFormTableViewCell.h"
#import "CZHAddressPickerView.h"
#import "AddressPickerHeader.h"
#import <SDWebImage/UIButton+WebCache.h>


@interface ApplicationFormViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate> {
    
    UIImageView *selectedImageView;
    UIButton *selctedPhotoButton;
    UIButton *deleteButtonOne;
    UIButton *identityButton;
    UIButton *deleteButtonTwo;
    UIButton *permitButton;

    UITextField *textRow0;
    UITextField *textRow1;
    UITextField *textRow2;
    UITextField *textRow3;
    
    UIImage *selectedIDImage;
    UIImage *selectedIDImageTwo;
    UIImage *selectedPermitImage;
    NSInteger selectedTag;
    NSString *photo;
    NSDictionary *dataDict;
    NSString *errorCode;
}

@property (nonatomic,strong)UITableView *applicationTableView;
@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *provinceID;

@property (nonatomic, copy) NSString *cityID;

@property (nonatomic, copy) NSString *areaID;
@property (nonatomic,strong)NSMutableDictionary *helpMeToSendDic;
@end
static NSString *applicationFormCellID = @"ApplicationFormTableViewCell";
static NSString *uploadCellID = @"UploadTableViewCell";
@implementation ApplicationFormViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self request];
    selctedPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    identityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    permitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    photo = @"";
    _helpMeToSendDic = [NSMutableDictionary dictionary];
    dataDict = [NSDictionary dictionary];
    [self configNav];
    
    [self configTableView];
    
    //键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    /**
     * 添加键盘的监听事件
     *
     */
    [self registerForKeyboardNotifications];
    
}
- (void)request {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/MemberShip/initProxyApply/",token];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [hud hideAnimated:YES];
        errorCode = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
        if ([errorCode intValue] == -1) {
            
        }else {
            NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"CurStatus"]];
            if ([status isEqualToString:@"0"]) {//审核中
                dataDict = responseObject[@"data"];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审核中" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    _applicationTableView.userInteractionEnabled = NO;
                }]];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
                
            }else if([status isEqualToString:@"1"] ) {//成功
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审核成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    dataDict = responseObject[@"data"];
                     _applicationTableView.userInteractionEnabled = NO;
                }]];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
            }else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审核失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    dataDict = responseObject[@"data"];
                }]];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
            }
            
            
        }
        [_applicationTableView reloadData];
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
}
#pragma mark -- UI
- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 100;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    title.text = @"代理申请";
    title.textAlignment = 1;
    title.textColor = [UIColor colorWithHexString:@"444444"];
    title.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(63);
        make.height.mas_offset(1);
    }];
    
}
- (void)configTableView {
    _applicationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _applicationTableView.delegate = self;
    _applicationTableView.dataSource = self;
    _applicationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-45*4-105*2)];
    UIButton *upgradesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [upgradesButton setTitle:@"提交" forState:UIControlStateNormal];
    upgradesButton.titleLabel.font = [UIFont systemFontOfSize:16];
    upgradesButton.backgroundColor = zjTextColor;
    upgradesButton.layer.masksToBounds = YES;
    upgradesButton.layer.cornerRadius = 20;
    [upgradesButton addTarget:self action:@selector(presentClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:upgradesButton];
    [upgradesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(40);
        make.top.equalTo(footView.mas_top).offset(60);
    }];
    _applicationTableView.tableFooterView = footView;
    
    [self.view addSubview:_applicationTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4 || indexPath.row == 5) {
        return 105;
    }else {
        return 45;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.row < 4) {
        ApplicationFormTableViewCell *formCell = [[ApplicationFormTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:applicationFormCellID];
        if (!formCell) {
            formCell = [[ApplicationFormTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:applicationFormCellID];
        }
        UITextField *_inputTextField = [[UITextField alloc] init];
        _inputTextField.textAlignment = 0;
        _inputTextField.delegate = self;
        _inputTextField.tag = indexPath.row;
        _inputTextField.textColor = lightBlackTextColor;
        _inputTextField.font = [UIFont systemFontOfSize:13];
        [formCell addSubview:_inputTextField];
        [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(80);
                make.centerY.mas_offset(0);
                make.height.mas_offset(45);
                make.width.mas_offset(KWIDTH-120);
            }];
        NSArray *kindNameArr = @[@"商家名称",@"手机号",@"所在省份",@"详细地址"];
        formCell.kindNameLabel.text = kindNameArr[indexPath.row];
        if (indexPath.row == 2) {
            formCell.nextImage.hidden = NO;
//            formCell.inputTextField.hidden = YES;
        }
        if (indexPath.row == 0) {
            textRow0 =  _inputTextField;
            if ([dataDict count] != 0) {
                textRow0.text = [NSString stringWithFormat:@"%@",dataDict[@"Name"]];
            }else {
                if ([_helpMeToSendDic count] != 0) {
                    textRow0.text = _helpMeToSendDic[@"name"];
                }
            }
           
            
        }else if (indexPath.row == 1) {
             textRow1 = _inputTextField;
            textRow1.keyboardType = UIKeyboardTypePhonePad;
            if ([dataDict count] != 0) {
                textRow1.text = [NSString stringWithFormat:@"%@",dataDict[@"Phone"]];
            }else {
                if (_helpMeToSendDic != nil) {
                    textRow1.text = _helpMeToSendDic[@"phone"];
                }
            }
            
        }else if (indexPath.row == 2) {
             textRow2 = _inputTextField;
            textRow2.enabled = NO;
            if ([dataDict count] != 0) {
                textRow2.text = [NSString stringWithFormat:@"%@%@%@",dataDict[@"ProvinceName"],dataDict[@"CityName"],dataDict[@"RegionName"]];
            }else {
                if (_helpMeToSendDic != nil) {
                    textRow2.text = _helpMeToSendDic[@"province"];
                }
            }
            
        }else if (indexPath.row == 3) {
             textRow3 = _inputTextField;
            if ([dataDict count] != 0) {
                textRow3.text = [NSString stringWithFormat:@"%@",dataDict[@"Address"]];
            }else {
                if (_helpMeToSendDic != nil) {
                    textRow3.text = _helpMeToSendDic[@"adress"];
                }
            }
            
        }
        
        cell = formCell;
        
    }else {
        UploadTableViewCell *uploadCell = [[UploadTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:uploadCellID];
        if (!uploadCell) {
            uploadCell = [[UploadTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:uploadCellID];
        }
        NSArray *kindArr = @[@"证件上传",@"营业执照上传"];
        uploadCell.kindNameLabel.text = kindArr[indexPath.row-4];
        if (indexPath.row == 4) {
            selctedPhotoButton.layer.cornerRadius = 5;
            selctedPhotoButton.layer.masksToBounds = YES;
            selctedPhotoButton.layer.borderWidth = 1;
            selctedPhotoButton.tag = 101;
            selctedPhotoButton.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
            if ([dataDict count] != 0) {
                NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataDict[@"Photo1"]];
                [selctedPhotoButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
                [selctedPhotoButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            }else {
                if ([photo isEqualToString:@""]){
                    [selctedPhotoButton setImage:[UIImage imageNamed:@"add_handheld_IDcard"] forState:UIControlStateNormal];
                }else {
                    
                }
            }
            
            [selctedPhotoButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [uploadCell addSubview:selctedPhotoButton];
            [selctedPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(80);
                make.top.equalTo(uploadCell.mas_top).offset(40);
                make.width.mas_offset(75);
                make.height.mas_offset(50);
            }];
            deleteButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteButtonOne setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            deleteButtonOne.hidden = YES;
            [selctedPhotoButton addSubview:deleteButtonOne];
            [deleteButtonOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(selctedPhotoButton.mas_right).offset(0);
                make.centerY.equalTo(selctedPhotoButton.mas_top).offset(0);
                make.width.mas_equalTo(15);
                make.height.mas_equalTo(15);
            }];
            
            if ([dataDict count] != 0) {
                NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataDict[@"Photo2"]];
                [identityButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
                [identityButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            }else {
                if ([photo isEqualToString:@""]){
                    [identityButton setImage:[UIImage imageNamed:@"add_IDcard_back"] forState:UIControlStateNormal];
                }else {
                    
                }
            }
          
            identityButton.layer.cornerRadius = 5;
            identityButton.layer.masksToBounds = YES;
            identityButton.layer.borderWidth = 1;
            identityButton.tag = 102;
            identityButton.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
            [identityButton addTarget:self action:@selector(identityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [uploadCell addSubview:identityButton];
            [identityButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(selctedPhotoButton.mas_right).offset(15);
                make.top.equalTo(uploadCell.mas_top).offset(40);
                make.width.mas_offset(75);
                make.height.mas_offset(50);
            }];
            deleteButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteButtonTwo setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            deleteButtonTwo.hidden = YES;
            [identityButton addSubview:deleteButtonTwo];
            [deleteButtonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(identityButton.mas_right).offset(0);
                make.centerY.equalTo(identityButton.mas_top).offset(0);
                make.width.mas_equalTo(15);
                make.height.mas_equalTo(15);
            }];

            
        }else {
           
            permitButton.layer.cornerRadius = 5;
            permitButton.layer.masksToBounds = YES;
            permitButton.layer.borderWidth = 1;
            permitButton.tag = 103;
//            NSString *photo = @"";
            if ([dataDict count] != 0) {
                NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataDict[@"Photo3"]];
                [permitButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
                [permitButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            }else {
                if ([photo isEqualToString:@""]){
                    [permitButton setImage:[UIImage imageNamed:@"addto-2"] forState:UIControlStateNormal];
                }else {
                    
                }
            }
           
            permitButton.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
            [permitButton addTarget:self action:@selector(permitButtonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [uploadCell addSubview:permitButton];
            [permitButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(80);
                make.top.equalTo(uploadCell.mas_top).offset(40);
                make.width.mas_offset(75);
                make.height.mas_offset(50);
            }];
            
            
        }
        
       
        cell = uploadCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
        {
            [self.helpMeToSendDic setValue:textField.text forKey:@"name"];
        }
            break;
        case 1:
        {
            [self.helpMeToSendDic setValue:textField.text forKey:@"phone"];
        }
            break;
            
        case 2:
        {
            [self.helpMeToSendDic setValue:textField.text forKey:@"province"];
        }
            break;
        case 3:
        {
            [self.helpMeToSendDic setValue:textField.text forKey:@"adress"];
        }
            break;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectedButtonClick:(UIButton *)sender {
    
    [self headClickWithTag:sender.tag];
}
- (void)identityButtonClick:(UIButton *)sender {
   
    [self headClickWithTag:sender.tag];
}
- (void)permitButtonButtonClick:(UIButton *)sender {
  
    [self headClickWithTag:sender.tag];
}
#pragma mark -头像UIImageview的点击事件-
- (void)headClickWithTag:(NSInteger)tag {
    
    UIImagePickerController * pickerImage = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    selectedTag = tag;
//    [self presentViewController:pickerImage animated:YES completion:nil];
    [self presentViewController:pickerImage animated:YES completion:^{
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
 
        [CZHAddressPickerView areaPickerViewWithProvince:self.province provinceID:self.provinceID city:self.city cityID:self.cityID area:self.area areaID:self.areaID areaBlock:^(NSString *province, NSString *provinceID, NSString *city,NSString *cityID, NSString *area, NSString *areaID) {
//            CZHStrongSelf(self);
            self.province = province;
            self.city = city;
            self.area = area;
            NSLog(@"====%@------%@=====%@",province,city,area);
            textRow2.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
            NSLog(@"====%@------%@=====%@",provinceID,cityID,areaID);
            self.provinceID = provinceID;
            self.cityID = cityID;
            self.areaID = areaID;
            NSString *adress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
            [self.helpMeToSendDic setValue:adress forKey:@"province"];
        }];
    }
    NSLog(@"%@==========%@==========%@",textRow0.text,textRow1.text,textRow3.text);
//    [_applicationTableView reloadData];
    
}
//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    UIImage *showImage = [info objectForKey:UIImagePickerControllerEditedImage];
//     UIImage *showImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    if (selectedTag == 101) {
        selectedIDImage = showImage;
        NSLog(@"相册%@",selectedIDImage);
        photo = @"1";
        [selctedPhotoButton setImage:selectedIDImage forState:UIControlStateNormal];

        //处理完毕，回到个人信息页面
        [picker dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"成功%@",info);

    }else if (selectedTag == 102) {
        selectedIDImageTwo = showImage;
        
        [identityButton setImage:showImage forState:UIControlStateNormal];

        //处理完毕，回到个人信息页面
//        photo = @"1";
        [picker dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"成功%@",info);
    }else {
        photo = @"1";
        selectedPermitImage = showImage;
        [permitButton setImage:selectedPermitImage forState:UIControlStateNormal];
//        UIImage *avatar = info[UIImagePickerControllerOriginalImage];
        //处理完毕，回到个人信息页面
        [picker dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"成功%@",info);
    }
    NSLog(@"点击的是%ld个tag",(long)selectedTag);
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [_applicationTableView reloadData];
}
//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)presentClick {
    if ([dataDict[@"CurStatus"] integerValue] == -1 && errorCode == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"填写完整" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        
    }else {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
        NSDictionary *dic = @{
                              @"token":token
                              };
        //    NSArray *imageArr = @[selectedIDImage,selectedIDImageTwo,selectedPermitImage];
        NSArray *imageArray = [NSArray arrayWithObjects:selectedIDImage,selectedIDImageTwo,selectedPermitImage, nil];
        if ( imageArray.count == 3) {
            NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/upload/batch"];//@"http://192.168.1.236:8081/zjapp/v1/upload/batch"
            [HttpRequest uploadMostImageWithURLString:url parameters:dic uploadDatas:imageArray uploadName:@"file" WithSuccess:^(id result) {
                NSLog(@"成功===%@",result);
                NSString *code = [NSString stringWithFormat:@"%@",result[@"error_code"]];
                if ([code integerValue] == 0) {
                    NSArray *dataArr = [NSArray arrayWithArray:result[@"data"]];
                    [self requestDataArr:dataArr];
                }
        
            } With:^(NSError *error) {
                NSLog(@"失败%@",error);
            }];
        }else {
            
        }
    }
 
    
}
- (void)requestDataArr:(NSArray*)data {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/MemberShip/addProxyApply/",token];
    //    NSArray *photoArr = [NSArray arrayWithArray:data];
    NSString *photo = [NSString stringWithFormat:@"%@",data[0]];
    NSString *photo1 = [NSString stringWithFormat:@"%@",data[1]];
    NSString *photo2 = [NSString stringWithFormat:@"%@",data[2]];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parame = @{
                             @"address": textRow3.text,
                             @"cityid": self.cityID,
                             @"name": textRow0.text,
                             @"phone": textRow1.text,
                             @"photo1": photo,
                             @"photo2": photo1,
                             @"photo3":photo2,
                             @"provinceid":self.provinceID,
                             @"regionid":self.areaID
                                 };
    
    [manager POST:url parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        [hud hideAnimated:YES];
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
        if ([code integerValue] == 0) {
            [self backButtonClick];
        }else {
            NSString *show = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:show message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark--注册监听键盘的的通知
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark-- 键盘出现的通知

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    //键盘高度
    
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (KHEIGHT < 600) {
        if ([textRow0  isFirstResponder]) {
            self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
            
        }else{
            
            self.view.frame = CGRectMake(0, -100, KWIDTH, KHEIGHT );
        }
        
    }
    
    
}
#pragma mark-- 键盘消失的通知

-(void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
