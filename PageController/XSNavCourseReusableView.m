//
//  XSNavCourseReusableView.m
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/22.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSNavCourseReusableView.h"
#import "UIColor+Hex.h"
#import "UIImage+Common.h"
#import "Masonry.h"
@interface XSNavCourseReusableView ()
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation XSNavCourseReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self addSubViews];
        UILabel *lable = [[UILabel alloc] initWithFrame:self.frame];
        [self addSubview:lable];
        lable.text = @"djdjdddddddddd";
        lable.backgroundColor = [UIColor orangeColor];
        
    }
    return  self;
}

#pragma mark - func

- (void)addSubViews {
    
    [self didAddSubview:self.categoryView];
}

#pragma mark - cation

- (void)categoryBtnClick:(UIButton *)sender {
    NSLog(@"分类头部点击");
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
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/4 *index, 0, self.frame.size.width/4, 60)];
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
- (UIView *)categoryView {
    if (_categoryView == nil) {
        
        _categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
        _categoryView.backgroundColor = [UIColor blueColor];
    }
    return _categoryView;
}

@end
