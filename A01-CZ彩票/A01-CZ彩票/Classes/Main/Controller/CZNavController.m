//
//  CZNavController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/1.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZNavController.h"
#import "UIImage+Ex.h"
@interface CZNavController ()

@end

@implementation CZNavController
+(void)initialize
{
    //设置导航条的样式,可以获取所有导航条
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}

//重写导航控制器的push方法，每一个子控制器在跳转的时候都会调用此方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //viewController就是子控制器
    //自定义后退按钮
    //设置返回按钮,调用UIImage+Ex.h扩展类
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"NavBack"] originalImage] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    //创建一个UIBarButtonImte。样式为弹簧样式fixedSpace.将其宽度设置为-10.让后用数组方式添加到navigationItem.leftBarButtonItems中。这样返回按钮就会往左移动10个像素
    UIBarButtonItem* fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedItem.width = -10;
    
    viewController.navigationItem.leftBarButtonItems = @[fixedItem, backItem];
    
    //自定义后退后，收拾返回上一级控制器的功能
    self.interactivePopGestureRecognizer.delegate = nil;
    //当push的时候隐藏tabBar
    viewController.hidesBottomBarWhenPushed = YES;
    
    
    //调用父类的push方法，做到真正的跳转
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backClick{
    //后退到上一个view
    [self popViewControllerAnimated:YES];
}


@end
