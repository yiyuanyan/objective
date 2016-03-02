//
//  AddViewController.h
//  AddressBook
//
//  Created by 何建新 on 16/3/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddViewController, JKContactModel;
@protocol AddViewControllerDelegate <NSObject>

@optional
-(void)addContact:(AddViewController *)addVc didAddContact:(JKContactModel *)contact;

@end
@interface AddViewController : UIViewController
@property(nonatomic, assign)id<AddViewControllerDelegate> delegate;
@end
