//
//  AppDelegate.m
//  weibo 16
//
//  Created by 何建新 on 16/1/18.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "AppDelegate.h"
#import "IWViewController.h"
#import "IWNewFeatureCtrl.h"
#import "IWOAuthViewCtrl.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建一个window,大小全屏
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    /*
    //获取APP版本号
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    //获取当前APP的版本号
    NSString *currentShortVersionStr = infoDic[kShortVersionStr];
    
    
    
    
    NSString *saveVersionStr = [[NSUserDefaults standardUserDefaults] stringForKey:kShortVersionStr];
    //if (!saveVersionStr || [saveVersionStr isEqual:currentShortVersionStr]) {
    NSComparisonResult result = [saveVersionStr compare:currentShortVersionStr];
    if(!saveVersionStr || result == NSOrderedAscending){
        NSLog(@"第一次使用");
        //保存版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentShortVersionStr forKey:kShortVersionStr];
        //2.设置根控制器
        //IWViewController *tabbar = [[IWViewController alloc]init];
        UIViewController *ctrl = [[IWNewFeatureCtrl alloc]init];
        self.window.rootViewController = ctrl;
    }else{
        IWViewController *tabbar = [[IWViewController alloc]init];
        self.window.rootViewController = tabbar;
    }
    */
    self.window.rootViewController = [[IWOAuthViewCtrl alloc] init];
    
    //成为主window并显示
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
