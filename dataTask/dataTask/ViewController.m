//
//  ViewController.m
//  dataTask
//
//  Created by 何建新 on 16/1/4.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self downloadTask];
}
//downloadTask下载文件
-(void)downloadTask{
    NSString *strUrl = @"http://111.202.112.82/coda.dmg";
    
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    //后面必须调用resume开启任务,location:下载后会存放到临时文件夹，系统会自动删除这个临时文件
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                
                //获取cache沙盒路径
                NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                //拼接文件绝对路径
                path = [path stringByAppendingPathComponent:@"coda.dmg"];
                //创建文件管理对象
                NSFileManager *manager = [NSFileManager defaultManager];
                //拷贝location.path文件到path目录下
                NSError *error;
                BOOL b = [manager copyItemAtPath:location.path toPath:path error:&error];
                
                
                
            }else{
                NSLog(@"服务器返回失败，错误代码:%ld",httpResponse.statusCode);
            }
        }else{
            NSLog(@"连接服务器错误，错误代码:%@",error);
        }
    }] resume];
    
}







-(void)dataTask2{
    NSString *strUrl = @"http://111.202.112.82/demo.json";
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:strUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }] resume];
}

//发送get请求,获取JSON
-(void)dataTask1{
    NSString *strUrl = @"http://111.202.112.82/demo.json";
    NSURLSession *session = [NSURLSession sharedSession];
    //发起一个任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:strUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",json);
            }else{
                NSLog(@"服务器内部错误");
            }
        }else{
            NSLog(@"连接服务器失败,错误代码:%@",error);
        }
    }];
    //让任务开始执行
    [dataTask resume];
}



@end
