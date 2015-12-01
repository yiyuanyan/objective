//
//  CZTabBarController.m
//  彩票test
//
//  Created by 何建新 on 15/11/30.
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
    
    //创建tabBar
    CZTabBar *tabBar = [[CZTabBar alloc] init];
    //设置tabBar的代理为self
    tabBar.delegate = self;
    //设置tabBar的frame为自身的tabBar的边界（两个tabBar并不是一个）
    tabBar.frame = self.tabBar.bounds;
    //调用自身的自定义方法将tabBar加入到子控制器中
    [self addChildControllers:tabBar];
    
    //将tabBar加入到自身的tabBar中
    [self.tabBar addSubview:tabBar];
    
    //设置导航条的样式
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    //将nav的文字设置成白色
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
        
    }
    //将所有控制器加入tabBarController中，数组形式
    self.viewControllers = controllers;
}
//代理方法
-(void)tabBar:(CZTabBar *)tabBar didClickedButton:(NSInteger)index
{
    self.selectedIndex = index;
}
@end
