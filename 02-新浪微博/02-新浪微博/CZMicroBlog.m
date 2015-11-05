//
//  CZMicroBlog.m
//  02-新浪微博
//
//  Created by 何建新 on 15/10/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMicroBlog.h"

@implementation CZMicroBlog
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)microBlogWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
+(NSArray *)microBlogs
{
    //获取plist路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"microBlogs" ofType:@"plist"];
    //将文件读入数组
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *temArray = [[NSMutableArray alloc]initWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        CZMicroBlog *microBlog = [self microBlogWithDict:dict];
        [temArray addObject:microBlog];
    }
    return temArray;
}
@end
