//
//  ViewController.m
//  NSURLRequest
//
//  Created by 何建新 on 15/12/21.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取JSON,不能设置请求头，不能设置缓存，不能设置超时时长
    //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://10.14.16.11/demo.json"]];
    //使用NSURLRequest,当访问过url后。默认会被缓存
    //设置URL地址
    NSURL *url = [NSURL URLWithString:@"http:10.14.18.45/demo.json"];
    //设置请求
    //NSURLRequest *quest = [NSURLRequest requestWithURL:url];
    //设置请求，cachePolicy:参数是设置缓存方式 timeoutInterval:参数是超时时长
    NSURLRequest *quest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    //NSURLConnection发送异步请求
    [NSURLConnection sendAsynchronousRequest:quest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            //判断返回的服务器的状态吗,将response转换为NSHTTPURLResponse类型，才能使用statusCode来获取状态码
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                //返回正常
                //开始接受数据
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",str);
            }else{
                //返回服务器错误
                NSLog(@"服务器返回错误:%ld",httpResponse.statusCode);
            }
        }else{
            NSLog(@"%@",connectionError);
        }
    }];
}
/* #################################################### */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
