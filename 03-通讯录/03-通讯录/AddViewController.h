//
//  AddViewController.h
//  03-通讯录
//
//  Created by 何建新 on 15/11/18.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddViewController;
@protocol AddViewControllerDelegate <NSObject>

-(void)addViewController:(AddViewController *)viewController withName:(NSString *)name andNumber:(NSString *)number;

@end
@interface AddViewController : UIViewController
@property(nonatomic, weak)id<AddViewControllerDelegate> addViewControllerDelegate;
@end
