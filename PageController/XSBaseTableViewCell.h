//
//  XSBaseTableViewCell.h
//  XSTeachEDU
//
//  Created by xsteach on 14/12/19.
//  Copyright (c) 2014年 xsteach.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)addOwnViews;
- (void)addConstraints;

- (void)setupInit;

+ (NSString *)identifer;

@end
