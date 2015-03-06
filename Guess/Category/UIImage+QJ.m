//
//  UIImage+QJ.m
//  Guess
//
//  Created by QJ on 15/3/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "UIImage+QJ.h"

@implementation UIImage (QJ)
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
@end
