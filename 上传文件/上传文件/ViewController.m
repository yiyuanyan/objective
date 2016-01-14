//
//  ViewController.m
//  上传文件
//
//  Created by 何建新 on 15/12/25.
//  Copyright © 2015年 何建新. All rights reserved.
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
    //服务器上传路径
    NSString *str = @"http://10.14.16.11/iOS/upload/upload.php";
    //要上传的文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aaa.png" ofType:nil];
    //要上传的文件的data
    NSData *data = [NSData dataWithContentsOfFile:path];
    //上传文件
    [self uploadFile:str fileData:data name:@"userfile" fileName:@"aaa.png"];
    
}
#define kBOUNDARY @"HELLO world"  //WebKitFormBoundaryEAmSRrGKmKxz9RU4
//上传文件
-(void)uploadFile:(NSString *)strUrl fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName{
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置POST请求方式
    request.HTTPMethod = @"post";
    //设置请求头
    //格式:Content-Type:multipart/form-data; boundary=----WebKitFormBoundaryEAmSRrGKmKxz9RU4
    NSString *ct = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBOUNDARY];
    [request setValue:ct forHTTPHeaderField:@"Content-Type"];
    //设置请求体
    request.HTTPBody = [self makeBody:fileData name:name fileName:fileName];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSLog(@"%@",json);
            }else{
                NSLog(@"服务器返回失败。状态码:%zd",httpResponse.statusCode);
            }
        }else{
            NSLog(@"连接服务器失败。错误码:%@",connectionError);
        }
    }];
}
//设置body头文件信息
-(NSData *)makeBody:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName{
    //拼接上传文件的请求头信息
//    ------WebKitFormBoundaryEAmSRrGKmKxz9RU4
//    Content-Disposition: form-data; name="userfile"; filename="s_73e2011dabad48e9a69a6c6a499d3ae9.jpg"
//    Content-Type: image/jpeg
//    
//    
//    ------WebKitFormBoundaryEAmSRrGKmKxz9RU4--
    
    NSMutableData *mData = [NSMutableData data];
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendFormat:@"--%@\r\n",kBOUNDARY];
    [mStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",name,fileName];
    //application/octet-stream可是上传任何文件
    [mStr appendString:@"Content-Type: application/octet-stream\r\n"];
    [mStr appendString:@"\r\n"];
    //将拼接的字符串放入mData中
    [mData appendData:[mStr dataUsingEncoding:NSUTF8StringEncoding]];
    //准备要上传的文件
    [mData appendData:fileData];
    //结束头信息拼接
    NSString *end = [NSString stringWithFormat:@"\r\n--%@--\r\n",kBOUNDARY];
    [mData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",mData);
    return mData.copy;
}
@end
