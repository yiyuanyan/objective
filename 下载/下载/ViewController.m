//
//  ViewController.m
//  下载
//
//  Created by 何建新 on 15/12/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getHead];
}

-(void)getHead{
    NSString *strUrl = @"http://10.14.16.11/iOS/Coda.dmg";
    //对地址进行URL加密
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //发送方式，只获取头文件
    request.HTTPMethod = @"head";
    NSURLResponse *response = nil;
    NSError *error;
    //同步发送请求
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"%@",response);
    
}
@end
