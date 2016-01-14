//
//  CZNetworkTool.h
//  网易新闻
//
//  Created by 何建新 on 16/1/8.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CZNetworkTool : AFHTTPSessionManager
//创建单利对象
+(instancetype)sharedTool;
@end
