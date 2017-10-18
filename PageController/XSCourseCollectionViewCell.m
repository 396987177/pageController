//
//  XSCourseCollectionViewCell.m
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/22.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSCourseCollectionViewCell.h"

@interface XSCourseCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *statusLbl;
@property (nonatomic, strong) UILabel *courseLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *teachLabel;
@property (nonatomic, strong) UIImageView *tipImageView;

@end

@implementation XSCourseCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        self.backgroundColor = [UIColor clearColor];
        
        _imageView = [[UIImageView alloc]init];
        
        _imageView.backgroundColor = [UIColor colorWithHex:0xe7e7e7];
        _imageView.layer.cornerRadius = 2;
        _imageView.layer.masksToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(186/2);
        }];
        
        
        UIImageView *maskView = [[UIImageView alloc] init];
        maskView.image = [UIImage imageNamed:@"courseVC_item_mask"];
        [_imageView addSubview:maskView];
        
        [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(_imageView);
            make.height.mas_equalTo(62/2);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"正在直播: 08:00-10:00";

        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:11];
        [_imageView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageView).offset(8);
            make.bottom.equalTo(_imageView).offset(-6);
        }];
        
        
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"courseVC_item_vip"];
        //_tipImageView.hidden = YES;
        [_imageView addSubview:_tipImageView];
        
        [_tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_imageView);
            make.width.mas_equalTo(68/2);
            make.height.equalTo(@15);
        }];
        
        _statusLbl = [[UILabel alloc] init];
        _statusLbl.text = @"VIP";
        _statusLbl.textColor = [UIColor whiteColor];
        _statusLbl.textAlignment = NSTextAlignmentCenter;
        _statusLbl.font = [UIFont systemFontOfSize:10];
        [_tipImageView addSubview:_statusLbl];
        
        [_statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_tipImageView);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHex:0x2a2a2a];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.text = @"ai正式课程体验";

        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(_imageView.mas_bottom).offset(10/2);
        }];
        
       
        _courseLabel = [[UILabel alloc] init];
        _courseLabel.text = @"平面设计";
        _courseLabel.textAlignment = NSTextAlignmentRight;
        _courseLabel.font = [UIFont systemFontOfSize:12];
        _courseLabel.textColor = [UIColor colorWithHex:0x7f8499];
        [self.contentView addSubview:_courseLabel];
        
        [_courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(10/2);
            make.right.equalTo(self.contentView);
        }];
        

        _teachLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+7, CGRectGetWidth(self.frame), 12)];
        _teachLabel.text = @"主讲：鲁班主讲：鲁班";
        _teachLabel.textColor = [UIColor colorWithHex:0x7f8499];
        _teachLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_teachLabel];
        
        [_teachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(10/2);
            make.left.equalTo(self.contentView);
            make.right.lessThanOrEqualTo(_courseLabel.mas_left);
        }];
        
    }
    return self;
}

@end
