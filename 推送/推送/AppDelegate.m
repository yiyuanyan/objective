//
//  AppDelegate.m
//  推送
//
//  Created by 何建新 on 16/1/15.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册通知类型
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeNone | UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    
    //注册远程推送通知
    [[UIApplication sharedApplication]registerForRemoteNotifications];
    
    //取出通知
    //如果程序死了.通过点击横幅接收通知
    if (launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 300)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor redColor];
        label.text = [NSString stringWithFormat:@"%@",launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
        [self.window.rootViewController.view addSubview:label];
        NSLog(@"%@",launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]);
    }
    return YES;
}
//注册完毕远程推送通知[[UIApplication sharedApplication]registerForRemoteNotifications];后会调用
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@",deviceToken);
}
//注册通知失败
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
//接收到远程推送通知之后调用.userInfo是字典
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@",userInfo);
}
//
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
