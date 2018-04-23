//
//  ShowRealStateViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShowRealStateViewController.h"
#import <SDWebImage/UIButton+WebCache.h>
//#import "<#header#>"

@interface ShowRealStateViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    UITextField *nameText;
    UITextField *phoneText;
    UITextField *personNumber;
    UILabel *stateLabel;
    
    UIButton *holdButton;
    UIButton *upButton;
    UIButton *deepButton;
    
    NSString *IDCardPhoto;
    NSString *IDCardPhoto2;
    NSString *IDCardPhoto3;
    
    UIImage *selectedIDImage;
    UIImage *selectedIDImageTwo;
    UIImage *selectedPermitImage;
    NSInteger selectedTag;
    NSString *photo;
    UIButton *sendButton;
    
}


@end

@implementation ShowRealStateViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    
    photo = @"";
    IDCardPhoto = @"";
    IDCardPhoto2 = @"";
    IDCardPhoto3 = @"";
    
    [self initNavView];
    [self requestData];
    [self initCustomTableView];
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
- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/GetCertificationInfo/",token];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
        if ([code intValue] == 0) {
            NSString *IsAuth = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IsAuth"]];
            IDCardPhoto = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardPhoto"]];
            IDCardPhoto2 = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardPhoto2"]];
            IDCardPhoto3 = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardPhoto3"]];
            NSString *url1 = [NSString stringWithFormat:@"%@%@",HTTPUrl,IDCardPhoto];
            NSString *url2 = [NSString stringWithFormat:@"%@%@",HTTPUrl,IDCardPhoto2];
            NSString *url3 = [NSString stringWithFormat:@"%@%@",HTTPUrl,IDCardPhoto3];
            

            if ([IsAuth intValue] == 0) {//什么都没有
                
            }else if ([IsAuth intValue] == 1) {//审核中
                stateLabel.text = @"审核中";
                nameText.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"TrueName"]];
                nameText.enabled = NO;
                phoneText.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"Phone"]];
                phoneText.enabled = NO;
                personNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardNo"]];
                personNumber.enabled = NO;
               
                [holdButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url1] forState:UIControlStateNormal];
                holdButton.userInteractionEnabled = NO;
                [upButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url2] forState:UIControlStateNormal];
                upButton.userInteractionEnabled = NO;
                [deepButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url3] forState:UIControlStateNormal];
                deepButton.userInteractionEnabled = NO;
                [holdButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [upButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [deepButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                
            }else if ([IsAuth intValue] == 2) {//成功
                stateLabel.text = @"审核成功";
                nameText.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"TrueName"]];
                nameText.enabled = NO;
                phoneText.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"Phone"]];
                phoneText.enabled = NO;
                personNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardNo"]];
                personNumber.enabled = NO;
                [holdButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url1] forState:UIControlStateNormal];
                holdButton.userInteractionEnabled = NO;
                [upButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url2] forState:UIControlStateNormal];
                upButton.userInteractionEnabled = NO;
                [deepButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url3] forState:UIControlStateNormal];
                deepButton.userInteractionEnabled = NO;
                [holdButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [upButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [deepButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                sendButton.hidden = YES;
            }else {//审核失败
                stateLabel.text = @"审核失败";
                nameText.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"TrueName"]];
                nameText.enabled = YES;
                phoneText.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"Phone"]];
                phoneText.enabled = YES;
                personNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardNo"]];
                personNumber.enabled = YES;
                [holdButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url1] forState:UIControlStateNormal];
                holdButton.userInteractionEnabled = YES;
                [upButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url2] forState:UIControlStateNormal];
                upButton.userInteractionEnabled = YES;
                [deepButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url3] forState:UIControlStateNormal];
                deepButton.userInteractionEnabled = YES;
                [holdButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [upButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [deepButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                
            }
            
        }
        
        
        
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
}
- (void)initNavView {
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
    title.text = @"实名认证";
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

- (void)initCustomTableView {
    UIView *gray = [[UIView alloc] init];
    gray.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:gray];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(7);
        make.top.mas_offset(64);
    }];
    stateLabel = [[UILabel alloc] init];
    stateLabel.textColor = [UIColor redColor];
    [self.view addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(40);
        make.width.mas_offset(KWIDTH);
        make.top.equalTo(gray.mas_bottom).offset(10);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(0.5);
        make.top.equalTo(stateLabel.mas_bottom).offset(0);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"姓名";
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.textColor = lightBlackTextColor;
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(60);
        make.height.mas_offset(45);
        make.top.equalTo(line2.mas_bottom).offset(0);
    }];
   
    nameText = [self creatTextFieldText];
    [self.view addSubview:nameText];
    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(45);
        make.top.equalTo(line2.mas_bottom).offset(0);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(0.5);
        make.top.equalTo(nameText.mas_bottom).offset(0);
    }];
    
    UILabel *phoneLabel = [self creatLabeltext:@"手机号"];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(60);
        make.height.mas_offset(45);
        make.top.equalTo(line.mas_bottom).offset(0);
    }];
    
    phoneText = [self creatTextFieldText];
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneText];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(45);
        make.top.equalTo(line.mas_bottom).offset(0);
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(0.5);
        make.top.equalTo(phoneText.mas_bottom).offset(0);
    }];
    
    UILabel *personLabel = [self creatLabeltext:@"身份证"];
    [self.view addSubview:personLabel];
    [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(60);
        make.height.mas_offset(45);
        make.top.equalTo(line1.mas_bottom).offset(0);
    }];
    
    personNumber = [self creatTextFieldText];
    [self.view addSubview:personNumber];
    [personNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personLabel.mas_right).offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(45);
        make.top.equalTo(line1.mas_bottom).offset(0);
    }];
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(0.5);
        make.top.equalTo(personLabel.mas_bottom).offset(0);
    }];
 
    UILabel *showId = [self creatLabeltext:@"证件上传 （手持身份证，身份证正面，身份证反面）"];
    [self.view addSubview:showId];
    [showId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(45);
        make.top.equalTo(line4.mas_bottom).offset(0);
    }];

    holdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    holdButton.layer.cornerRadius = 5;
    holdButton.layer.masksToBounds = YES;
    holdButton.layer.borderWidth = 1;
    holdButton.tag = 101;
    if ([photo isEqualToString:@""]){
        [holdButton setImage:[UIImage imageNamed:@"addto-2"] forState:UIControlStateNormal];
    }else {
        
    }
    holdButton.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
    [holdButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:holdButton];
    [holdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.width.mas_offset(75);
        make.height.mas_offset(50);
        make.top.equalTo(showId.mas_bottom).offset(10);
    }];
    
    upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.layer.cornerRadius = 5;
    upButton.layer.masksToBounds = YES;
    upButton.layer.borderWidth = 1;
    upButton.tag = 102;
    if ([photo isEqualToString:@""]){
        [upButton setImage:[UIImage imageNamed:@"addto-2"] forState:UIControlStateNormal];
    }else {
        
    }
    upButton.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
    [upButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upButton];
    [upButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(holdButton.mas_right).offset(10);
        make.width.mas_offset(75);
        make.height.mas_offset(50);
        make.top.equalTo(showId.mas_bottom).offset(10);
    }];
    
    deepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deepButton.layer.cornerRadius = 5;
    deepButton.layer.masksToBounds = YES;
    deepButton.layer.borderWidth = 1;
    deepButton.tag = 103;
    if ([photo isEqualToString:@""] ){
        [deepButton setImage:[UIImage imageNamed:@"addto-2"] forState:UIControlStateNormal];
    }else {
        
    }
    deepButton.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
    [deepButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deepButton];
    [deepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(upButton.mas_right).offset(10);
        make.width.mas_offset(75);
        make.height.mas_offset(50);
        make.top.equalTo(showId.mas_bottom).offset(10);
    }];
    
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.backgroundColor = zjTextColor;
    [sendButton setTitle:@"提交" forState:UIControlStateNormal];
