//
//  IWViewController.m
//  weibo 16
//
//  Created by 何建新 on 16/1/19.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWViewController.h"
#import "IWTabBar.h"
#import "IWHomeViewCtrl.h"

@interface IWViewController ()<IWTabBarDelegate>

@end

@implementation IWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IWTabBar *tabbar = [[IWTabBar alloc]init];
    tabbar.delegate = self;
    // Do any additional setup after loading the view.
    
    IWHomeViewCtrl *homeCtrl = [[IWHomeViewCtrl alloc]init];
    [self addChildViewCtrl:homeCtrl imageName:@"tabbar_home" title:@"首页"];
    
    UITableViewController *messageCtrl = [[UITableViewController alloc]init];
    [self addChildViewCtrl:messageCtrl imageName:@"tabbar_message_center" title:@"消息"];
    
    UITableViewController *discoverCtrl = [[UITableViewController alloc]init];
    [self addChildViewCtrl:discoverCtrl imageName:@"tabbar_discover" title:@"发现"];
    
    UITableViewController *profileCtrl = [[UITableViewController alloc]init];
    [self addChildViewCtrl:profileCtrl imageName:@"tabbar_profile" title:@"我"];
    
    //self.tabBar是系统属性，可以使用KVC形式修改
    [self setValue:tabbar forKey:@"tabBar"];
    //self.tabBar = tabbar;
}
-(void)addChildViewCtrl:(UIViewController *)ctrl imageName:(NSString *)imageName title:(NSString *)title{
    //tabBarItem的文字
//    ctrl.navigationController.title = title;
//    ctrl.tabBarItem.title = title;
    //与上两句功能同效果
    ctrl.title = title;
    //tabBarItem的文字颜色
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //文字属性字典
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //文字属性字典添加到设置文字属性中
    [ctrl.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    //tabBarItem的图片
    ctrl.tabBarItem.image = [UIImage imageNamed:imageName];
    //tabBarItem的选中的图片
    ctrl.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:ctrl];
    [self addChildViewController:navCtrl];
}
-(void)tabBar:(IWTabBar *)tabbar plusBtnDidClicked:(UIButton *)btn
{
    NSLog(@"%s",__func__);
}


@end
