//
//  ViewController.h
//  键盘处理-练习
//
//  Created by 何建新 on 15/11/12.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZToolBar.h"
@interface ViewController : UIViewController
//日期输入框
@property (weak, nonatomic) IBOutlet UITextField *time;
//城市输入框
@property (weak, nonatomic) IBOutlet UITextField *city;
//定义数组用于存放两个输入框
@property(nonatomic, strong)NSArray *textFields;

//定义存放输入框下标的全局变量
@property(nonatomic, assign)NSInteger textFieldIndex;

//
@property(nonatomic, strong)CZToolBar *toolBar;
@end