//    sendButton.frame = CGRectMake(10, 20, KWIDTH-20, 40);
    sendButton.layer.cornerRadius = 20;
    sendButton.layer.masksToBounds = YES;
    [sendButton addTarget:self action:@selector(presentClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.equalTo(deepButton.mas_bottom).offset(30);
        make.height.mas_offset(40);
    }];
    
}

- (void)selectedButtonClick:(UIButton *)sender {
    
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
//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    UIImage *showImage = [info objectForKey:UIImagePickerControllerEditedImage];
//         UIImage *showImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"----相册%@",showImage);
    if (selectedTag == 101) {
        selectedIDImage = showImage;
        NSLog(@"相册%@",selectedIDImage);
        photo = @"1";
//        [holdButton setBackgroundImage:selectedIDImage forState:UIControlStateNormal];
        [holdButton setImage:showImage forState:UIControlStateNormal];
        //        UIImage *avatar = info[UIImagePickerControllerOriginalImage];
        //        selctedPhotoButton.backgroundColor = [UIColor redColor];
        //        NSLog(@"----%p",selctedPhotoButton);
        //处理完毕，回到个人信息页面
        [picker dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"成功%@",info);
        
    }else if (selectedTag == 102) {
        selectedIDImageTwo = showImage;
        
        [upButton setBackgroundImage:showImage forState:UIControlStateNormal];
        
        //处理完毕，回到个人信息页面
        //        photo = @"1";
        [picker dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"成功%@",info);
    }else {
        photo = @"1";
        selectedPermitImage = showImage;
        [deepButton setBackgroundImage:selectedPermitImage forState:UIControlStateNormal];
        //        UIImage *avatar = info[UIImagePickerControllerOriginalImage];
        //处理完毕，回到个人信息页面
        [picker dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"成功%@",info);
    }
    NSLog(@"点击的是%ld个tag",(long)selectedTag);
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [_applicationTableView reloadData];
}
//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)presentClick {
//    NSLog(@"---%@-----%@-----%@",textRow0.text,textRow1.text,textRow3.text);
    
    if (selectedIDImage != nil || selectedIDImageTwo != nil || selectedPermitImage != nil) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
        NSDictionary *dic = @{
                              @"token":token
                              };
        
        
        //    NSArray *imageArr = @[selectedIDImage,selectedIDImageTwo,selectedPermitImage];
        NSArray *imageArray = [NSArray arrayWithObjects:selectedIDImage,selectedIDImageTwo,selectedPermitImage, nil];
        if (imageArray.count == 3) {
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
        }
        
        
       
    }else {
        if (IDCardPhoto.length > 0|| IDCardPhoto2.length > 0 || IDCardPhoto3.length > 0) {
            
        }
//        IDCardPhoto = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardPhoto"]];
//        IDCardPhoto2 = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardPhoto2"]];
//        IDCardPhoto3 = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCardPhoto3"]];
        NSArray *data = @[IDCardPhoto,IDCardPhoto2,IDCardPhoto3];
         [self requestDataArr:data];
    }
    
   
    
}
- (void)requestDataArr:(NSArray*)data {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/PostCertificationInfo/",token];
//    NSArray *photoArr = [NSArray arrayWithArray:data];
    NSString *photo = [NSString stringWithFormat:@"%@",data[0]];
    NSString *photo1 = [NSString stringWithFormat:@"%@",data[1]];
    NSString *photo2 = [NSString stringWithFormat:@"%@",data[2]];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parame = @{
                             @"idcardno": personNumber.text,
                             @"idcardphoto": photo,
                             @"idcardphoto2": photo1,
                             @"idcardphoto3": photo2,
                             @"truename": nameText.text,
                             @"phone": phoneText.text
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UILabel *)creatLabeltext:(NSString *)textstr {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = textstr;
    label.textColor = lightBlackTextColor;
    
    
    return label;
}
- (UITextField *)creatTextFieldText {
    
    UITextField *text = [[UITextField alloc] init];
    text.font = [UIFont systemFontOfSize:13];
    text.textColor = lightBlackTextColor;
//    text.
    
    return text;
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
        if ([nameText isFirstResponder]) {
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
