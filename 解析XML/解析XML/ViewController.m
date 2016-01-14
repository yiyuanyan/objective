//
//  ViewController.m
//  解析XML
//
//  Created by 何建新 on 15/12/23.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"
@interface ViewController () <NSXMLParserDelegate>
@property(nonatomic, strong)NSMutableArray *videos;
//当前够早的对象
@property(nonatomic, strong)Video *currentVideo;

//当前拼接属性的字符串
@property(nonatomic, copy)NSMutableString *mStr;
@end

@implementation ViewController
-(NSMutableArray *)videos
{
    if (_videos == nil) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}
-(NSMutableString *)mStr
{
    if (_mStr == nil) {
        _mStr = [NSMutableString string];
    }
    return _mStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建URL
    NSURL *url = [NSURL URLWithString:@"http://10.14.16.11/1.xml"];
    //设置请求头
    NSURLRequest *quest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    //异步请求
    [NSURLConnection sendAsynchronousRequest:quest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                //XML的解析器
                NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
                //设置XML解析器的代理
                parser.delegate = self;
                //开始解析，当调用了parse方法后才会执行代理方法
                [parser parse];
            }else{
                NSLog(@"服务器错误");
            }
        }else{
            NSLog(@"连接服务器失败，错误代码:%@",connectionError);
        }
    }];
}
//NSXMLParser代理方法
//开始解析XML文件方法
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"1第一步");
    //开始解析时先清除之前的数据
    [self.videos removeAllObjects];
}
//找到开始标签
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"2开始解析标签%@----%@",elementName,attributeDict);
    if ([elementName isEqualToString:@"quantity"]) {
        self.currentVideo = [[Video alloc]init];
        self.currentVideo.quantity = attributeDict[@"quantity"];
        [self.videos addObject:self.currentVideo];
    }
}
//找到标签之间的内容
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"3标签之间的内容%@",string);
    [self.mStr appendString:string];
}
//结束标签
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"4结束标签%@",elementName);
    //给对象的属性赋值
    if ([elementName isEqualToString:@"itemdescription"]) {
        self.currentVideo.itemdescription = self.mStr;
    }else if ([elementName isEqualToString:@"quantity"]){
        self.currentVideo.quantity = self.mStr;
    }
    
}

//结束解析XML方法
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"5解析结束");
    NSLog(@"%@",self.videos);
}
//如果解析出错
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"6XML解析出错了");
}
@end
