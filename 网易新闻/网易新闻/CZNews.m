//
//  CZNews.m
//  网易新闻
//
//  Created by 何建新 on 16/1/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZNews.h"
#import "NSArray+Ex.h"
#import "CZNetworkTool.h"
@implementation CZNews
+(instancetype)newsWithDic:(NSDictionary *)dic{
    id news = [self new];
    //获取当前类的所有属性
    NSArray *names = [NSArray getProperties:[self class]];
    for (NSString *name in names) {
        if (dic[name]) {
            [news setValue:dic[name] forKey:name];
        }
    }
    return news;
}

+(void)newsList:(void(^)(NSArray *array))success error:(void(^)(NSError *err))error{
    //设置可解析的数据格式
    [CZNetworkTool sharedTool].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    [[CZNetworkTool sharedTool] GET:@"article/headline/T1348647853363/0-140.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *dic) {
        //获取字典的第一个键
        NSString *rootKey = dic.keyEnumerator.nextObject;
        NSArray *array = dic[rootKey];
        //字典转模型
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *modelDic in array) {
            CZNews *news = [self newsWithDic:modelDic];
            [mArray addObject:news];
        }
        if (success) {
            success(mArray.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull e) {
        if (error) {
            error(e);
        }
    }];
}
@end
