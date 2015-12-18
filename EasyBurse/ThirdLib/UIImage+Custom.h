//
//  UIImage+Custom.h
//  iosLib3
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Custom)
+ (UIImage *)imageByColor:(UIColor *)color;
+ (UIImage*)imageByView:(UIView *)view;
+ (UIImage *)imageByScreenshot;
-(UIImage*)rotateImage:(UIImageOrientation)orient;

- (UIImage*)imageWithImage:(UIImage*)image sacleToWidth:(CGFloat)width;
- (UIImage *)normalizedImage;
- (UIImage*)compress:(CGFloat)compressionQuality;
- (UIImage*)compress;
@end
