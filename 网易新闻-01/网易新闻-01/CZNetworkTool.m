//
//  CZNetworkTool.m
//  网易新闻-01
//
//  Created by 何建新 on 16/1/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZNetworkTool.h"

@implementation CZNetworkTool
+(instancetype)sharedTool{
    static id instance = nil;
    static dispatch_once_t onceToken;
    NSURL *baseUrl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
    //全局配置
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    conf.timeoutIntervalForRequest = 30;
    dispatch_once(&onceToken, ^{
        instance = [[CZNetworkTool alloc] initWithBaseURL:baseUrl sessionConfiguration:conf];
    });
    return instance;
}
@end
