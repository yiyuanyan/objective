//
//  ViewController.m
//  JSON序列化
//
//  Created by 何建新 on 15/12/25.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "CZVideo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    //创建字典
//    NSDictionary *dic = @{@"name":@"wg",@"time":@"111",@"videoName":@"xxxx.avi"};
//    NSDictionary *dic1 = @{@"name":@"wg2",@"time":@"222",@"videoName":@"xxxx.mka"};
//    NSArray *array = @[dic,dic1];
//    //JSON序列化
//    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
//    [self postJSON:data];
    
    
    //自定义类转换成JSON
    CZVideo *video = [[CZVideo alloc]init];
    video.name = @"wg";
    video.videoName = @"ooo.avi";
    video.length = 100;
    
    //模型转字典
    NSDictionary *dic = [video dictionaryWithValuesForKeys:@[@"name",@"videoName",@"length"]];
    //模型转JSON
    //判断VIDEO对象是否能够转换成JSON格式
    if([NSJSONSerialization isValidJSONObject:dic]){
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
        [self postJSON:data];
    }else{
        NSLog(@"转换JSON失败");
    }
    
}
-(void)postJSON:(NSData *)data{
    NSURL *url = [NSURL URLWithString:@"http://10.14.16.11/iOS/upload/postjson.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                //JSON反序列化
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",str);
            }else{
                NSLog(@"服务器返回失败");
            }
        }else{
            NSLog(@"连接服务器失败");
        }
    }];
}
@end
