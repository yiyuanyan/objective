//
//  ViewController.m
//  解压缩
//
//  Created by 何建新 on 16/1/6.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self download];
}

-(void)download{
    NSURL *url = [NSURL URLWithString:@"111.202.112.82/coda.zip"];
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       /*要解压缩首先要导入框架SSZipArchive,并且在项目中得Linked Frameworks and Libraries选项中添加libz.tbd*/
        
        //将location.path文件解压到toDestination:路径中
        NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        BOOL zip = [SSZipArchive unzipFileAtPath:location.path toDestination:dir];
        NSLog(@"解压缩成功。%d。文件在:%@",zip,dir);
    }] resume];
}

@end
