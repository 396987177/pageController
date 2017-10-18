//
//  XSRecommendVC.m
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/22.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSRecommendVC.h"
#import "XSHomeHeadView.h"
#import "AppDelegate.h"
#import "XSCourseCollectionViewCell.h"
#import "XSRecommendCell.h"


static CGFloat const HeadH = 10;
static CGFloat const courseItemH = 278/2 + 15;

static NSString *const reuseIdentifier = @"reuseIdentifier";

@interface XSRecommendVC () <SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource >
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XSHomeHeadView *recommendHeadView;
@property (nonatomic, strong) UIView *sectionHeadView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, copy) NSString  *publicCount;
@property (nonatomic,assign) BOOL isVoiceChannel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign, getter=isFreshing) BOOL freshing;
@end

@implementation XSRecommendVC

- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addOwnViews];
    _cellCount  = 10;// 数据源的个数 ，计算cell高度。
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super  viewDidAppear:animated];

}



#pragma mark -
#pragma mark - load data
- (void)loadData {
    
}



#pragma mark - Private method

- (void)addOwnViews {
    
    [self.view addSubview:self.tableView];
}


#pragma mark - button action

- (void)didClickCourseCategoryIndex:(NSInteger)indx {
    NSLog(@"点击课程分类 %ld", indx);
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    NSLog(@"偏移值 %f",targetContentOffset->y);
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *identify = @"publicCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.textLabel.text = @"      NO .1  -                  ";
        return cell;
    }
    
    XSRecommendCell *cell = [XSRecommendCell cellWithTableView:tableView];
    cell.count = _cellCount;
    cell.courseItemDiclickBlock = ^{
        NSLog(@"点击了");
    };
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        //index = [(个数 - 1) / 列数 ]取模 + 1 等于行数
        // 计算嵌套collctionview的高度
        return ((_cellCount - 1)/ 2 +1 )*courseItemH ;
    }
    return 53;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 44 + HeadH;
    }
    return HeadH;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return self.sectionHeadView;
    }
    return nil;

}


#pragma mark - SDCycleScrollView delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}


#pragma mark - lazy

- (XSHomeHeadView *)recommendHeadView {
    if (_recommendHeadView == nil) {
        // 添加头部
        _recommendHeadView = [[XSHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 580/2 - 44)];
        _recommendHeadView.cycleScrollView.delegate = self;
        _recommendHeadView.tableView = _tableView;
        
        _recommendHeadView.courCategoryBlock = ^(NSInteger index) {
            // 课程总分类的点击
        };
        
        _recommendHeadView.voiceActionBlock = ^{
        };
    }
    return _recommendHeadView;
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 49 - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = YES;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.recommendHeadView;
        
    }
    return _tableView;
}


- (UIView *)sectionHeadView {

    if (_sectionHeadView == nil) {
        _sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _sectionHeadView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HeadH)];
        lineView.backgroundColor = [UIColor colorWithHex:0xf0f4f8];
        [_sectionHeadView addSubview: lineView];
        
        
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = @"热门直播";
        titleLable.font = [UIFont systemFontOfSize:16.f];
        titleLable.textColor = [UIColor blackColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [_sectionHeadView addSubview:titleLable];
        
        UIImageView *leftView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"recommend_living_left"]];
        [_sectionHeadView addSubview:leftView];
        
        UIImageView *rightView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"recommend_living_right"]];
        [_sectionHeadView addSubview:rightView];
        
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_sectionHeadView);
            make.centerY.equalTo(_sectionHeadView).offset(HeadH);
            make.width.mas_equalTo(16*4 + 5);
        }];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titleLable.mas_left).offset(-11);
            make.centerY.equalTo(titleLable);
            make.height.mas_equalTo(3);
            make.width.mas_equalTo(15);
        }];
        
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLable.mas_right).offset(11);
            make.centerY.equalTo(titleLable);
            make.height.mas_equalTo(3);
            make.width.mas_equalTo(15);
        }];
        
    }
    return _sectionHeadView;
}



@end
