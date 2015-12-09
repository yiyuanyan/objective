//
//  CZQuestionContentController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/9.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZQuestionContentController.h"
#import "CZQuestion.h"
@interface CZQuestionContentController ()<UIWebViewDelegate>

@end

@implementation CZQuestionContentController
-(void)loadView
{
    self.view = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = (UIWebView *)self.view;
    NSString *path = [[NSBundle mainBundle] pathForResource:self.question.html ofType:nil];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    NSURL *url = [NSBundle mainBundle].bundleURL;
    webView.delegate = self;
    
    [webView loadHTMLString:html baseURL:url];
    
    self.title = self.question.title;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.location.href='#%@'",self.question.id]];
}

@end
