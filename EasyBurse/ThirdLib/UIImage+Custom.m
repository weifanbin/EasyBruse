//
//  UIImage+Custom.m
//  iosLib3
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "UIImage+Custom.h"
#define degreesToRadians(x) (M_PI * (x) / 180.0)
@implementation UIImage (Custom)
+ (UIImage *)imageByColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage*)imageByView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+ (UIImage *)imageByScreenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    } else {
        UIGraphicsBeginImageContext(imageSize);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
-(UIImage*)rotateImage:(UIImageOrientation)orient
{
    CGRect			bnds = CGRectZero;
    UIImage*		   copy = nil;
    CGContextRef	  ctxt = nil;
    CGRect			rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    bnds.size = self.size;
    rect.size = self.size;
    //CLog("%s, %d", __FUNCTION__, orient);
    switch (orient)
    {
        case UIImageOrientationUp:
            return self;
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, degreesToRadians(180.0));
            break;
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
        case UIImageOrientationLeft: {
            //CGFloat wd = bnds.size.width;
            //			bnds.size.width = bnds.size.height;
            //			bnds.size.height = wd;
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
        }
            break;
        case UIImageOrientationLeftMirrored: {
            //CGFloat wd = bnds.size.width;
            //			bnds.size.width = bnds.size.height;
            //			bnds.size.height = wd;
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
        }
            break;
        case UIImageOrientationRight: {
            CGFloat wd = bnds.size.width;
            bnds.size.width = bnds.size.height;
            bnds.size.height = wd;
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
        }
            break;
        case UIImageOrientationRightMirrored: {
            //CGFloat wd = bnds.size.width;
            //			bnds.size.width = bnds.size.height;
            //			bnds.size.height = wd;
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
        }
            break;
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    UIGraphicsBeginImageContext(rect.size);
    ctxt = UIGraphicsGetCurrentContext();
    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0 * (rect.size.width / rect.size.height), 1.0 * (rect.size.height / rect.size.width));
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(ctxt, rect, self.CGImage);
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return copy;
}



/*
 
 函数说明：改变照片的尺寸 此方法是宽度自定义    有关高度自定义研究代码后自己解决
 
 会根据图片的原尺寸来计算比例 通过宽度width和图片的比例来计算变化后的高度，计算比例是为了变化后不是图片变形
 
 
 参数说明 width 此参数就是希望图片变化成的宽度。
 
 参数说明 image 此参数是需要改变的图片
 
 返回值 变化后的图片
 
 */

- (UIImage*)imageWithImage:(UIImage*)image sacleToWidth:(CGFloat)width
{   /////放大或者缩小image到newSize的尺寸，根据宽
    // Create a graphics image context
    
    CGSize imageOriSize=image.size;
    
    float scale=imageOriSize.height/imageOriSize.width;
    
    CGSize newSize=CGSizeMake(width, width*scale);
    
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
- (UIImage *)normalizedImage {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){0, 0, self.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}
- (UIImage*)compress:(CGFloat)compressionQuality
{
    NSData   *sendImageData = UIImageJPEGRepresentation(self, 1);
    NSUInteger sizeOrigin = [sendImageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
   
     NSData *dataImage = UIImageJPEGRepresentation(self, compressionQuality);
    NSUInteger sizeend = [dataImage length];
    NSUInteger sizeEndKB = sizeend / 1024;
     NSLog(@"compress:%d to %d",sizeOriginKB,sizeEndKB);
  return  [UIImage imageWithData:dataImage];
}
- (UIImage*)compress
{
    NSData   *sendImageData = UIImagePNGRepresentation(self);
    NSUInteger sizeOrigin = [sendImageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    NSData *dataImage;
    if (sizeOriginKB > 100) {
//        float a = 160.0000;
//        float b = (float)sizeOriginKB;
//        float q = sqrtf(a / b);
//        CGSize sizeImage = [self size];
//        CGFloat widthSmall = sizeImage.width * q;
//        CGFloat heighSmall = sizeImage.height * q;
//        CGSize sizeImageSmall = CGSizeMake(700, heighSmall*(700/widthSmall));
//        UIGraphicsBeginImageContext(sizeImageSmall);
//        CGRect smallImageRect = CGRectMake(0, 0, 700, sizeImageSmall.height);
//        [self drawInRect:smallImageRect];
//        UIImage *smallImage2 = UIGraphicsGetImageFromCurrentImageContext();
        dataImage = UIImagePNGRepresentation(self);
        
    }
    else{
        dataImage=sendImageData;
        
    }
    
    
    NSUInteger sizeend = [dataImage length];
    NSUInteger sizeEndKB = sizeend / 1024;
    NSLog(@"compress:%d to %d",sizeOriginKB,sizeEndKB);
    return  [UIImage imageWithData:dataImage];
    
}

@end
