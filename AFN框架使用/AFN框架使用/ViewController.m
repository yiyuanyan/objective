//
//  ViewController.m
//  AFN框架使用
//
//  Created by 何建新 on 16/1/8.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self demo7];
}
-(void)demo7{
    //NSString *str = @"http://flash.weather.com.cn/wmaps/xml/china.xml";
    NSString *str = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html";
    //创建对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //给第三方框架添加属性,让框架可以解析text/html返回的json数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //发送GET请求,参数responseObject是返回的内容
    [manager GET:str parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
