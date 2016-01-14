//
//  NSArray+Ex.m
//  网易新闻-01
//
//  Created by 何建新 on 16/1/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "NSArray+Ex.h"
#import <objc/runtime.h>
@implementation NSArray (Ex)
//返回当前类的所有属性
+(instancetype)getProperties:(Class)cls{
    //return @[@"title",@"imgsrc"];
    //获取当前类的所有属性
    unsigned int count;
    //复制一个指定类并返回类的属性的数组,返回的是c语言格式
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    //遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        //获取属性的名称,返回的是c语言的字符串
        const char *cName = property_getName(property);
        //转换成OC字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    return mArray.copy;
    
}
@end
