//
//  XSHomeHeadView.h
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/20.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface XSHomeHeadView : UIView
@property (nonatomic, strong)  SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIButton *voiceBtnBackView;
@property (nonatomic, strong) UITableView *tableView;

/*课程分类点击*/
@property (nonatomic, copy) void (^courCategoryBlock)(NSInteger index);

@property (nonatomic, copy) void (^voiceActionBlock)();



@end
