//
//  ViewController.m
//  下载带进度
//
//  Created by 何建新 on 16/1/5.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
//定义一个NSURLSession属性
@property(nonatomic, strong)NSURLSession *session;

@property(nonatomic, strong)NSURLSessionDownloadTask *downloadTask;
//定义NSData属性，用于存储当前下载的数据
@property(nonatomic, strong)NSData *data;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end

@implementation ViewController
-(NSURLSession *)session{
    if (_session == nil) {
        //设置代理方法运行的队列
        NSOperationQueue *queue = [NSOperationQueue mainQueue];
        //设置最大并发线程
        queue.maxConcurrentOperationCount = 1;
        //配置NSURLSession的请求信息
        NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
        //创建自定义session并设置代理
        
        _session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:queue];
    }
    return _session;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)download{
    NSString *strUrl = @"http://111.202.112.82/coda.dmg";
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    //使用代理协议方式必须使用这种方法
    //将downloadTaskWithURL:存入属性中
    self.downloadTask = [self.session downloadTaskWithURL:url];
    //开始执行任务
    [self.downloadTask resume];
    NSLog(@"开始");
}
//下载完成后
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"下载完成");
}
//断点续传
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{

}
//下载进度,参数bytesWritten:本次下载了多少。totalBytesWritten:总共下载了多少。totalBytesExpectedToRrite:文件的大小
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //显示进度,本次下载的文件大小/总共文件大小
    float process = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
    self.progress.progress = process;
}
//开始按钮
- (IBAction)start:(id)sender {
    [self download];
}
//暂停
- (IBAction)pause:(id)sender {

    //取消下载,并将当前下载的数据存起来
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        //将当前下载的数据存入属性中
        self.data = resumeData;
    }];
    //如果点击多次暂停，会无法继续，点击多次暂停resumeData会为空
    self.downloadTask = nil;
}
//继续
- (IBAction)resume:(id)sender {
    //如果self.data为空，则根本就不能继续下载
    if (self.data == nil) {
        return;
    }
    //通过代理来实现下载的不要调用带有回调函数的方法
    [[self.session downloadTaskWithResumeData:self.data] resume];
    
    self.data = nil;
}


@end
