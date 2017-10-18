//
//  XSNavCouseChoseView.h
//  XSTeachEDU
//
//  Created by L_晨曦 on 2017/9/21.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XSNavChooseScrollViewDelegate;
@interface XSNavCouseChoseView : UIView

@property(strong ,nonatomic) NSMutableArray * modelAry;
@property(strong ,nonatomic) id<XSNavChooseScrollViewDelegate> delegate;
@property(strong  ,nonatomic)  UIScrollView * scrollView;

/*  跳转到选择的按钮 */
@property (nonatomic, assign) NSInteger currentBtnIndex;

-(void)selectedItem:(UIButton *)sender;

@end


@protocol XSNavChooseScrollViewDelegate <NSObject>

-(void)XSNavChooseView:(XSNavCouseChoseView *)chooseView clickItem:( id)itemModel withIndex:(NSInteger )index;


@end
