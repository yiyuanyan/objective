//
//  NSString+Extension.m
//  weibo 16
//
//  Created by 何建新 on 16/1/29.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font
{
    NSDictionary *att = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self sizeWithAttributes:att];
}

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    NSDictionary *att = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
}
@end
