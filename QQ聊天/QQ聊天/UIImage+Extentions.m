//
//  UIImage+Extentions.m
//  QQ聊天
//
//  Created by 何建新 on 15/10/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "UIImage+Extentions.h"

@implementation UIImage (Extentions)
+(instancetype)resizableImageWithName:(NSString *)imageName
{
    //创建普通图片
    UIImage *image = [UIImage imageNamed:imageName];
    //计算帽子的大小
    CGSize imageSize = image.size;
    CGFloat capLeft = imageSize.width * 0.5;
    CGFloat capRight = capLeft;
    CGFloat capTop = imageSize.height * 0.5;
    CGFloat capBottom = capTop;
    //拉伸图片
    //第二种方法
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(capTop, capLeft, capBottom, capRight)];
}
@end
