//
//  UIView+Frame.h
//  MyTreasure
//
//  Created by Bryan on 15/11/12.
//  Copyright © 2015年 makervt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

- (UIView*)subViewWithTag:(int)tag ;

- (void)setCircleBorder:(UIColor*)color;

@end
