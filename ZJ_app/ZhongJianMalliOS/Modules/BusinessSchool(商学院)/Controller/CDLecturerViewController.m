//
//  CDLecturerViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CDLecturerViewController.h"
#import "LectureTableCell.h"
#import "BDIntroduceLectureLogic.h"
#import "BDIntroduceLectureModel.h"

@interface CDLecturerViewController ()<UITableViewDelegate,UITableViewDataSource,BDIntroduceLectureLogicDelegate>

@property (nonatomic, strong) UITableView *lectureTable;
@property (nonatomic, strong) NSArray *tableArr;

@end

@implementation CDLecturerViewController

static NSString *lectureTableCell = @"lectureTableCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];

    
    [self requestLectureData];
    
    [self setupTableView];
    
}

- (void)requestLectureData {
    
    BDIntroduceLectureLogic *logic = [[BDIntroduceLectureLogic alloc] init];
    logic.delegate = self;
    [logic requsetIntroduceLectureDataWithCourseid:self.courseid];
}

- (void)setupTableView {
    
//    CGRect frame =CGRectMake(0, 0, self.view.width, self.view.size.height - 280 - 64 - 5);
    CGRect frame =CGRectMake(0, 5, self.view.width, self.view.size.height);
    _lectureTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _lectureTable.delegate = self;
    _lectureTable.dataSource = self;
    [self.view addSubview:_lectureTable];
    _lectureTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [_lectureTable registerClass:[LectureTableCell class] forCellReuseIdentifier:lectureTableCell];

    
    //table的刷新控件
//    [self refreshTableHeader];
//    [self loadTableMore];
    
}

//- (void)refreshTableHeader {
//    
//}
//
//- (void)loadTableMore {
//    
//}


#pragma mark ============ tableview ============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    LectureTableCell *lectureCell = [tableView dequeueReusableCellWithIdentifier:lectureTableCell];
    lectureCell.selectionStyle = UITableViewCellSelectionStyleNone;
    Lecture *lecture = self.tableArr[indexPath.row];
    [lectureCell updateLectureCellWithModel:lecture];
    return lectureCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
//    return [LectureTableCell cell_heightForModel:self.tableArr[indexPath.row]];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}


#pragma mark ============ logic delegate ============
- (void)requsetIntroduceLectureDataCompletedWithLecture:(BDIntroduceLectureModel *)model {
    
    self.tableArr = model.lectures;
    [self.lectureTable reloadData];
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
