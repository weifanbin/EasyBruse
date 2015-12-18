//
//  UIButton+Custom.h
//  iosLib3
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)
+ (UIButton*)createButton:(CGRect)frame target:(id)target  action:(SEL)action;
+ (UIButton*)createButton:(CGRect)frame target:(id)target  action:(SEL)action radius:(int)radius;
- (void)addAction:(id)target  action:(SEL)action;
- (void)setBackgroundColor:(UIColor *)backgroundColor Highlighted:(UIColor *)highlightedBackgroundColor;
- (void)setBackgroundImage:(NSString *)image Highlighted:(NSString *)highlightedImage;
- (void)setColor:(UIColor *)color Highlighted:(UIColor *)highlightedColor;
- (void)setTitle:(NSString *)title size:(CGFloat)size color:(UIColor *)color Highlighted:(UIColor *)highlightedColor;
- (void)setImage:(UIImage *)image imageFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor*)color;
- (void)setTitle:(NSString *)title;
@end
