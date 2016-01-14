//
//  CZDownloader.m
//  下载问题
//
//  Created by 何建新 on 15/12/29.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZDownloader.h"
@interface CZDownloader() <NSURLConnectionDataDelegate>
//用于记录文件的大小
@property(nonatomic,assign) long long contentLength;
//当前下载文件的大小
@property(nonatomic, assign)long long currentLength;
//创建属性，记录文件流
@property(nonatomic, strong)NSOutputStream *strem;
//要保存的文件的路径
@property(nonatomic, copy)NSString *localFilePath;
@end
@implementation CZDownloader
//获取本地文件，判断文件是否存在，如果本地文件存在判断这个文件的大小
-(void)download:(NSString *)strUrl{
    
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    //获取服务器文件的信息
    [self getServerFileInfo:url];
    //获取本地文件信息
    long long fileSize = [self getLocalFileInfo];
    self.currentLength = fileSize;
    if (fileSize == self.contentLength) {
        NSLog(@"文件已经存在");
        return;
    }
    [self download:url offset:fileSize];
}
//从制定位置开始下载
-(void)download:(NSURL *)url offset:(long long)offset{
    //设置从fileSize这个位置开始下载
    //设置请求头
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求头。NSMutableURLRequest的setValue:forHTTPHeaderField:方法可以设置偏移量，让文件下载从偏移量开始继续下载到结束
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-",offset] forHTTPHeaderField:@"range"];
    //使用NSURLConnection的代理方法下载文件，要遵守代理协议
    [NSURLConnection connectionWithRequest:request delegate:self];
}
//获取本地文件的大小
-(long long)getLocalFileInfo{
    //定义文件对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断本地文件是否存在
    long long fileSize = 0; //等于0则不存在
    if ([fileManager fileExistsAtPath:self.localFilePath]) {
        //获取文件大小,attributesOfItemAtPath:是获取文件的所有属性
        NSDictionary *dic = [fileManager attributesOfItemAtPath:self.localFilePath error:NULL];
        fileSize = dic.fileSize;
    }
    //判断本地文件大于服务器文件大小
    if (fileSize > self.contentLength) {
        //删除文件
        [fileManager removeItemAtPath:self.localFilePath error:nil];
        fileSize = 0;
    }
    return fileSize;
}
//获取服务器上文件的大小
-(void)getServerFileInfo:(NSURL *)url{
    //发送head请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"head";
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    //获取稳健的大小
    //记录文件的大小
    //response.expectedContentLength是文件的大小，保存到属性中
    self.contentLength = response.expectedContentLength;
    //获取文件名，获取沙盒目录并拼接本地路径
    NSString *fileName = response.suggestedFilename;
    self.localFilePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
}


//下载代理方法
//下载出错调用此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"下载错误，%@",error);
}
//下载完响应头
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    
    //使用NSOutputStream对文件进行outputStreamToFileAtPath追加写入
    self.strem = [NSOutputStream outputStreamToFileAtPath:self.localFilePath append:YES];
    //打开流
    [self.strem open];
}
//正在下载
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    self.currentLength += data.length;
    //将文件的data.bytes字节写入文件，maxLength:文件长度为data.length
    [self.strem write:data.bytes maxLength:data.length];
    NSLog(@"%f",self.currentLength * 1.0 / self.contentLength);
    
}
//下载完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //下载完毕关闭流
    [self.strem close];
    NSLog(@"文件下载完成");
}
@end
