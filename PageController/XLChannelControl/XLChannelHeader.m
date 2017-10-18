//
//  XLChannelHeaderView.m
//  XLChannelControlDemo
//
//  Created by MengXianLiang on 2017/3/3.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLChannelHeader.h"

@interface XLChannelHeader ()
{
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
}
@end

@implementation XLChannelHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    CGFloat marginX = 15.0f;
    
    //CGFloat labelWidth = (self.bounds.size.width - 2*marginX)/2.0f;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX, 0, 16 *4 +15, self.bounds.size.height)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.text = @"我的科目";
    [self addSubview:_titleLabel];
    
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0,self.bounds.size.width -  CGRectGetMaxX(_titleLabel.frame)-2*marginX, self.bounds.size.height)];
    _subtitleLabel.textColor = [UIColor lightGrayColor];
    _subtitleLabel.textAlignment = NSTextAlignmentLeft;
    _subtitleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:_subtitleLabel];
    
    
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

-(void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    _subtitleLabel.text = subTitle;
}

@end
