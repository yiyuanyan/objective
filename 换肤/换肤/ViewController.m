//
//  ViewController.m
//  换肤
//
//  Created by 何建新 on 16/1/15.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *face;
@property (weak, nonatomic) IBOutlet UIImageView *heart;
@property (weak, nonatomic) IBOutlet UIImageView *rect;

@end

@implementation ViewController
//点击更换皮肤
- (IBAction)skinsClick:(UISegmentedControl *)sender {
    //点击的是哪个按钮
    //获取按钮索引
    int s = sender.selectedSegmentIndex;
    //通过索引获取按钮title
    NSString *senderName = [sender titleForSegmentAtIndex:s];
    //之前选中的样式保存再来
    //保存在偏好中
    [[NSUserDefaults standardUserDefaults]setObject:senderName forKey:@"skin"];
    //立即保存到偏好中
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self setSking];
}
-(void)setSking
{
    NSString *skin = [[NSUserDefaults standardUserDefaults]objectForKey:@"skin"];
    if (skin == nil) {
        skin = @"blue";
    }
    //NSString *path = [NSString stringWithFormat:@"skin/%@/face",skin];
    self.face.image = [UIImage imageNamed:[NSString stringWithFormat:@"skin/%@/face",skin]];
    self.heart.image = [UIImage imageNamed:[NSString stringWithFormat:@"skin/%@/heart",skin]];
    self.rect.image = [UIImage imageNamed:[NSString stringWithFormat:@"skin/%@/rect",skin]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSking];
}


@end
