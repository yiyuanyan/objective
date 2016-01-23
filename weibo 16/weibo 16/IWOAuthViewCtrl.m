//
//  IWOAuthViewCtrl.m
//  weibo 16
//
//  Created by 何建新 on 16/1/22.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWOAuthViewCtrl.h"
#import "AFNetworking.h"
#import "IWAcount.h"
#define Client_id @"4036192405"  //APPKEY
#define Client_secret @"ec7a1f57bd720bebfa5335510afc5796"
#define Redicrect_uri @"http://www.baidu.com/"  //授权回调页面
@interface IWOAuthViewCtrl ()<UIWebViewDelegate>

@end

@implementation IWOAuthViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化WebView
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    //添加到视图
    [self.view addSubview:webView];
    //设置webView要加载的页面
    //请求的地址
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",Client_id,Redicrect_uri];
    NSLog(@"%@",urlStr);
    //1.把urlstr转成NSURL
    NSURL *url = [NSURL URLWithString:urlStr];
    //2.把NSURL转成Request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.webView加载这个Request
    [webView loadRequest:request];
}
//webView的代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    //判断是否是授权回调页
    //判断当前访问的网址是否是以回调页开头
    if ([urlStr hasPrefix:Redicrect_uri]) {
        NSString *suStr = @"code=";
        //获取suStr在urlStr中的范围,截取字符串,一定要判断是否找到、一定要考虑是否有越界
        NSRange range = [urlStr rangeOfString:suStr];
        //找到
        if(range.location != NSNotFound){
            //截取code以后的字符串substringFromIndex:从指定位置开始到结束
            NSString *code = [urlStr substringFromIndex:range.location + range.length];
            //拿到code后，去获取AccessToken
            [self getAccessTokenWithCode:code];
        }
    }
    return YES;
}
//获取授权令牌
-(void)getAccessTokenWithCode:(NSString *)code{
    NSString *urlStr = @"https://api.weibo.com/oauth2/access_token";
    //拼装参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = Client_id;
    params[@"client_secret"] = Client_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = Redicrect_uri;
    //获取请求的管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送POST请求
    /*
     如果返回错误failed: unacceptable content-type: text/plain要在AFN框架的AFURLResponseSerialization.m中
     添加上content-type:的类型
     */
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //返回的是字典。转换为模型
        NSDictionary *dic = responseObject;
        //创建模型文件，添加模型属性
        IWAcount *acount = [[IWAcount alloc] init];
        //将返回的数据赋值给模型类。这样模型内的所有属性都已经有值
        [acount setValuesForKeysWithDictionary:responseObject];
        //保存登陆信息
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error);
    }];
}

@end
