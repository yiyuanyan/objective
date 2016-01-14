//
//  NSArray+JSON.m
//  POST登录
//
//  Created by 何建新 on 15/12/24.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "NSArray+JSON.h"

@implementation NSArray (JSON)
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
