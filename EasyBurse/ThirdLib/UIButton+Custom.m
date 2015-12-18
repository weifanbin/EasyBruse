//
//  UIButton+Custom.m
//  iosLib3
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "UIButton+Custom.h"
#import "UIImage+Custom.h"

@implementation UIButton (Custom)

+ (UIButton*)createButton:(CGRect)frame target:(id)target  action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (target&&action) {
        [button addAction:target action:action];
    }
    
    return button;
}
+ (UIButton*)createButton:(CGRect)frame target:(id)target  action:(SEL)action radius:(int)radius
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = radius;
    button.clipsToBounds = YES;
    button.frame = frame;
    if (target&&action) {
            [button addAction:target action:action];
    }

    return button;
}
- (void)addAction:(id)target  action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
- (void)setBackgroundImage:(NSString *)image Highlighted:(NSString *)highlightedImage
{
    [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];

}
- (void)setBackgroundColor:(UIColor *)backgroundColor Highlighted:(UIColor *)highlightedBackgroundColor
{
    [self setBackgroundImage:[UIImage imageByColor:backgroundColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageByColor:highlightedBackgroundColor] forState:UIControlStateHighlighted];
}
- (void)setColor:(UIColor *)color Highlighted:(UIColor *)highlightedColor
{
    [self setImage:[UIImage imageByColor:color] forState:UIControlStateNormal];
    [self setImage:[UIImage imageByColor:highlightedColor] forState:UIControlStateHighlighted];
}

- (void)setImage:(UIImage *)image imageFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor*)color
{
    UIImageView *leftImg = [[UIImageView alloc] initWithImage:image];
    leftImg.frame = frame;
    [self addSubview:leftImg];
    
    [self setTitle:title size:16 color:color Highlighted:color];
}

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setTitle:(NSString *)title size:(CGFloat)size color:(UIColor *)color Highlighted:(UIColor *)highlightedColor
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    [self.titleLabel setFont:[UIFont systemFontOfSize:size]];
}
@end
