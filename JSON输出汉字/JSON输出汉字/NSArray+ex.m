//
//  NSArray+ex.m
//  JSON输出汉字
//
//  Created by 何建新 on 15/12/21.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "NSArray+ex.h"

@implementation NSArray (ex)
//重写description的get方法
-(NSString *)description
{
    //NSLog(@"array test");
    return @"array test";
}
//建立分类文件，重写descriptionWithLocale:方法，将编码转换成字符串，此方法可不引入文件头
-(NSString *)descriptionWithLocale:(id)locale
{
    //创建可变字符
    NSMutableString *mstr = [NSMutableString string];
    //
    [mstr appendString:@"(\r\n"];
    //枚举形式便利数组，并替换字符
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mstr appendFormat:@"\t\"%@\",\r\n",obj];
    }];
    [mstr appendString:@")"];
    return mstr.copy;
}
@end
