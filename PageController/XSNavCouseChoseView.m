//
//  XSNavCouseChoseView.m
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/21.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSNavCouseChoseView.h"

@interface XSNavCouseChoseView ()

@property (nonatomic, strong) UIImageView *selectedLine;
@property (nonatomic, assign) float selectedLineHeight;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIImageView *maskView;

@property (nonatomic, assign) BOOL isDrag;

@end

@implementation XSNavCouseChoseView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        [self addSubview:self.maskView];
    }
    return self;
}

#pragma mark - set

- (void)setCurrentBtnIndex:(NSInteger)currentBtnIndex {
    _currentBtnIndex =currentBtnIndex;
    UIButton *currentBtn = [_scrollView viewWithTag:currentBtnIndex+10];
    _isDrag = YES;
    [self selectedItem:currentBtn];
    
}



- (void)setModelAry:(NSMutableArray *)modelAry {
    
    _modelAry = modelAry;
    for (UIView * views in _scrollView.subviews) {
        if ([views isKindOfClass:[UIButton class]]) {
            [views removeFromSuperview];
        }
    }
    _scrollView.frame = self.bounds;
    CGSize scrollViewContentSize = CGSizeMake(0, CGRectGetHeight(_scrollView.frame));
    for (int i = 0; i<modelAry.count; i++) {
        
        
        NSString * title = modelAry[i] ;
        
        NSDictionary *titleAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
        CGSize size = [title boundingRectWithSize:CGSizeMake(CGRectGetWidth(_scrollView.frame)-75/2, CGRectGetHeight(_scrollView.frame)) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:titleAttribute context:nil].size;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(15+scrollViewContentSize.width, 0, size.width, CGRectGetHeight(_scrollView.frame))];
        [button setTitle:title forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [button setTitleColor:[UIColor colorWithHex:0x000000] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:0x428df4] forState:UIControlStateSelected];
        
        [button setTag:i+10];
        
        [button addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:button];
        scrollViewContentSize.width += size.width+30;//每个item 间隔
        _scrollView.contentSize = scrollViewContentSize  ;
        
    }
    
    // 控制控件居中
    if (_scrollView.contentSize.width <= self.frame.size.width) {
        _scrollView.frame = CGRectMake((self.frame.size.width - _scrollView.contentSize.width)/2 , 0, _scrollView.contentSize.width, self.frame.size.height);
    }
    
    //选择先  初始位置
    _selectBtn = (UIButton *)[_scrollView viewWithTag:10];
    _selectBtn.selected = YES;
}




#pragma mark - button action
-(void)selectedItem:(UIButton *)sender{
    // 动画
    [_selectBtn setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    [UIView animateWithDuration:0.25 animations:^{
        [sender setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    }];
    
    _selectBtn.selected = NO;
    _selectBtn = sender;
    sender.selected = YES;
    [self showCurretItemWithButton:sender];
    
    if (_isDrag) {
        _isDrag = NO;
        return;
    }
    if ([self.delegate respondsToSelector:@selector(XSNavChooseView:clickItem:withIndex:)]) {
        [self.delegate XSNavChooseView:self clickItem:_modelAry[sender.tag - 10] withIndex:sender.tag-10];
    }
    
}


// 位移控制相关
- (void)showCurretItemWithButton:(UIButton *)selectBtn{
    
    CGFloat offsetX = selectBtn.center.x- self.frame.size.width * 0.5;
    if(offsetX <0) {
        offsetX =0;
    }
    
    CGFloat maxOffsetX =_scrollView.contentSize.width - self.frame.size.width;
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if(offsetX > maxOffsetX ) {
        offsetX = maxOffsetX ;
    }
    
    [_scrollView setContentOffset:CGPointMake(offsetX,0)animated:YES];
    
}

#pragma mark - lazy

- (UIImageView *)maskView {
    if (_maskView == nil) {
        _maskView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame)- 15, 0 ,16,CGRectGetHeight(_scrollView.frame))];
        _maskView.image = [UIImage imageNamed:@"main_nav_whiteMask"];
        _maskView.backgroundColor = [UIColor clearColor];
        
    }
    return _maskView;
}


@end





