//
//  XSRecommendCell.m
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/22.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSRecommendCell.h"
#import "XSCourseCollectionViewCell.h"

static CGFloat const courseItemHs = 278/2 ;
static NSString *const reuseIdentifier = @"reuseIdentifier";

@interface XSRecommendCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation XSRecommendCell


- (void)addOwnViews{
    
   [self.contentView addSubview:self.collectionView];

}

- (void)addConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

}

- (void)setCount:(NSInteger)count {
    _count = count;
    [_collectionView reloadData];

}

#pragma mark - collectionView datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XSCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    !self.courseItemDiclickBlock ? : self.courseItemDiclickBlock();
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];  // 背景色
    cell.contentView.backgroundColor = [UIColor colorWithHex:0xf8f8fa];
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}



#pragma mark - lazy
// 设置collectionView
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        [_collectionView registerClass:[XSCourseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat cellW = ([UIScreen mainScreen].bounds.size.width - 45 )/2 ;
        _flowLayout.itemSize = CGSizeMake(cellW , courseItemHs);
        _flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _flowLayout.minimumLineSpacing = 15;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

@end
