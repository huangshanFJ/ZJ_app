//
//  YNPayPasswordView.m
//  O2O
//
//  Created by Abel on 16/11/9.
//  Copyright © 2016年 yunshanghui. All rights reserved.
//

#import "YNPayPasswordView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define  boxWidth  40//密码框的宽度
#define DEFAULTFONT(SIZE)  [UIFont systemFontOfSize:SIZE]
#define HLDefaultBGColor [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0f]
#define HLLineColor [UIColor lightGrayColor]
#define HLTextRedColor [UIColor redColor]

typedef NS_ENUM(NSUInteger, YNPayPasswordViewType){
    YNPayPasswordViewTypeNormal = 0,//输入6位自动验证
    YNPayPasswordViewTypeChoice,//有选择取消
};

@interface YNPayPasswordView () {
    
}
@property(assign, nonatomic) YNPayPasswordViewType payPasswordViewType;
@end

@implementation YNPayPasswordView

//带按钮
- (id)initWithFrame:(CGRect)frame
          WithTitle:(NSString *)title
          WithSubTitle:(NSString *)subTitle
       WithButton:(NSArray *)bttonArray
{
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        
        self.payPasswordViewType = YNPayPasswordViewTypeChoice;
        
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        viewBG.backgroundColor = [UIColor blackColor];
        viewBG.alpha = 0.2;
        viewBG.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromView)];
        [viewBG addGestureRecognizer:tap];
        [self addSubview:viewBG];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-275)/2, 70, 275, 198)];
        [view.layer setCornerRadius:3];
        [view.layer setMasksToBounds:YES];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self addSubview:view];
        
        ///标题
        _lable_title = [[UILabel alloc]init];
        _lable_title.frame = CGRectMake(10, 20, view.frame.size.width-20, 15);
        _lable_title.text = [NSString stringWithFormat:@"%@",title];
        _lable_title.textAlignment=1;
        _lable_title.font = DEFAULTFONT(15);
        _lable_title.textColor = [UIColor lightGrayColor];
        [view addSubview:_lable_title];
        
        ///二级标题
        _lable_subTitle = [[UILabel alloc]init];
        _lable_subTitle.frame = CGRectMake(10, _lable_title.frame.origin.y+_lable_title.frame.size.height+20, view.frame.size.width-20, 20);
        _lable_subTitle.text = [NSString stringWithFormat:@"%@",subTitle];
        _lable_subTitle.textAlignment=1;
        _lable_subTitle.font = DEFAULTFONT(20);
        _lable_subTitle.textColor = [UIColor redColor];
        [view addSubview:_lable_subTitle];
        if([[NSString stringWithFormat:@"%@",subTitle] isEqualToString:@""]) {
            _lable_subTitle.frame = CGRectMake(10, _lable_title.frame.origin.y+_lable_title.frame.size.height, view.frame.size.width-20, 0);
            view.frame = CGRectMake((SCREEN_WIDTH-275)/2, 70, 275,158);
        }
        ///  TF
        _TF = [[UITextField alloc]init];
        _TF.frame = CGRectMake(0, 0, 0, 0);
        _TF.delegate = self;
        _TF.keyboardType=UIKeyboardTypeNumberPad;
        [_TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [view addSubview:_TF];
        
        
        ///  假的输入框
        _view_box = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2, CGRectGetMaxY(_lable_subTitle.frame)+20, boxWidth, boxWidth)];
        [_view_box.layer setBorderWidth:0.5];
        _view_box.backgroundColor = HLDefaultBGColor;
        _view_box.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box];
        _view_box2 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*1-0.5, _view_box.frame.origin.y, boxWidth, boxWidth)];
        _view_box2.backgroundColor = HLDefaultBGColor;
        [_view_box2.layer setBorderWidth:0.5];
        _view_box2.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box2];
        _view_box3 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*2-1, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box3.layer setBorderWidth:0.5];
        _view_box3.backgroundColor = HLDefaultBGColor;
        _view_box3.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box3];
        _view_box4 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*3-1.5, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box4.layer setBorderWidth:0.5];
        _view_box4.backgroundColor = HLDefaultBGColor;
        _view_box4.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box4];
        _view_box5 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*4-2, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box5.layer setBorderWidth:0.5];
        _view_box5.backgroundColor = HLDefaultBGColor;
        _view_box5.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box5];
        _view_box6 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*5-2.5, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box6.layer setBorderWidth:0.5];
        _view_box6.backgroundColor = HLDefaultBGColor;
        _view_box6.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box6];
        
        
        ///   密码点
        _lable_point = [[UILabel alloc]init];
        _lable_point.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point.layer setCornerRadius:5];
        [_lable_point.layer setMasksToBounds:YES];
        _lable_point.backgroundColor = [UIColor blackColor];
        [_view_box addSubview:_lable_point];
        
        _lable_point2 = [[UILabel alloc]init];
        _lable_point2.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point2.layer setCornerRadius:5];
        [_lable_point2.layer setMasksToBounds:YES];
        _lable_point2.backgroundColor = [UIColor blackColor];
        [_view_box2 addSubview:_lable_point2];
        
        
        _lable_point3 = [[UILabel alloc]init];
        _lable_point3.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point3.layer setCornerRadius:5];
        [_lable_point3.layer setMasksToBounds:YES];
        _lable_point3.backgroundColor = [UIColor blackColor];
        [_view_box3 addSubview:_lable_point3];
        
        _lable_point4 = [[UILabel alloc]init];
        _lable_point4.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point4.layer setCornerRadius:5];
        [_lable_point4.layer setMasksToBounds:YES];
        _lable_point4.backgroundColor = [UIColor blackColor];
        [_view_box4 addSubview:_lable_point4];
        
        _lable_point5 = [[UILabel alloc]init];
        _lable_point5.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point5.layer setCornerRadius:5];
        [_lable_point5.layer setMasksToBounds:YES];
        _lable_point5.backgroundColor = [UIColor blackColor];
        [_view_box5 addSubview:_lable_point5];
        
        _lable_point6 = [[UILabel alloc]init];
        _lable_point6.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point6.layer setCornerRadius:5];
        [_lable_point6.layer setMasksToBounds:YES];
        _lable_point6.backgroundColor = [UIColor blackColor];
        [_view_box6 addSubview:_lable_point6];
        
        _lable_point.hidden=YES;
        _lable_point2.hidden=YES;
        _lable_point3.hidden=YES;
        _lable_point4.hidden=YES;
        _lable_point5.hidden=YES;
        _lable_point6.hidden=YES;
        
        if(bttonArray.count>0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_view_box.frame)+15, view.frame.size.width, 0.5)];
            line.backgroundColor = HLLineColor;
            [view addSubview:line];
            for(int i=0;i<bttonArray.count;i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0+(view.frame.size.width/bttonArray.count)*i, CGRectGetMaxY(line.frame), view.frame.size.width/bttonArray.count, view.frame.size.height-CGRectGetMaxY(line.frame));
                [btn setTitleColor:[UIColor darkGrayColor] forState:0];
                btn.backgroundColor = [UIColor clearColor];
                btn.titleLabel.font = DEFAULTFONT(15);
                [btn setTitle:[bttonArray objectAtIndex:i] forState:0];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i;
                [view addSubview:btn];
                if(i == bttonArray.count-1) {
                     [btn setTitleColor:[UIColor redColor] forState:0];
                } else {
                    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.width/bttonArray.count)*(i+1), CGRectGetMaxY(line.frame), 0.5, view.frame.size.height-CGRectGetMaxY(line.frame))];
                    line1.backgroundColor = HLLineColor;
                    [view addSubview:line1];
                }
                
            }
            
        } else {
            view.frame = CGRectMake((SCREEN_WIDTH-275)/2, 70, 275, 128);
        }
        
        
    }
    return self;
}
//不带按钮
- (id)initWithFrame:(CGRect)frame
          WithTitle:(NSString *)title
       WithSubTitle:(NSString *)subTitle
{
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        
        self.payPasswordViewType = YNPayPasswordViewTypeNormal;
        
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        viewBG.backgroundColor = [UIColor blackColor];
        viewBG.alpha = 0.2;
        viewBG.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromView)];
        [viewBG addGestureRecognizer:tap];
        [self addSubview:viewBG];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-275)/2, 70, 275, 158)];
        [view.layer setCornerRadius:3];
        [view.layer setMasksToBounds:YES];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self addSubview:view];
        
        ///标题
        _lable_title = [[UILabel alloc]init];
        _lable_title.frame = CGRectMake(10, 20, view.frame.size.width-20, 15);
        _lable_title.text = [NSString stringWithFormat:@"%@",title];
        _lable_title.textAlignment=1;
        _lable_title.font = DEFAULTFONT(15);
        _lable_title.textColor = [UIColor darkGrayColor];
        [view addSubview:_lable_title];
        
        ///二级标题
        _lable_subTitle = [[UILabel alloc]init];
        _lable_subTitle.frame = CGRectMake(10, _lable_title.frame.origin.y+_lable_title.frame.size.height+20, view.frame.size.width-20, 20);
        _lable_subTitle.text = [NSString stringWithFormat:@"%@",subTitle];
        _lable_subTitle.textAlignment=1;
        _lable_subTitle.font = DEFAULTFONT(20);
        _lable_subTitle.textColor = HLTextRedColor;
        [view addSubview:_lable_subTitle];
        if([[NSString stringWithFormat:@"%@",subTitle] isEqualToString:@""]) {
            _lable_subTitle.frame = CGRectMake(10, _lable_title.frame.origin.y+_lable_title.frame.size.height, view.frame.size.width-20, 0);
        }
        ///  TF
        _TF = [[UITextField alloc]init];
        _TF.frame = CGRectMake(0, 0, 0, 0);
        _TF.delegate = self;
        _TF.keyboardType=UIKeyboardTypeNumberPad;
        [_TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [view addSubview:_TF];
        
        ///  假的输入框
        _view_box = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2, CGRectGetMaxY(_lable_subTitle.frame)+20, boxWidth, boxWidth)];
        [_view_box.layer setBorderWidth:0.5];
        _view_box.backgroundColor = HLDefaultBGColor;
        _view_box.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box];
        _view_box2 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*1-0.5, _view_box.frame.origin.y, boxWidth, boxWidth)];
        _view_box2.backgroundColor = HLDefaultBGColor;
        [_view_box2.layer setBorderWidth:0.5];
        _view_box2.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box2];
        _view_box3 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*2-1, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box3.layer setBorderWidth:0.5];
        _view_box3.backgroundColor = HLDefaultBGColor;
        _view_box3.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box3];
        _view_box4 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*3-1.5, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box4.layer setBorderWidth:0.5];
        _view_box4.backgroundColor = HLDefaultBGColor;
        _view_box4.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box4];
        _view_box5 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*4-2, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box5.layer setBorderWidth:0.5];
        _view_box5.backgroundColor = HLDefaultBGColor;
        _view_box5.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box5];
        _view_box6 = [[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-boxWidth*6)/2+boxWidth*5-2.5, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box6.layer setBorderWidth:0.5];
        _view_box6.backgroundColor = HLDefaultBGColor;
        _view_box6.layer.borderColor = [HLLineColor CGColor];
        [view addSubview:_view_box6];
        
        
        ///   密码点
        _lable_point = [[UILabel alloc]init];
        _lable_point.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point.layer setCornerRadius:5];
        [_lable_point.layer setMasksToBounds:YES];
        _lable_point.backgroundColor = [UIColor blackColor];
        [_view_box addSubview:_lable_point];
        
        _lable_point2 = [[UILabel alloc]init];
        _lable_point2.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point2.layer setCornerRadius:5];
        [_lable_point2.layer setMasksToBounds:YES];
        _lable_point2.backgroundColor = [UIColor blackColor];
        [_view_box2 addSubview:_lable_point2];
        
        
        _lable_point3 = [[UILabel alloc]init];
        _lable_point3.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point3.layer setCornerRadius:5];
        [_lable_point3.layer setMasksToBounds:YES];
        _lable_point3.backgroundColor = [UIColor blackColor];
        [_view_box3 addSubview:_lable_point3];
        
        _lable_point4 = [[UILabel alloc]init];
        _lable_point4.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point4.layer setCornerRadius:5];
        [_lable_point4.layer setMasksToBounds:YES];
        _lable_point4.backgroundColor = [UIColor blackColor];
        [_view_box4 addSubview:_lable_point4];
        
        _lable_point5 = [[UILabel alloc]init];
        _lable_point5.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point5.layer setCornerRadius:5];
        [_lable_point5.layer setMasksToBounds:YES];
        _lable_point5.backgroundColor = [UIColor blackColor];
        [_view_box5 addSubview:_lable_point5];
        
        _lable_point6 = [[UILabel alloc]init];
        _lable_point6.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point6.layer setCornerRadius:5];
        [_lable_point6.layer setMasksToBounds:YES];
        _lable_point6.backgroundColor = [UIColor blackColor];
        [_view_box6 addSubview:_lable_point6];
        
        _lable_point.hidden=YES;
        _lable_point2.hidden=YES;
        _lable_point3.hidden=YES;
        _lable_point4.hidden=YES;
        _lable_point5.hidden=YES;
        _lable_point6.hidden=YES;
    }
    return self;
}
- (void) textFieldDidChange:(id) sender {
    
    UITextField *_field = (UITextField *)sender;
    
    switch (_field.text.length) {
        case 0:{
            _lable_point.hidden=YES;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 1:{
            _lable_point.hidden=NO;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 2:{
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 3:{
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 4:{
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 5:{
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=NO;
            _lable_point6.hidden=YES;
        }
            break;
        case 6:{
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=NO;
            _lable_point6.hidden=NO;
        }
            break;
            
        default:
            break;
    }
    if(self.payPasswordViewType == YNPayPasswordViewTypeNormal) {
        if (_field.text.length==6){
            [self.payPasswordDelegate YNPayPasswordView:self WithPasswordString:_field.text];
        }
    } else {
        if(_field.text.length>6){
            _field.text = [_field.text substringToIndex:6];
        }
    }
}
- (void)btnClick:(UIButton *)btn {
     [self.payPasswordDelegate YNPayPasswordView:self WithPasswordString:_TF.text WithButtonIndex:btn.tag];
    [self removeFromView];
}

- (void)hiddenAllPoint {
    _lable_point.hidden=YES;
    _lable_point2.hidden=YES;
    _lable_point3.hidden=YES;
    _lable_point4.hidden=YES;
    _lable_point5.hidden=YES;
    _lable_point6.hidden=YES;
}
- (void)removeFromView {
    [self removeFromSuperview];
}
- (void)dealloc {
    NSLog(@"dealloc");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
