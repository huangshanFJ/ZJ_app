//
//  ChangeInformationViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangeInformationViewController.h"
#import "ChangeTableCell.h"
#import "SettingNewPassworldViewController.h"
#import "ChangeNicknameViewController.h"
#import "SetPassViertyViewController.h"
#import "InviterViewController.h"
#import "ChangePhoneViewController.h"

@interface ChangeInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    NSString *avator;
    NSDictionary *dataDic;
}

@property (nonatomic,strong)UITableView *changeTableView;
@property (nonatomic,strong) UIImagePickerController *imagePicker; //声明全局的UIImagePickerController
@property (nonatomic,strong) UIImageView *headIconImage;
@property (nonatomic,strong) UIImage *selectedPhotoImage;

@end

static NSString *const changeTableViewCellID = @"ChangeTableCell";
@implementation ChangeInformationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _selectedPhotoImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    dataDic = [NSDictionary dictionary];
    _selectedPhotoImage = nil;
    
    [self configNav];
    
    [self configTableView];
}
- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/GetPersonalInfo/",token];//,token];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功=%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            //        。；
            if (responseObject[@"data"] != nil) {
                dataDic = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
                avator = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataDic[@"personDataMap"][@"HeadPhoto"]];
                [_changeTableView reloadData];
            }
           
        }else if ([responseObject[@"error_code"] intValue] == 3) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该账号已在其他手机登陆" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            //            [alert addAction:[UIAlertAction actionWithTitle: style: handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败=%@",error);
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
    title.text = @"修改个人信息";
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
    
}
- (void)configTableView {
    _changeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _changeTableView.delegate = self;
    _changeTableView.dataSource = self;
    _changeTableView.scrollEnabled = NO;
    _changeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _changeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _changeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-60+45*4-14)];
    _changeTableView.tableFooterView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.backgroundColor = zjTextColor;
    [dismissButton setTitle:@"退出" forState:UIControlStateNormal];
    dismissButton.frame = CGRectMake(10, 20, KWIDTH-20, 40);
    dismissButton.layer.cornerRadius = 20;
    dismissButton.layer.masksToBounds = YES;
    [dismissButton addTarget:self action:@selector(dismissButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_changeTableView.tableFooterView addSubview:dismissButton];
    
    
    [self.view addSubview:_changeTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? 3 : 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }else {
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 7;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 7)];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return headView;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChangeTableCell *cell = [[ChangeTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:changeTableViewCellID];
    if (!cell) {
        cell = [[ChangeTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:changeTableViewCellID];
    }
    if (dataDic != nil) {
        if (indexPath.section == 1) {
            NSArray *titleArray = @[@"设置登陆密码",@"设置支付密码",@"修改手机号"];
            cell.changeNameLabel.text = titleArray[indexPath.row];
            cell.nextImage.hidden = NO;
        }else {
            NSArray *titleArray = @[@"头      像：",@"会 员 名：",@"众 健 号：",@"邀 请 人："];//,@"城      市：",@"职      业："];
            cell.changeNameLabel.text = titleArray[indexPath.row];
            
            if (indexPath.row == 0) {
                _headIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH*0.731, 15, 60, 60)];
                _headIconImage.userInteractionEnabled = YES;
                UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)];
                _headIconImage.layer.borderWidth = 1;
                _headIconImage.layer.borderColor = lightgrayTextColor.CGColor;
                [_headIconImage addGestureRecognizer:tapClick];
                _headIconImage.layer.cornerRadius = 20;
                if ([avator isEqualToString:@""]) {
                    _headIconImage.image = [UIImage imageNamed:@"morentouxiang"];
                }else{
                    if (_selectedPhotoImage == nil) {
                        
                        [_headIconImage sd_setImageWithURL:[NSURL URLWithString:avator]];
                    }else{
                        _headIconImage.image = _selectedPhotoImage;
                        
                    }
                }
                //            _headIconImage.image = _selectedPhotoImage;
                _headIconImage.layer.masksToBounds = YES;
                //        [cell.detailTextLabel addSubview:image];
                [cell.contentView addSubview:_headIconImage];
                [_headIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_offset(-10);
                    make.top.mas_offset(10);
                    make.width.mas_offset(40);
                    make.height.mas_offset(40);
                }];
                
            }else if (indexPath.row == 1) {
                cell.nextImage.hidden = NO;
                cell.detailNameLabel.hidden = NO;
                cell.detailNameLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"NickName"]];
            }else if (indexPath.row == 2) {
                cell.numberLabel.hidden = NO;
                cell.numberLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"SysID"]];
            }else if (indexPath.row == 3) {
                NSString *code = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"BeInviteCode"]];
                if ([code intValue] == 0) {
                    cell.numberLabel.hidden = YES;
                }else {
                    cell.numberLabel.hidden = NO;
                    cell.numberLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"BeInviteCode"]];
                }
                
                
            }
           
        }
    }
    
    
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[SettingNewPassworldViewController new] animated:YES];
        }else if(indexPath.row == 1){
            SetPassViertyViewController *passVC = [SetPassViertyViewController new];
            passVC.phone = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"UserName"]];
            
            [self.navigationController pushViewController:passVC animated:YES];
        }else {
            ChangePhoneViewController *phoneVC = [ChangePhoneViewController new];
            phoneVC.phone = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"UserName"]];
            [self.navigationController pushViewController:phoneVC animated:YES];
        }
    }else {
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[ChangeNicknameViewController new] animated:YES];
        }else if (indexPath.row == 0) {
            
        }else if (indexPath.row == 3) {
            NSString *code = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"BeInviteCode"]];
            if ([code intValue] == 0) {
                [self.navigationController pushViewController:[InviterViewController new] animated:YES];
            }
           
        }
    }
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -头像UIImageview的点击事件-
- (void)headClick {
    
    UIImagePickerController * pickerImage = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:nil];
 
}
- (void)dismissButtonClick {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/logout"];//,token];
    NSDictionary *dict = @{
                           @"token":token
                           };
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:@"userToken"];
        // 1.创建窗口
        self.window = [[UIWindow alloc] init];
        self.window.frame = [UIScreen mainScreen].bounds;
        
        // 2.设置窗口的根控制器
        self.window.rootViewController = [[MainTabBarController alloc] init];
        // 3.显示窗口(成为主窗口)
        [self.window makeKeyAndVisible];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}
//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    _selectedPhotoImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    _selectedPhotoImage = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"相册%@",_selectedPhotoImage);
    UIImage *avatar = info[UIImagePickerControllerOriginalImage];
    //处理完毕，回到个人信息页面
    [picker dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"成功%@",info);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSData *imageData = UIImageJPEGRepresentation(_selectedPhotoImage, 0.7f);
    NSDictionary *dic = @{@"token":token};
    
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/upload"];
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        dateString = [NSString stringWithFormat:@"yyyyMMddHHmmss"];
        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功---%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            NSDictionary *diction = @{
                                      @"headPhoto":responseObject[@"data"]
                                      };
            NSString *urlstr = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/updateHeadPhoto/",token];
            [manager POST:urlstr parameters:diction progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"失败%@",error);
    }];
    
 
//
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [_changeTableView reloadData];
}
//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)dismissButtonClick:(UIButton *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"userToken"];
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.设置窗口的根控制器
    self.window.rootViewController = [[MainTabBarController alloc] init];
    // 3.显示窗口(成为主窗口)
    [self.window makeKeyAndVisible];
    
}
/**
 *  压缩图片尺寸
 *
 *  @param image   图片
 *  @param newSize 大小
 *
 *  @return 真实图片
 */
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
