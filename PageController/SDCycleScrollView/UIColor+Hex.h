//
//  UIColor+UIColor_extra_h.h
//  PAChat
//
//  Created by xiao on 8/12/14.
//  Copyright (c) 2014 FreeDo. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (Hex)

#define kColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end