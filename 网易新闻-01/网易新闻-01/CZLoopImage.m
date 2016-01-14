//
//  CZLoopImage.m
//  网易新闻-01
//
//  Created by 何建新 on 16/1/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZLoopImage.h"
#import "NSArray+Ex.h"
#import "CZNetworkTool.h"
@implementation CZLoopImage
+(instancetype)loopImage:(NSDictionary *)dic
{
    id loopImage = [self new];
    //获取所有属性
    NSArray *names = [NSArray getProperties:[self class]];
    //给属性赋值
    for (NSString *name in names) {
        //如果不为空赋值
        if (dic[name]) {
            [loopImage setValue:dic[name] forKey:name];
        }
        
    }
    return loopImage;
}
//发送网络请求获取数据,异步请求,无法返回数据.使用回到函数
+(void)loopImages:(void(^)(NSArray *array))success error:(void(^)(NSError *e))error
{
    
    [[CZNetworkTool sharedTool] GET:@"ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *dic) {
        //获取到字典中的第一键
        NSString *rootKey = dic.keyEnumerator.nextObject;
        //获取主键下得所有的值(数组)
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
