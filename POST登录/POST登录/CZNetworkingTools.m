//
//  CZNetworkingTools.m
//  POST登录
//
//  Created by 何建新 on 15/12/24.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZNetworkingTools.h"

@implementation CZNetworkingTools
-(void)login:(NSString *)postUrl
{
    NSURL *url = [NSURL URLWithString:postUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    //设置请求方式为POST
    request.HTTPMethod = @"POST";
    //拼接POST参数
    NSString *pram = [NSString stringWithFormat:@"username=%@&password=%@",self.userName,self.userPwd];
    //设置POST字符集
    request.HTTPBody = [pram dataUsingEncoding:NSUTF8StringEncoding];
    //发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (json[@"userId"] > 0) {
                    NSLog(@"登录成功");
                    [self saveUserInfo];
                }
            }else{
                NSLog(@"服务器返回失败");
            }
        }else{
            NSLog(@"服务器连接失败");
        }
    }];
    
}
-(void)saveUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.userNameField.text forKey:@"name"];
    //[userDefaults setObject:self.userPwdField.text forKey:@"pwd"];
    //把密码保存到钥匙串
    [SSKeychain setPassword:self.userPwdField.text forService:[NSBundle mainBundle].bundleIdentifier account:self.userNameField.text];
    [userDefaults synchronize];
}
-(void)reloadUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userNameField.text = [userDefaults objectForKey:@"name"];
    //从钥匙串中加载密码
    self.userPwdField.text = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:self.userNameField.text];
    
}
@end
