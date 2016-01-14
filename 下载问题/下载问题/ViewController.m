//
//  ViewController.m
//  下载问题
//
//  Created by 何建新 on 15/12/29.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "CZDownloader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CZDownloader *downloader = [[CZDownloader alloc]init];
    [downloader download:@"http://10.14.16.11/iOS/Coda.dmg"];
}

@end
