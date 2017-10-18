//
//  XLChannelView.h
//  XLChannelControlDemo
//
//  Created by MengXianLiang on 2017/3/3.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLChannelView : UIView

@property (nonatomic, strong) NSMutableArray *inUseTitles;

@property (nonatomic,strong) NSMutableArray *unUseTitles;

/*编辑状态*/
@property (nonatomic, assign) BOOL editStatus;

/* 是否编辑过 */
@property (nonatomic, assign) BOOL isChange;

/*点击跳出到查看界面*/
@property (nonatomic, copy) void (^didClickCategoryItem)(NSString *title, BOOL isChagne);

-(void)reloadData;

@end
