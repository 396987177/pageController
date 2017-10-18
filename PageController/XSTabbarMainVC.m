//
//  XSTabbarMainVC.m
//  XSTeachEDU
//
//  Copyright (c) 2017年 xsteach.com. All rights reserved.
//

#import "XSTabbarMainVC.h"
#import "XSHomePageVC.h"
#import "XSMyTabar.h"


@interface XSTabbarMainVC ()<UITabBarControllerDelegate, UINavigationControllerDelegate>
{
    XSHomePageVC            *_homePageVC;
    NSInteger               currentIndex;
}
@property (nonatomic, strong) UITabBarItem *tempBtn;
@property (nonatomic, assign) NSInteger     index;
@end

@implementation XSTabbarMainVC



- (void)viewDidLoad {
    [super viewDidLoad];
    XSMyTabar *myTabBar = [[XSMyTabar alloc] init];
    [self setValue:myTabBar forKey:@"tabBar"];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.translucent = NO;
    
    _homePageVC = [[XSHomePageVC alloc] init];
    _homePageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                             image:[UIImage imageNamed:@"tabbar_homePage"]
                                                     selectedImage:[[UIImage imageNamed:@"tabbar_homePage_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _homePageVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    UINavigationController *courseNav = [[UINavigationController alloc] initWithRootViewController:_homePageVC];
    
    
    UIViewController *myCourseVC = [[UIViewController alloc] init];

    myCourseVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"课程"
                                                          image:[UIImage imageNamed:@"tabbar_myCourse"]
                                                  selectedImage:[[UIImage imageNamed:@"tabbar_myCourse_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UINavigationController *chatNav = [[UINavigationController alloc] initWithRootViewController:myCourseVC ];

    
    
    UIViewController *bbsMainVC = [[UIViewController alloc] init];
    bbsMainVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"版块"
                                                          image:[UIImage imageNamed:@"tabbar_BBS"]
                                                  selectedImage:[[UIImage imageNamed:@"tabbar_BBS_highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    bbsMainVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    UINavigationController *bbsNav = [[UINavigationController alloc] initWithRootViewController:bbsMainVC ];
    bbsNav.delegate = self;
    
    
    UIViewController *meMainVC = [[UIViewController alloc] init];
    meMainVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                         image:[UIImage imageNamed:@"tabbar_me"]
                                                 selectedImage:[[UIImage imageNamed:@"tabbar_me_highlighted"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    meMainVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meMainVC ];
    meNav.delegate = self;
    NSArray *items = @[courseNav, chatNav, bbsNav, meNav];
    [self setViewControllers:items];
    
    
   }


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    return YES;
}




#pragma mark - 私有方法

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
        self.tabBar.clipsToBounds = NO;
}



- (UITabBarItem *)tempBtn{
    
    if (_tempBtn == nil) {
        _tempBtn = [[UITabBarItem alloc]init];
    }
    
    return _tempBtn;
}


@end
