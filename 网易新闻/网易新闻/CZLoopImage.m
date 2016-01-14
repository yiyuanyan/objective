//
//  CZLoopImage.m
//  网易新闻
//
//  Created by 何建新 on 16/1/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZLoopImage.h"
#import "NSArray+Ex.h"
#import "CZNetworkTool.h"
@implementation CZLoopImage
+(instancetype)loopImage:(NSDictionary *)dic{
    id loopImage = [self new];
    NSArray *names = [NSArray getProperties:[self class]];
    //获取所有属性，遍历 给属性赋值
    for (NSString *name in names) {
        //如果dic[]为空赋值会失败所以要判断
        if (dic[name]) {
            [loopImage setValue:dic[name] forKey:name];
        }
    }
    return loopImage;
}
//发送网络请求获取数据
//此方法不能直接返回数据，因为是异步请求。要使用回调函数
+ (void)loopImages:(void(^)(NSArray *array))success error:(void(^)(NSError *error))error{
    [[CZNetworkTool sharedTool] GET:@"ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *dic) {
        //成功
        //获取到字典中得第一项dic.keyEnumerator.nextObject返回的是字符串，是字典的第一个键
        NSString *rootKey = dic.keyEnumerator.nextObject;
        //获取字典指定键的值
        NSArray *array = dic[rootKey];
        //字典转模型
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *modelDic in array) {
            CZLoopImage *loopImage = [CZLoopImage loopImage:modelDic];
            [mArray addObject:loopImage];
        }
        //回调
        if (success) {
            success(mArray.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        //失败
        if (error) {
            error(err);
        }
    }];
}
@end
