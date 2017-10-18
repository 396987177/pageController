//
//  XSHomeNavCouseVC.m
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/21.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSCourseCategoryVC.h"
#import "XSNavCourseReusableView.h"
#import "XSCourseCollectionViewCell.h"
#import "XSCourseCollectionViewCell.h"

static CGFloat const itemH = 278/2;
static NSString *const reuseIdentifier = @"reuseIdentifier";

@interface XSCourseCategoryVC ()<UICollectionViewDataSource ,UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) UICollectionReusableView *categoryView;
@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation XSCourseCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - collectionView delegate & datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 8;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XSCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

/** 头部尾部控件 */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if(kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *views = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewhead" forIndexPath:indexPath];
        
        [views addSubview:self.categoryView];
        self.titleAry = @[@"No. 1", @"No. 2", @"No. 3", @"No. 4"];
        return views;
        
    }
    return nil;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"选择课程  %ld",indexPath.item);
}


#pragma mark - button action
- (void)categoryBtnClick:(UIButton *)sender {
    _selectBtn.selected = NO;
    _selectBtn.layer.borderColor = [UIColor colorWithHex:0xececf3].CGColor;
    
    sender.selected = YES;
    sender.layer.borderColor = [UIColor colorWithHex:0xececf3].CGColor;
    _selectBtn = sender;

}


#pragma mark - set

- (void)setTitleAry:(NSArray *)titleAry {
    
    [_categoryView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    for (int index = 0; index < titleAry.count; ++index) {
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4 *index, 0, self.view.frame.size.width/4, 60)];
        [_categoryView addSubview:backView];
        
        UIButton *categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [categoryBtn setTitle:titleAry[index] forState:UIControlStateNormal];
        categoryBtn.layer.cornerRadius = 15;
        categoryBtn.layer.masksToBounds = YES;
        categoryBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        categoryBtn.layer.borderColor = [UIColor colorWithHex:0xececf3].CGColor;// colorWithHex:
        categoryBtn.layer.borderWidth = 1.0f;
        
        [categoryBtn setTitleColor:[UIColor colorWithHex:0x666b81] forState:UIControlStateNormal];
        [categoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithHex:0x428df4]];
        UIImage *images = [UIImage imageWithColor:[UIColor whiteColor]];
        [categoryBtn setBackgroundImage:images forState:UIControlStateNormal];
        [categoryBtn setBackgroundImage:image forState:UIControlStateSelected];
        
        [categoryBtn addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [categoryBtn sizeToFit];
        [backView addSubview:categoryBtn];
        
        NSString *tempStr = titleAry[index];
        CGFloat ButtonW = tempStr.length *13.0f  + 15 ;
        categoryBtn.frame = CGRectMake(0,0, ButtonW, 30);
        categoryBtn.center = backView.center;
        
        [categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ButtonW);
            make.center.equalTo(backView);
            make.height.equalTo(@30);
        }];
        
        if (index == 0) {
            categoryBtn.selected = YES;
            categoryBtn.layer.borderColor = [UIColor clearColor].CGColor;
            _selectBtn = categoryBtn;
        }
    }
}

#pragma mark - lazy

// 设置collectionView
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) collectionViewLayout:self.flowLayout];
        [_collectionView registerClass:[XSCourseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewhead"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.alwaysBounceVertical = YES;// 内容过少开启滚动
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat cellW = ([UIScreen mainScreen].bounds.size.width - 45 )/2 ;
        _flowLayout.itemSize = CGSizeMake(cellW ,  itemH);
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _flowLayout.minimumLineSpacing = 15;
        _flowLayout.minimumInteritemSpacing = 0;
        //设置头部尾部Size的大小
        _flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 60);
    }
    return _flowLayout;
}


- (UICollectionReusableView *)categoryView {
    if (_categoryView == nil) {
        
        _categoryView = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    }
    return _categoryView;
}

@end





