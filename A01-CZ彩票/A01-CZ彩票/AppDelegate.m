//
//  AppDelegate.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "AppDelegate.h"
#import "CZTabBarController.h"
#import "CZNewFeatureController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建window,初始化window对象,屏幕(UIScreen)大小是(bounds)边界大小
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置window为key并显示
    [self.window makeKeyAndVisible];
    //判断当前应用是否是第一次安装运行还是升级运行
    //根据软件的版本号
    //获取当前版本号
    float version = [[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] floatValue];
    //如果升级安装，获取上一次的版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    float oldVersion = [userDefaults floatForKey:@"version"];
    if (version > oldVersion) {
        //如果当前版本号大于之前版本号，显示新特性，并且将当前版本号存储到设置中
        CZNewFeatureController *vc = [[CZNewFeatureController alloc]init];
        self.window.rootViewController = vc;
        [userDefaults setFloat:version forKey:@"version"];
        //进行同步
        [userDefaults synchronize];
        //显示新特性
        
        
    }else{
        //进入APP
        //创建tabBarController 底部自定义导航栏
        CZTabBarController *tabBarController = [CZTabBarController new];
        //设置根控制器为底部自定义导航栏
        self.window.rootViewController = tabBarController;
    }
    
    
    
    
    //设置状态栏，修改info.plist
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [application setStatusBarHidden:NO];
    
    
    
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
