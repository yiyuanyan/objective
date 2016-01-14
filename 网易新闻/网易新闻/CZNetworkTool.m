//
//  CZNetworkTool.m
//  网易新闻
//
//  Created by 何建新 on 16/1/8.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZNetworkTool.h"

@implementation CZNetworkTool
+(instancetype)sharedTool
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //全局配置
        NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
        //设置超时
        conf.timeoutIntervalForRequest = 30;
        NSURL *baseurl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[CZNetworkTool alloc] initWithBaseURL:baseurl sessionConfiguration:conf];
    });
    
    return instance;
}
@end
