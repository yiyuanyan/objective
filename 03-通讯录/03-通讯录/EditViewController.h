//
//  EditViewController.h
//  03-通讯录
//
//  Created by 何建新 on 15/11/19.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
//制定代理协议
@class EditViewController;
@protocol EditViewControllerDelegate <NSObject>

-(void)editViewController:(EditViewController *)viewController withContact:(Contact *)contact;

@end
@interface EditViewController : UIViewController
@property(nonatomic, strong)Contact *con;
//代理协议属性
@property(nonatomic, weak)id<EditViewControllerDelegate>editViewControllerDelegate;
@end
