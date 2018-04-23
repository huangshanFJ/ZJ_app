//
//  HomeRedPacketViewController.m
//  ZhongJianMalliOS
//
//  Created by hismobile on 2018/3/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HomeRedPacketViewController.h"

@interface HomeRedPacketViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *redPacketView;
@property (weak, nonatomic) IBOutlet UIImageView *packetTextImgView;
@property (weak, nonatomic) IBOutlet UILabel *packetTextLbl;
@property (nonatomic,strong) NSString *packetKey;
@property (nonatomic,assign) BOOL isOpen; // 为YES时点击屏幕dismiss

@end

@implementation HomeRedPacketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self requestPakKey];
    
    
}
#pragma mark - private method
- (void)initView{
    
    self.packetTextLbl.hidden = YES;
    self.redPacketView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPacketAction)];
    [self.redPacketView addGestureRecognizer:tap];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.presentingViewController.tabBarController.tabBar.hidden = NO;
    
}
#pragma mark - api
- (void)requestPakKey{
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    NSString *token = [use objectForKey:@"userToken"];
    if (token.length == 0) {
        self.isOpen = YES;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  // NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/accountBill/",token];
//    https://appnew.zhongjianmall.com/zjapp/getBeginningRedPacketKey?tokne=
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/getBeginningRedPacketKey?token=",token];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
      
        if ([responseObject[@"error_code"] integerValue] == 0) {
           
            self.packetKey = responseObject[@"data"];
            [hud hideAnimated:YES];

        }else if ([responseObject[@"error_code"] integerValue] == 3){
            self.isOpen = YES;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该账号已在其他手机登陆" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            [hud hideAnimated:YES];

            
        }
        
        else if([responseObject[@"error_code"] integerValue] == -1){
            self.isOpen = YES;
            NSString *errorMsg = responseObject[@"error_message"];
            
            hud.mode = MBProgressHUDModeCustomView;
            hud.label.text =errorMsg;
            [hud hideAnimated:YES afterDelay:2];
            self.packetTextLbl.hidden = YES;
            self.redPacketView.hidden = YES;
            self.packetTextImgView.hidden = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
//            [self updateFailPacView:errorMsg];
            
        }else{
            
            self.isOpen = YES;
            [hud hideAnimated:YES];

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        self.isOpen = YES;
        [hud hideAnimated:YES];
    }];
    
}
- (void)requestRedpack{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    https://appnew.zhongjianmall.com/zjapp/drawRedPacket
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/drawRedPacket"];
    NSDictionary *dic = @{
                          @"token":token,
                          @"redPacketKey":self.packetKey
                          };
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-=-=-=-%@",responseObject);
        self.isOpen = YES;
        
        if ([responseObject[@"error_code"] intValue] == 0) {
         NSString *packValue = responseObject[@"data"];
            
            [self updaKacView:packValue];
            
        }else if([responseObject[@"error_code"] intValue] == -1){
            
            NSString *errorMsg = responseObject[@"error_message"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
      
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.isOpen = YES;
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}
- (void)updaKacView:(NSString *)value{
    value = [NSString stringWithFormat:@"%@%@",value,@"元"];
    self.packetTextImgView.hidden = YES;
    self.packetTextLbl.hidden = NO;
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[value dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    NSRange range = NSMakeRange(0, attrStr.length-1);
    // 设置字体大小
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:47] range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"f9f15b"] range:NSMakeRange(0, attrStr.length)];
    range =NSMakeRange(attrStr.length-1, 1);
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    self.packetTextLbl.attributedText = attrStr;
  
    
}
- (void)updateFailPacView:(NSString *)value{
    
    self.packetTextImgView.hidden = YES;
    self.packetTextLbl.hidden = NO;
    self.packetTextLbl.text = value;
//    PingFangSC-Medium
    self.packetTextLbl.font = [UIFont fontWithDescriptor:[UIFontDescriptor fontDescriptorWithName:@"PingFangSC-Medium" size:12] size:12];
    self.packetTextLbl.textColor = [UIColor whiteColor];
    
}

#pragma mark - ACITON
- (void)tapPacketAction{
    
    if (self.packetKey && self.packetKey.length > 0) {
        
        [self requestRedpack];
        
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.isOpen == YES) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }

}

@end
