//
//  XSRecommendCell.h
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/22.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XSRecommendCell : XSBaseTableViewCell

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) void (^courseItemDiclickBlock)();

@end
