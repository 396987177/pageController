//
//  XSBaseTableViewCell.m
//  XSTeachEDU
//
//  Created by xsteach on 14/12/19.
//  Copyright (c) 2014年 xsteach.com. All rights reserved.
//

#import "XSBaseTableViewCell.h"

@implementation XSBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XSBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupInit];
        [self addOwnViews];
        [self addConstraints];
    }
    return self;
}

- (void)setupInit {
    self.backgroundColor = [UIColor whiteColor];
    UIView * selectedView = [[UIView alloc]initWithFrame:CGRectZero];
    selectedView.backgroundColor = [UIColor colorWithHex:0xF7F7F9];
    self.selectedBackgroundView = selectedView;
}

- (void)addOwnViews {}
- (void)addConstraints{}

+ (NSString *)identifer {
    return NSStringFromClass([self class]);
}

@end
