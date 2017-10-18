//
//  XLChannelItem.m
//  XLChannelControlDemo
//
//  Created by MengXianLiang on 2017/3/3.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLChannelItem.h"
#import "Masonry.h"
@interface XLChannelItem (){
    
    CAShapeLayer *_borderLayer;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation XLChannelItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.userInteractionEnabled = true;
    self.layer.cornerRadius = 5.0f;
    //self.backgroundColor = [self backgroundColor];
    self.backgroundColor = [UIColor whiteColor];
    _titleLabel = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [self textColor];
   // _titleLabel.adjustsFontSizeToFitWidth = true;
   // _titleLabel.userInteractionEnabled = true;
    _titleLabel.text = @"工业设计";
    _titleLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_titleLabel];
    
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_edit_recommend"]];
    [self.contentView addSubview:_iconView];
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _editButton.userInteractionEnabled = NO;
    [_editButton setImage:[UIImage imageNamed:@"category_edit_add"] forState:UIControlStateNormal];
    [_editButton setImage:[UIImage imageNamed:@"category_edit_delect"] forState:UIControlStateSelected];
    [self.contentView addSubview:_editButton];
    
    [self addSubViewConstraint] ;
    [self addBorderLayer];
}

-(void)addBorderLayer{
    _borderLayer = [CAShapeLayer layer];
    _borderLayer.bounds = self.bounds;
    _borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:_borderLayer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    _borderLayer.lineWidth = 1;
    _borderLayer.lineDashPattern = @[@5, @3];
    _borderLayer.fillColor = [UIColor clearColor].CGColor;
    _borderLayer.strokeColor = [self backgroundColor].CGColor;
    [self.layer addSublayer:_borderLayer];
    _borderLayer.hidden = true;
}

- (void)addSubViewConstraint {

    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
        make.height.width.mas_equalTo(54/2);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_iconView.mas_bottom).offset(20);
    }];
    
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_iconView).offset(34/4);
        make.bottom.equalTo(_iconView).offset(34/4);
        make.width.height.mas_equalTo(34/2);
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //_titleLabel.frame = self.bounds;
}

#pragma mark -
#pragma mark 配置方法

-(UIColor*)backgroundColor{
    return [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1];
}

-(UIColor*)textColor{
    return [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1];
}

-(UIColor*)lightTextColor{
    return [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];
}

#pragma mark -
#pragma mark Setter

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

-(void)setIsMoving:(BOOL)isMoving
{
    _isMoving = isMoving;
    if (_isMoving) {
        self.backgroundColor = [UIColor whiteColor];
        _borderLayer.hidden = false;
    }else{
        //self.backgroundColor = [self backgroundColor];
        self.backgroundColor = [UIColor whiteColor];

        _borderLayer.hidden = true;
    }
}

-(void)setIsFixed:(BOOL)isFixed{
    _isFixed = isFixed;
    if (isFixed) {
        _titleLabel.textColor = [self lightTextColor];
    }else{
        _titleLabel.textColor = [self textColor];
    }
}

@end
