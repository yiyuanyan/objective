//
//  ViewController.m
//  线程之间通信
//
//  Created by 何建新 on 15/12/17.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self downloadImageWithUrlString:@"http://img1.imgtn.bdimg.com/it/u=2063967107,1708186646&fm=21&gp=0.jpg"];
    
    NSLog(@"asdfasdf");
}
//异步下载图片方法
-(UIImage *)downloadImageWithUrlString:(NSString *)urlString{
    __block UIImage *image;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.button setBackgroundImage:image forState:UIControlStateNormal];
        });
    });
    
    return image;
}
@end
