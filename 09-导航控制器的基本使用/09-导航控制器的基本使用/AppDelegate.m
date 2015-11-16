//
//  AppDelegate.m
//  09-导航控制器的基本使用
//
//  Created by 何建新 on 15/11/16.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CZViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建一个window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //将子视图加入导航控制器中
    ViewController *vc = [[ViewController alloc]init];
    CZViewController *vc1 = [[CZViewController alloc] init];
    //创建一个导航控制器
    //使用initWithRootViewController:子视图，相当于push了一个视图
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    //添加视图，nav自动加入back按钮。栈模式，先进先出
    //[nav pushViewController:vc animated:YES];
    //[nav pushViewController:vc1 animated:YES];
    //制定导航控制器为根控制器
    self.window.rootViewController = nav;
    
    //显示window视图
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
