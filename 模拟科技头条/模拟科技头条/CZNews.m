//
//  CZNews.m
//  模拟科技头条
//
//  Created by 何建新 on 15/12/22.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZNews.h"

@implementation CZNews
+(instancetype)newsWithDic:(NSDictionary *)dic
{
    CZNews *news = [[CZNews alloc]init];
    for (NSString *name in [self getProperties]) {
        [news setValue:dic[name] forKey:name];
    }
    
    
    return news;
}
+(NSArray *)getProperties
{
    return @[@"title",@"summary",@"img",@"sitename",@"addtime"];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@,%p>{title:%@,addtime:%@}",[self class],self,self.title,self.addtime];
}


//1、发送请求获取JSON形式的字符串
+(void)newsWithUrl:(NSString *)strUrl completion:(void(^)(NSArray *array))completion{
    
    //JSON的地址
    NSURL *url = [NSURL URLWithString:strUrl];
    //设置请求头
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    //发送异步请求，并主线程执行
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                //将返回的data转换成对象
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
                //字典转模型
                NSMutableArray *mArray = [[NSMutableArray alloc]init];
                for (NSDictionary *dic in array) {
                    CZNews *news = [CZNews newsWithDic:dic];
                    [mArray addObject:news];
                }
                //拿到数据执行block
                if (completion) {
                    completion(mArray.copy);
                }
                
            }else{
                NSLog(@"服务器有问题");
            }
        }else{
            NSLog(@"请求服务器失败");
        }
    }];
    
}
//重写time的getter方法
-(NSString *)time
{
    //判断addtime和当前的时间差，如果小余60分钟返回n分钟之前
    //如果超过60分钟小余24小时返回n小时之前，
    //如果超过24小时之前返回月-日
    
    
    //把json中的数字转换成日期对象
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.addtime intValue]];
    //计算date和当前的时间差
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取两个时间相差的分钟
    NSDateComponents *component = [calendar components:NSCalendarUnitMinute fromDate:date toDate:[NSDate date] options:NSCalendarWrapComponents];
    if (component.minute < 60) {
        return [NSString stringWithFormat:@"%zd分钟前",component.minute];
    }
    //获取两个事件相差的小时
    component = [calendar components:NSCalendarUnitHour fromDate:date toDate:[NSDate date] options:NSCalendarWrapComponents];
    if (component.hour < 24) {
        return [NSString stringWithFormat:@"%zd小时前",component.hour];
    }
    NSDateFormatter *ndf = [[NSDateFormatter alloc]init];
    ndf.dateFormat = @"MM-dd";
    return [ndf stringFromDate:date];
}
@end
