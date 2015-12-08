//
//  UIImage+ZJ.m
//  Babytop
//
//  Created by 郑敬 on 14-5-10.
//  Copyright (c) 2014年 babytop. All rights reserved.
//

#import "UIImage+ZJ.h"

@implementation UIImage (ZJ)

// new_feature_1.png
+ (UIImage *)fullscrennImage:(NSString *)imgName
{
    // 1.如果是iPhone5，对文件名特殊处理
    //    if (iPhone5) {
    //        imgName = [imgName fileAppend:@"-568h@2x"];
    //    }
    
    // 2.加载图片
    return [self imageNamed:imgName];
}

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

//对图片尺寸进行压缩--
-(UIImage*)reduceImage
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(self.size);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,self.size.width,self.size.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    
    NSData *imageData = UIImageJPEGRepresentation(newImage,0.00001);
    UIImage  *m_selectImage = [UIImage imageWithData:imageData];
    
    return m_selectImage;
}

- (NSString *)encodeToBase64String {
    return [UIImagePNGRepresentation(self) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
    }
}
@end
