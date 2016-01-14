//
//  CZChannel.m
//  网易新闻-01
//
//  Created by 何建新 on 16/1/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZChannel.h"
#import "NSArray+Ex.h"
@implementation CZChannel
//返回请求新闻的地址
-(NSString *)urlStr
{
    NSString *str = [NSString stringWithFormat:@"article/headline/%@/0-140.html",self.tid];
    return str;
}
+(instancetype)channelWithDic:(NSDictionary *)dic
{
    id channel = [self new];
    NSArray *names = [NSArray getProperties:[self class]];
    for (NSString *name in names) {
        if(dic[name]){
            [channel setValue:dic[name] forKey:name];
        }
    }
    return channel;
}

+(NSArray *)channels
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *array = dic[@"tList"];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *modelDic in array) {
        CZChannel *channel = [self channelWithDic:modelDic];
        [mArray addObject:channel];
    }
    
    return [mArray sortedArrayUsingComparator:^NSComparisonResult(CZChannel *obj1, CZChannel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
}
@end
