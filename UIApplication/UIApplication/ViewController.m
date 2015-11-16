//
//  ViewController.m
//  UIApplication
//
//  Created by 何建新 on 15/11/13.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
//获取用户系统版本
#define kiOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
    //创建用户通知设置,APP图标上的小红点
    //UIApplication *app = [UIApplication sharedApplication];
    /*
    if (kiOS8) {
        //注册用户通知
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        //申请用户通知权限
        [app registerUserNotificationSettings:setting];
        
    }
    //设置小红点数字
    app.applicationIconBadgeNumber = 8;
     */
    
    
    
    
    
    
    
}
//点击屏幕触发方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIApplication *app = [UIApplication sharedApplication];
    //通过application来设置状态栏的可见性
//    app.statusBarHidden = YES;
//    [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    //设置联网指示器
    //app.networkActivityIndicatorVisible = YES;
    //打开URL
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    [app openURL:url];
    //通过application设置状态栏样式
    app.statusBarStyle = UIStatusBarStyleLightContent;
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//隐藏状态栏
//-(BOOL)prefersStatusBarHidden
//{
//    //return YES;
//}
//状态栏样式
//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    //状态栏文字颜色，枚举
//    return UIStatusBarStyleLightContent;
//}
@end
