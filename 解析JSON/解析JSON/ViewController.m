//
//  ViewController.m
//  解析JSON
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
    //URL地址
    NSURL *url = [NSURL URLWithString:@"http://10.14.18.45/demo.json"];
    //设置请求，不缓存，超时时长30秒
    NSURLRequest *quest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    //异步请求,主线程执行
    [NSURLConnection sendAsynchronousRequest:quest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //判断是否请求错误
        if (!connectionError) {
            //将response转换成NSHTTPURLResponse类型
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            //判断返回来的服务器状态码
            if (httpResponse.statusCode == 200) {
                //解析JSON，把JSON形式的字符串解析成对象
                NSError *error = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                //判断解析JSON是否出错
                if (!error) {
                    NSLog(@"%@",json);
                }else{
                    NSLog(@"%@",error);
                }
            }else{
                NSLog(@"服务器返回错误");
            }
        }else{
            NSLog(@"请求连接失败");
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
