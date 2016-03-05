//
//  alertMessageViewController.h
//  Login
//
//  Created by 何建新 on 16/3/4.
//  Copyright © 2016年 何建新. All rights reserved.
//  弹出信息提示

#import <UIKit/UIKit.h>

@interface alertMessageViewController : UIViewController
+(UIAlertController *)alertMessage:(NSString *)title message:(NSString *)message;

@end
