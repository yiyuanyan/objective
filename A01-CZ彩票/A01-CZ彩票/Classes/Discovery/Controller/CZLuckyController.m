//
//  CZLuckyController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/1.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZLuckyController.h"

@interface CZLuckyController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CZLuckyController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img1 = [UIImage imageNamed:@"lucky_entry_light0"];
    UIImage *img2 = [UIImage imageNamed:@"lucky_entry_light1"];
    self.imageView.animationImages = @[img1, img2];
    self.imageView.animationRepeatCount = 0;
    self.imageView.animationDuration = 0.5;
    [self.imageView startAnimating];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backClick{
    //后退到上一个view
    [self.navigationController popViewControllerAnimated:YES];
}

@end
