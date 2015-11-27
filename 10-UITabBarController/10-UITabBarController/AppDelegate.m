//
//  AppDelegate.m
//  10-UITabBarController
//
//  Created by 何建新 on 15/11/23.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建一个window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //创建一个tabBarvc
    UITabBarController *tab = [[UITabBarController alloc]init];
    //创建子控制器,并加入tab中
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor redColor];
    //设置按钮标题
    vc1.tabBarItem.title = @"微信";
    //设置按钮图片
    vc1.tabBarItem.image = [UIImage imageNamed:@"tab_recent_nor"];
    //设置按钮上的提醒数字
    vc1.tabBarItem.badgeValue = @"九";
    
    //[tab addChildViewController:vc1];
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor brownColor];
    vc2.tabBarItem.title = @"联系人";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tab_buddy_nor"];
    
    
    
    //[tab addChildViewController:vc2];
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor whiteColor];
    vc3.tabBarItem.image = [UIImage imageNamed:@"tab_me_nor"];
    vc3.tabBarItem.title = @"设置";
    vc3.tabBarItem.badgeValue = @"3";
    //[tab addChildViewController:vc3];
    //数组形式添加子控制器，添加的第一个控制器将为最先显示出来
    tab.viewControllers = @[vc1,vc2,vc3];
    
    
    
    
    //指定tab为根控制器
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
