//
//  IWAccountTool.m
//  weibo 16
//
//  Created by 何建新 on 16/1/25.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWAccountTool.h"
#import "IWAcount.h"

#define AccountArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archiver"]
@implementation IWAccountTool
+(void)saveAccount:(IWAcount *)account
{
    //保存信息到文件
    [NSKeyedArchiver archiveRootObject:account toFile:AccountArchivePath];
}
+(IWAcount *)account{
    //获取用户登陆成功保存的信息
    IWAcount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountArchivePath];
    
    //判断是否过期
    //dateByAddingTimeInterval:加上多少秒，返回值是NSDate
    NSDate *expiresDate = [account.create_at dateByAddingTimeInterval:account.expires_in];
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    //进行时间对比
    NSComparisonResult result = [currentDate compare:expiresDate];
    //NSOrderedAscending是对比规则，枚举
    if (result == NSOrderedAscending) {
        //不过期
        return account;
    }
    //已过期
    return nil;
}
@end
