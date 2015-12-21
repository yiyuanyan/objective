//
//  ViewController.m
//  九宫格扩展
//
//  Created by 何建新 on 15/12/16.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kMARGIN 5
#define kROWS 5
#define kCOL 3
#define kNUMBERS 15
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //每一个格子的宽高
    CGFloat imageW = (kWIDTH - kMARGIN * (kCOL + 1)) / kCOL;
    CGFloat imageH = (kHEIGHT - kMARGIN *(kROWS + 1)) / kROWS;
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < kNUMBERS; i++) {
        //确定格子所在的行和列
        int col = i % kCOL;
        int row = i / kCOL;
        //确定每一个格子的XY
        
        CGFloat imageX = kMARGIN + (kMARGIN + imageW) * col;
        CGFloat imageY = kMARGIN + (kMARGIN + imageH) * row;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        //imageView.backgroundColor = [UIColor redColor];
        [self.view addSubview:imageView];
        //子线程下载图片，使用串行队列
        dispatch_async(queue, ^{
            NSString *str = [NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%d.jpg",i];
            NSLog(@"%@",str);
            NSURL *url = [NSURL URLWithString:str];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            //在开启异步函数，回到主线程中
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
            
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
