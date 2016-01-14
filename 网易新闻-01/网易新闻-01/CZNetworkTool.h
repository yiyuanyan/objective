//
//  CZNetworkTool.h
//  网易新闻-01
//
//  Created by 何建新 on 16/1/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CZNetworkTool : AFHTTPSessionManager
+(instancetype)sharedTool;
@end
