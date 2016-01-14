//
//  ViewController.m
//  socket
//
//  Created by 何建新 on 15/12/22.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1、创建socket
    //第一个参数：aomain 协议域 AF_INET ip地址端口
    //第二个参数：type 指定socket的类型 SOCK_STREAM流式socket 传输层tcp协议 数据报式，传输层 udp协议
    //第三个参数： socket使用的协议 0为自动匹配第二个参数所使用的协议
    //返回的是socket的描述符 int类型
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    //2、连接到服务器，使用connect()方法
    //第一个参数：socket返回的描述符
    //第二个参数：服务器IP地址和端口号 结构体
    //第三个参数：第二个参数的长度
    //返回：成功返回0，失败返回非0
    struct sockaddr_in serverAdd;
    serverAdd.sin_family = AF_INET; //指定IP地址类型
    serverAdd.sin_port = htons(80);
    serverAdd.sin_addr.s_addr = inet_addr("10.14.16.11");
    int result = connect(clientSocket, (const struct sockaddr *)&serverAdd, sizeof(serverAdd));
    if (result == 0) {
        NSLog(@"连接成功");
    }else{
        NSLog(@"连接失败");
    }
    //向服务器发送信息
    const char *msg = "hello world";
    ssize_t sendLen = send(clientSocket, msg, strlen(msg), 0);
    //接收
    char buffer[1024];
    ssize_t recvLen = recv(clientSocket, buffer, sizeof(buffer), 0);
    NSString *str = [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    //关闭
    close(clientSocket);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
