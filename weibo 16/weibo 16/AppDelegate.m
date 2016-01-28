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
#import "IWAcount.h"
#import "UIWindow+Extension.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        //初始化一个通知的设置，里面制定了需要BadeType的权限
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        //注册这个设置，在启动的时候回提示用户是否允许弹出BadgeNumber
        [application registerUserNotificationSettings:setting];
    }
    
    //1.创建 window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.选把根控制器
    [self switchRootViewCtrl];
    
    //3.成为主window并显示
    [self.window makeKeyAndVisible];
    
    return YES;

}
- (void)switchRootViewCtrl{
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    //    当前app的版本号的字符串
    NSString *currentShortVersionStr = infoDic[kShortVersionStr];
    
    //2.设置根控制器
    
    
    //如果用户第一次使用：先显示新特性页-->显示登录页-->主页
    //如果不是第一次使用：先判断是否登录(是否登录过期)-->主页
    
    //从沙盒里面读取保存的版本号
    NSString *saveVersionStr = [[NSUserDefaults standardUserDefaults] stringForKey:kShortVersionStr];
    //当前的版本号与沙盒保存的版本号进行对比
    NSComparisonResult result = [saveVersionStr compare:currentShortVersionStr];
    //如果对比到本地保存的版本号比当前的版本号老，就加载新特性
    if (!saveVersionStr || result == NSOrderedAscending) {
        [[NSUserDefaults standardUserDefaults] setObject:currentShortVersionStr forKey:kShortVersionStr];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIViewController *ctrl = [IWNewFeatureCtrl new];
        self.window.rootViewController = ctrl;
    }else{
        //是否有过登录
        //去获取 Doc路径
        
        [self.window switchRootViewCtrl];
        
        //        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //        //拼接文件名路径
        //        filePath = [filePath stringByAppendingPathComponent:@"account.archiver"];
        //
        //        //解档用户登录成功保存的信息
        //        IWAcount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        //        if (!account) {
        //            //跳到登录页面去
        //            self.window.rootViewController = [IWOAuthViewCtrl new];
        //        }else{
        //            IWTabBarController *tabbar = [[IWTabBarController alloc] init];
        //            self.window.rootViewController = tabbar;
        //        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //app进入后台的挂起状态
    //可以让app短期在后台运行，执行代码
    __block UIBackgroundTaskIdentifier identifier = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:identifier];
    }];
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
