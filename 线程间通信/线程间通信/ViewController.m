//
//  ViewController.m
//  线程间通信
//
//  Created by 何建新 on 15/12/11.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1\下载图片
    [self performSelectorInBackground:@selector(downloadImage) withObject:nil];
    
    //2显示图片
}
-(void)downloadImage
{
    NSString *str = @"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo_top_ca79a146.png";
    NSURL *url = [NSURL URLWithString:str];
    //下载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    //将二进制文件转换成图片
    UIImage *img = [UIImage imageWithData:data];
    
    [self performSelectorOnMainThread:@selector(setupUIImage:) withObject:img waitUntilDone:NO];
    
    
}
-(void)setupUIImage:(UIImage *)image
{
    self.imageView.image = image;
}
@end
