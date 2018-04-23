//
//  SiftViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SiftViewController.h"
#import "SiftCollectionView.h"
#import "SiftCollectionHeadView.h"
#import "SiftHeadView.h"
#import "SpecialgiftsViewController.h"
@interface SiftViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong , nonatomic)UICollectionView *collectionView;
@end
static NSString *const siftHeadViewID = @"SiftCollectionHeadView";
static NSString *const siftHeadtTitleViewID = @"SiftHeadView";
static NSString *const siftCellID = @"SiftCollectionView";

@implementation SiftViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLeftRight];
}
- (void)initLeftRight {
    
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    UIView *leftView = [[UIView alloc] init];
////    leftView.backgroundColor = [UIColor colorWithHexString:@"999999"];
//    leftView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
////    leftView.alpha = 0.5;
// //    [self.view addSubview:leftView];
//    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(0);
//        make.width.mas_offset(KWIDTH*0.24);
//        make.bottom.mas_offset(0);
//        make.top.mas_offset(0);
//    }];
//    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(background)];
//    [leftView addGestureRecognizer:leftTap];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, KWIDTH*0.24, KHEIGHT);
    leftButton.alpha = 0.5;
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton addTarget:self action:@selector(background) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(KWIDTH*0.24, 0, KWIDTH*0.76, KHEIGHT) collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[SiftCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:siftHeadViewID];
    [_collectionView registerClass:[SiftHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:siftHeadtTitleViewID];
    [_collectionView registerClass:[SiftCollectionView class] forCellWithReuseIdentifier:siftCellID];
    
    [self.view addSubview:_collectionView];
    
}

#pragma mark - <UICollectionViewDataSource>
//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 0 ? 3 : 5;
}
//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.01;
}
//动态设置每行的间距大小

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.01;
    //section == 0 ? 0 : 8;
}

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section == 0 ? CGSizeMake(KWIDTH*0.76, 280) : CGSizeMake(KWIDTH*0.76, 44);
    
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 1, 0 );
//}
//脚部试图的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return  section == 0 ? CGSizeMake(KWIDTH, 47) : CGSizeMake(0, 0);
//    ;
//}
//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    return CGSizeMake(95, 40);
    return CGSizeMake((0.76*KWIDTH-30)/3, 40);
 
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:siftHeadViewID forIndexPath:indexPath];
//            SiftCollectionHeadView *headView = [[SiftCollectionHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 300)];
            
//            [reusableview addSubview:headView];
        }else{
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:siftHeadtTitleViewID forIndexPath:indexPath];
            
           
            
        }
      
    }
    
    
    
    return reusableview;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *collectionCell = nil;
    if (indexPath.section == 0) {
        SiftCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:siftCellID forIndexPath:indexPath];
        NSArray *textArr = @[@"浙江",@"杭州",@"萧山区"];
        cell.placeLabel.text = textArr[indexPath.section];
        
        collectionCell = cell;
    
    
    }else {
        SiftCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:siftCellID forIndexPath:indexPath];
        NSArray *textArr = @[@"浙江",@"苏州",@"南京",@"杭州",@"北京"];
        cell.placeLabel.text = textArr[indexPath.row];

        collectionCell = cell;
    }

    
    
    return collectionCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了%ld",(long)indexPath.row);
    
}

- (void)background {
//    [self.navigationController popViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
