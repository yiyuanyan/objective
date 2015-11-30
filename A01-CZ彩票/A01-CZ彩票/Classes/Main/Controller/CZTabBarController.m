//
//  CZTabBarController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZTabBarController.h"
#import "UIImage+Ex.h"
#import "CZTabBar.h"
@interface CZTabBarController ()<CZTabBarDelegate>

@end

@implementation CZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建自定义tabBar
//    CZTabBar *tabBar = [[CZTabBar alloc]init];
//    //设置CZTabBar的代理
//    tabBar.delegate = self;
//    [self.view addSubview:tabBar];
//    //设置tabBar的大小
//    tabBar.frame = self.tabBar.frame;
//    //移除掉系统的tabBar
//    [self.tabBar removeFromSuperview];
    CZTabBar* tabBar = [[CZTabBar alloc]init];
    
    tabBar.delegate = self;
    tabBar.frame = self.tabBar.bounds;
    //添加子控制器
    [self addChildControllers:tabBar];
    //把自定义tabBar添加到系统的tabBar上,最后添加可以防止系统自动生成的tabBarItem覆盖在自定义tabBarItem上！
    [self.tabBar addSubview:tabBar];
    
    
    
    //设置导航条的样式,可以获取所有导航条
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
//实现tabBar代理方法
-(void)tabBar:(CZTabBar *)tabBar didClickedButton:(NSInteger)index
{
    //设置选中的控制器是哪个
    self.selectedIndex = index;
}
//创建自控制器，并加入tabBarController中
-(void)addChildControllers:(CZTabBar *)customTabBar{
    NSArray *sbNames = @[@"LotteryHall",@"Arena",@"Discovery",@"History",@"MyLottery"];
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSString *sbName in sbNames) {
        //获取sb
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
        //加载sb中箭头所指向的控制器
        UINavigationController *navController = [sb instantiateInitialViewController];
        //将子控制器加入加入可变数组
        [controllers addObject:navController];
        //设置每一个控制器的tabBar的图片
        [customTabBar addTabBarItem:sbName];
        
//        //系统会自动对tabBarItem的图片添加一个模板。要取消掉，调用imageWithRenderingMode:方法
//        navController.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%@_new",sbName]] originalImage];
//        navController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%@_selected_new",sbName]] originalImage];
    }
    //将所有控制器加入tabBarController中，数组形式
    self.viewControllers = controllers;
}

@end
