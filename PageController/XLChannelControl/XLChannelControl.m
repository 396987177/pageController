//
//  XLChannelControl.m
//  XLChannelControlDemo
//
//  Created by MengXianLiang on 2017/3/3.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLChannelControl.h"
#import "XLChannelView.h"

@interface XLChannelControl ()
{
    UINavigationController *_nav;
    
    XLChannelView *_channelView;
    
    UIButton *_leftBtn;
    
    ChannelBlock _block;
}
@end

@implementation XLChannelControl

+(XLChannelControl*)shareControl{
    static XLChannelControl *control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[XLChannelControl alloc] init];
    });
    return control;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self buildChannelView];
    }
    return self;
}

-(void)buildChannelView{
    
    _channelView = [[XLChannelView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    __weak typeof(self) weakSelf = self;
    _channelView.didClickCategoryItem = ^(NSString *title,BOOL isChange) {
        [weakSelf backMethodWhenDidClick:title];
    };
    
    _nav = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    _nav.navigationBar.tintColor = [UIColor blackColor];
    _nav.topViewController.title = @"频道管理";
    _nav.topViewController.view = _channelView;
    _nav.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backMethod)];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //66,141,244
    UIColor *color = [UIColor colorWithRed:66/255.0 green:141/255.0 blue:244/255.0 alpha:1];
    
    [_leftBtn setTitleColor:color forState:UIControlStateNormal];
    [_leftBtn setTitleColor:color forState:UIControlStateSelected];

    [_leftBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_leftBtn setTitle:@"完成" forState:UIControlStateSelected];
    [_leftBtn sizeToFit];
    [_leftBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchDown];
    _nav.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
}


- (void)editAction:(UIButton*)sender {
    
    sender.selected = !sender.selected;
    // 编辑状态 是否;
    _channelView.editStatus = sender.isSelected;
    
    
    
    
}


- (void)backMethodWhenDidClick:(NSString *)title {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _nav.view.frame;
        frame.origin.y = - _nav.view.bounds.size.height;
        _nav.view.frame = frame;
    }completion:^(BOOL finished) {
        [_nav.view removeFromSuperview];
    }];
    _block(_channelView.inUseTitles,_channelView.unUseTitles,title, _channelView.isChange);
    [self changeStatus];
}

- (void)backMethod {
    /*
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _nav.view.frame;
        frame.origin.y = - _nav.view.bounds.size.height;
        _nav.view.frame = frame;
    }completion:^(BOOL finished) {
        [_nav.view removeFromSuperview];
    }];
    _block(_channelView.inUseTitles,_channelView.unUseTitles,nil, _channelView.isChange);
    [self changeStatus];
  */
    [self backMethodWhenDidClick:nil];
}


- (void)changeStatus {
    _channelView.isChange = NO;
    _leftBtn.selected = NO;
    _channelView.editStatus = NO;
    [_channelView reloadData];
}

-(void)showChannelViewWithInUseTitles:(NSArray*)inUseTitles unUseTitles:(NSArray*)unUseTitles finish:(ChannelBlock)block{
    _block = block;
    _channelView.inUseTitles = [NSMutableArray arrayWithArray:inUseTitles];
    _channelView.unUseTitles = [NSMutableArray arrayWithArray:unUseTitles];
    [_channelView reloadData];

    CGRect frame = _nav.view.frame;
    frame.origin.y = - _nav.view.bounds.size.height;
    _nav.view.frame = frame;
    _nav.view.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_nav.view];
    [UIView animateWithDuration:0.3 animations:^{
        _nav.view.alpha = 1;
        _nav.view.frame = [UIScreen mainScreen].bounds;
    }];
}

@end
