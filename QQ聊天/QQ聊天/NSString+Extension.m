//
//  NSString+Extension.m
//  QQ聊天
//
//  Created by 何建新 on 15/10/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize) sizeWithMaxSize:(CGSize) maxSize andFont:(UIFont *)font
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;

}
@end
