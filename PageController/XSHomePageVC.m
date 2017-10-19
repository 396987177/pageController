//
//  XSHomePageVC.m
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/22.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSHomePageVC.h"
#import "XSNavCouseChoseView.h"
#import "XSCourseCategoryVC.h"
#import "XSRecommendVC.h"
#import "XLChannelControl.h"
#import "XSRecommendVC.h"
@interface XSHomePageVC ()<UIScrollViewDelegate, XSNavChooseScrollViewDelegate>


@property (nonatomic, strong) XSNavCouseChoseView *navCoureCategoryView;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) NSMutableArray *navTitleAry;
@property (nonatomic, strong) NSMutableArray *unUserTitleAry;

@end

@implementation XSHomePageVC

- (void)dealloc {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleAry = @[@"推荐", @"平面设计", @"影视" ].mutableCopy;
    self.unUserTitleAry = @[@"UI设计", @"网页设计", @"影视世纪",@"No. 1", @"No. 2", @"No. 3", @"No. 4"].mutableCopy;
    [self addOwnViews];
}

#pragma mark -
#pragma mark - setter

- (void)setNavTitleAry:(NSMutableArray *)navTitleAry {
 
    _navTitleAry = navTitleAry;
    self.navCoureCategoryView.modelAry = navTitleAry;
    self.backScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _navTitleAry.count, _backScrollView.frame.size.height);
    [_backScrollView setContentOffset:CGPointMake(0,0)animated:NO];

    // 导航栏数据变化移除子控制器
   [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if (![obj isKindOfClass:[XSRecommendVC class]]) {
           //[self removeChild:obj];
           [obj removeFromParentViewController];
       }
   }];
}

#pragma mark - delegate
#pragma mark - 导航分类选择代理

- (void)XSNavChooseView:(XSNavCouseChoseView *)chooseView clickItem:(id)itemModel withIndex:(NSInteger)index {
    
    CGFloat offsetX = index *self.view.frame.size.width;
    [_backScrollView setContentOffset:CGPointMake(offsetX,0)animated:NO];
    [self addChildVCWithIndex: index];

}

#pragma mark - ScroollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (![scrollView isKindOfClass:[UITableView class] ]) {
        CGPoint offset = scrollView.contentOffset;
        _navCoureCategoryView.currentBtnIndex = offset.x/self.view.frame.size.width;
        
        NSInteger index  = offset.x/self.view.frame.size.width;
        [self addChildVCWithIndex: index];

    }
}


- (void)addChildVCWithIndex:(NSInteger )index {
    __block BOOL ishasVC = NO;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.title isEqualToString:_navTitleAry[index]]) {
            ishasVC = YES;
        }
    }];
    // 判断是否存在自控制器， 没有添加
    if (ishasVC == YES) {
        return;
    }
    NSString *titleName = _navTitleAry[index];
    XSCourseCategoryVC  *courseVC = [[XSCourseCategoryVC alloc] init];
    courseVC.view.frame = CGRectMake(self.view.frame.size.width * index, 0, self.view.frame.size.width, _backScrollView.frame.size.height);
    [_backScrollView addSubview:courseVC.view];
    courseVC.title = titleName;
    [self addChildViewController:courseVC];
}

#pragma mark -
#pragma mark - button action


// 导航分类选择控制器
- (void)pushToChooseCourseCategoryVC {
    typeof(self) weakSelf = self;
    [[XLChannelControl shareControl] showChannelViewWithInUseTitles:_navTitleAry unUseTitles:_unUserTitleAry finish:^(NSArray *inUseTitles, NSArray *unUseTitles, NSString *title, BOOL isChange) {
        
        if (isChange) {
            weakSelf.navTitleAry = inUseTitles.mutableCopy;
            weakSelf.unUserTitleAry = unUseTitles.mutableCopy;
        }
        
        if (title) {
            // 点击
            [weakSelf.navTitleAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([title isEqualToString:obj]) {
                    
                    [self addChildVCWithIndex:idx];
                    
                    weakSelf.navCoureCategoryView.currentBtnIndex = idx;
                    CGFloat offsetX = idx *weakSelf.view.frame.size.width;
                    [weakSelf.backScrollView setContentOffset:CGPointMake(offsetX,0)animated:NO];

                }
            }];
        }
    }];
}


#pragma mark -
#pragma mark - Private method

- (void)addOwnViews {
    [self.view addSubview:self.backScrollView];
    [self setupHomeNav];
    
    // 首页
    XSRecommendVC *courseVC= [[XSRecommendVC alloc] init];
    courseVC.view.frame = CGRectMake(self.view.frame.size.width  * 0, 0, self.view.frame.size.width, _backScrollView.frame.size.width);
    courseVC.title = @"推荐";
    [_backScrollView addSubview:courseVC.view];
    //[self.unUserTitleAry addObject:courseVC];
    [self addChildViewController:courseVC];

}


//导航设置
- (void)setupHomeNav{
    
    UIButton *searchCourse = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 14, 14)];
    [searchCourse setImage:[UIImage imageNamed:@"main_nav_search"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchCourse];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *moreCourse = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15, 14)];
    [moreCourse setImage:[UIImage imageNamed:@"main_nav_more"] forState:UIControlStateNormal];
    [moreCourse addTarget:self action:@selector(pushToChooseCourseCategoryVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreCourse];
    
}


#pragma mark - lazy

- (XSNavCouseChoseView *)navCoureCategoryView {
    if (_navCoureCategoryView == nil) {
        
        _navCoureCategoryView  = [[XSNavCouseChoseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 45 -35, 20)];
        self.navigationItem.titleView = _navCoureCategoryView;
        _navCoureCategoryView.delegate = self;
        _navCoureCategoryView.modelAry = @[@"推荐"].mutableCopy;
        
    }
    return _navCoureCategoryView;
}

- (UIScrollView *)backScrollView {
    if (_backScrollView == nil) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height  - 49)];
        _backScrollView.pagingEnabled = YES;
        _backScrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_backScrollView];
        _backScrollView.bounces = NO;
        _backScrollView.delegate = self;
        _backScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, _backScrollView.frame.size.height);
    }
    return _backScrollView;
}

- (NSMutableArray *)unUserTitleAry {
    if (_unUserTitleAry == nil) {
        _unUserTitleAry = [[NSMutableArray alloc] init];
    }
    return _unUserTitleAry;
}

@end







