//
//  IWAccountTool.h
//  weibo 16
//
//  Created by 何建新 on 16/1/25.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IWAcount;
@interface IWAccountTool : NSObject
//
+(void)saveAccount:(IWAcount *)account;
//读取账号
+(IWAcount *)account;
@end
