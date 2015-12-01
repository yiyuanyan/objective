//
//  UIImage+Ex.m
//  彩票test
//
//  Created by 何建新 on 15/11/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "UIImage+Ex.h"

@implementation UIImage (Ex)
-(UIImage *)originalImage
{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
