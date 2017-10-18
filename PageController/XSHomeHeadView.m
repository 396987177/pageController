//
//  XSHomeHeadView.m
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/20.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSHomeHeadView.h"

static CGFloat butonWH          = 70/2;
static CGFloat voiceViewH       = 44;
static CGFloat cycleViewH       = 150;
static CGFloat totalH           = 580/2;
static CGFloat cuourseViewH     = 96;

@interface XSHomeHeadView ()
@property (nonatomic, strong) UIView *courseView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) NSMutableArray *categoryButtonAry;
@property (nonatomic, assign) CGFloat marginW;
@property (nonatomic, strong) UILabel *typeLable;
@property (nonatomic, assign) NSInteger     tempTime;


@end

@implementation XSHomeHeadView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        // 情景二：采用网络图片实现
        NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];
        
        // 情景三：图片配文字
        NSArray *titles = @[@"新建交流QQ群：185534916 ",
                            @"disableScrollGesture可以设置禁止拖动",
                            @"感谢您的支持，如果下载的",
                            @"如果代码在使用过程中出现问题",
                            @"您可以发邮件到gsdios@126.com"
                            ];
        

        // 网络加载图片的轮播器
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, cycleViewH) delegate:nil placeholderImage:[UIImage imageNamed:@"main_homeHead_cycleBannar.jpg"]];
        
        cycleScrollView.autoScrollTimeInterval = 5.0f;
        _cycleScrollView = cycleScrollView;
        //_cycleScrollView.autoScroll = NO;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.titlesGroup = titles;
        cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        
        [self addSubview:cycleScrollView];
        
        //模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        });
        [self addSubViews];
    }

    return self;
}

#pragma mark - Private method

- (void)addSubViews {
    [self addSubview:self.courseView];
}


// 当前时间戳
-(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

// 时间处理
- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime{
    //formatTime = @"2017.07.02 12:00";
    formatTime = [formatTime stringByReplacingOccurrencesOfString:@"/" withString:@"."];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY.MM.dd HH:mm"];
    NSDate* date = [formatter dateFromString:formatTime];
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSLog(@"将某个时间转化成 时间戳:%ld",(long)timeSp);
    return timeSp;
}

#pragma mark - button action

- (void)courseButtonClock:(UIButton *)sender {
    
    !self.courCategoryBlock ?: self.courCategoryBlock(sender.tag);

}

- (void)voiceBtnBackViewDiclick:(UIButton *)sender {
    !self.voiceActionBlock ? :self.voiceActionBlock();
}



#pragma mark - lazy


- (UIView *)courseView {
    if (_courseView == nil) {
        _courseView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame), self.frame.size.width, cuourseViewH)];
        
         NSArray *titleAry = @[@"No. 1", @"No. 2", @"No. 3", @"No. 4"];

        NSArray *imageAry = @[@"main_homeHead_vipCourse",@"main_homeHead_livingCourse",@"main_homeHead_openCourse",@"main_homeHead_skill"];
        
        CGFloat buttonSW = (self.frame.size.width )/titleAry.count;
        for (int index = 0; index < titleAry.count; ++index) {
        
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(index *buttonSW, 0, buttonSW, cuourseViewH);
            //[button setImage:[UIImage imageNamed:imageAry[index]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xf0f4f8]] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(courseButtonClock:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = index;
            [_courseView addSubview:button];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageAry[index]] ];
            [button addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button).offset(19);
                make.centerX.equalTo(button);
            }];
            
            UILabel *lable = [[UILabel alloc] init];
            lable.font = [UIFont systemFontOfSize:12.0f];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = titleAry[index];
            lable.textColor = [UIColor colorWithHex:0x666b81];
            [button addSubview:lable];
            lable.frame = CGRectMake(index *self.frame.size.width/4, CGRectGetMaxY(button.frame) +10, self.frame.size.width/4, 13);

            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_bottom).offset(10);
                make.centerX.equalTo(imageView);
            }];
        }
    }
    return _courseView;
}

- (UIButton *)voiceBtnBackView {
    if (_voiceBtnBackView == nil) {
        
        _voiceBtnBackView = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceBtnBackView.frame = CGRectMake(0, CGRectGetMaxY(self.courseView.frame), self.frame.size.width, voiceViewH);
        [_voiceBtnBackView addTarget:self action:@selector(voiceBtnBackViewDiclick:) forControlEvents:UIControlEventTouchUpInside];
        [_voiceBtnBackView setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xf0f4f8]] forState:UIControlStateHighlighted];
        
        UIImageView *imageView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"main_headView_voiceIcon"]];
        [_voiceBtnBackView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_voiceBtnBackView).offset(39/2);
            make.centerY.equalTo(_voiceBtnBackView);
            make.width.mas_equalTo(112/2);
            make.height.mas_equalTo(51/2);
        }];
        
        UILabel *typeLable = [[UILabel alloc] init];
        _typeLable = typeLable;
        typeLable.textColor = [UIColor colorWithHex:0x428df4];
        typeLable.textAlignment = NSTextAlignmentCenter;
        typeLable.font = [UIFont systemFontOfSize:12.f];
        typeLable.text = @"音频";
        [_voiceBtnBackView addSubview:typeLable];
        
        [typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_voiceBtnBackView);
            make.left.equalTo(imageView.mas_right).offset(36/2);
            make.width.mas_equalTo(74/2);
        }];
        
        UIImageView *boardView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"recommend_voice_ border"]];
        [_voiceBtnBackView addSubview:boardView];
        [boardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(typeLable);
        }];
        
        
        UILabel *titleLable = [[UILabel alloc] init];
        _titleLable = titleLable;
        titleLable.font = [UIFont systemFontOfSize:14.f];
        titleLable.textColor = [UIColor colorWithHex:0x2a2a2a];
        titleLable.text = @"分享我的故事";
        [_voiceBtnBackView addSubview:titleLable];
        
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_voiceBtnBackView);
            make.left.equalTo(typeLable.mas_right).offset(6);
            make.right.equalTo(_voiceBtnBackView).offset(-15);
        }];
    }
    return _voiceBtnBackView;;
}

- (NSMutableArray *)categoryButtonAry {
    if (_categoryButtonAry != nil) {
        _categoryButtonAry = @[].mutableCopy;
    }
    return _categoryButtonAry;
}

@end









