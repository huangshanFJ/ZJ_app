//
//  CommentingViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommentingViewController.h"
#import "LHRatingView.h"
#import "TZImagePickerController.h"
#import "TZTestCell.h"
#import "UIView+Layout.h"
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CommentingViewController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ratingViewDelegate,UITextViewDelegate> {
    UILabel *showLabel;
    UITextView *commentTextView;
    UILabel *tishiLabel;
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    BOOL        Haveimage;
    CGFloat _itemWH;
    CGFloat _margin;

}

@property (nonatomic,strong)UITableView *commentTable;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@end

@implementation CommentingViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNav];
    
    [self configCommentView];
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    Haveimage = NO;
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
    title.text = @"我的订单";
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
- (void)configCommentView {

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 6)];
    topView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:topView];
    LHRatingView * rView = [[LHRatingView alloc]initWithFrame:CGRectMake(20, 20, 165, 29)];
    rView.center = self.view.center;
    //    rView.backgroundColor = [UIColor greenColor];
    
    rView.ratingType = FLOAT_TYPE;//半颗星
    rView.delegate = self;
    [self.view addSubview:rView];
    [rView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(165);
        make.height.mas_offset(29);
        make.top.equalTo(topView.mas_bottom).offset(20);
    }];
    
    showLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 200, 200, 40)];
    showLabel.textAlignment = 1;
    showLabel.textColor = zjTextColor;
    showLabel.font = [UIFont systemFontOfSize:13];
    showLabel.text = @"差";
    [self.view addSubview:showLabel];
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(165);
        make.height.mas_offset(15);
        make.top.equalTo(rView.mas_bottom).offset(10);
    }];
    UIImageView *commentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputbox"]];
    commentImageView.userInteractionEnabled = YES;
    [self.view addSubview:commentImageView];
    [commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(6);
        make.right.mas_offset(6);
        make.height.mas_offset(215);
        make.top.equalTo(showLabel.mas_bottom).offset(10);
    }];
    
    commentTextView = [[UITextView alloc] init];
    commentTextView.font = [UIFont systemFontOfSize:12];
    commentTextView.delegate = self;
    
    commentTextView.scrollEnabled = NO;
    [commentImageView addSubview:commentTextView];
    [commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentImageView.mas_left).offset(12);
        make.right.equalTo(commentImageView.mas_right).offset(-12);
        make.top.equalTo(commentImageView.mas_top).offset(12);
        make.bottom.equalTo(commentImageView.mas_bottom).offset(-140);
    }];
    tishiLabel = [[UILabel alloc] init];
    
    tishiLabel.text = @"宝贝满足你的期待吗？说说你的使用心得，分享给想要的他们吧！";
    tishiLabel.font = [UIFont systemFontOfSize:12];
    tishiLabel.textColor = lightgrayTextColor;
    tishiLabel.numberOfLines = 0;
    [commentTextView addSubview:tishiLabel];
    [tishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentTextView.mas_left).offset(5);
        make.top.equalTo(commentTextView.mas_top).offset(10);
        make.height.mas_offset(30);
        make.right.equalTo(commentTextView.mas_right).offset(0);
    }];
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 7 - _margin;
    
    if (KWIDTH == 320) {
        _itemWH = 50;
    }
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50+KHEIGHT*0.28, self.view.tz_width, _itemWH+5) collectionViewLayout:layout];
    //    CGFloat rgb = 244 / 255.0;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.alwaysBounceVertical = YES;
    //    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [commentImageView addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(commentImageView.mas_bottom).offset(-15);
        make.width.mas_offset(KWIDTH-40);
        make.height.mas_offset(_itemWH+5);
        make.left.mas_offset(20);
    }];
    
    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectedButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [selectedButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectedButton];
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(16);
        make.width.mas_offset(16);
        make.top.equalTo(commentImageView.mas_bottom).offset(30);
    }];
    UILabel *anonymityLabel = [[UILabel alloc] init];
    anonymityLabel.text = @"匿名评论";
    anonymityLabel.font = [UIFont systemFontOfSize:13];
    anonymityLabel.textColor = lightgrayTextColor;
    [self.view addSubview:anonymityLabel];
    [anonymityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectedButton.mas_right).offset(7);
        make.height.mas_offset(20);
        make.centerY.equalTo(selectedButton.mas_centerY).offset(0);
    }];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [sendButton setTitle:@"发布" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(selectedButton.mas_bottom).offset(50);
        make.height.mas_offset(50);
    }];
    
}
- (void)sendButtonClick:(UIButton*)sender {
    NSLog(@"发布");
}
- (void)selectedButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setBackgroundImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateSelected];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    }
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
    if ([commentTextView isFirstResponder]) {
        self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
        
    }else{
        
        self.view.frame = CGRectMake(0, -100, KWIDTH, KHEIGHT );
    }
    
    
}
#pragma mark-- 键盘消失的通知

-(void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    tishiLabel.hidden = YES;
    
}
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        tishiLabel.hidden = NO;
        
    }else{
        tishiLabel.hidden = YES;
        
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        tishiLabel.hidden = NO;
        
    }
}
#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
//    NSLog(@"分数  %.2f",score);
    if (score<=1) {
        //差
        showLabel.text = @"差";
    }
    else if(score>1&&score<=2){
        //一般
        showLabel.text = @"一般";
    }
    else if(score<=3&&score>2){
        //好
        showLabel.text=@"好";
    }
    else if(score<=4&&score>3){
        //很好
        showLabel.text=@"很好";
    }
    else{
        //非常好
        showLabel.text=@"非常好";
    }
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"addto-1"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        [self pushImagePickerController];
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        imagePickerVc.maxImagesCount = 4;
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
    
}
#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    
    
    TZImagePickerController *iamgePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 delegate:self];
    [iamgePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:iamgePickerVc animated:YES completion:nil];
    
    
}
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) { // 如果保存失败，基本是没有相册权限导致的...
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法保存图片" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                alert.tag = 1;
                [alert show];
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [_selectedAssets addObject:assetModel.asset];
                        [_selectedPhotos addObject:image];
                        [_collectionView reloadData];
                    }];
                }];
            }
        }];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    
    //    [OSSImageUploader asyncUploadImages:_selectedPhotos complete:^(NSArray<NSString *> *names, UploadImageState state) {
    //        NSLog(@"names---%@", names);
    //    }];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
}
- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        NSLog(@"图片名字:%@",fileName);
    }
    if (![fileName  isEqual: @""]) {
        Haveimage = YES;
    }
    
    
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
