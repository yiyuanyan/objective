//
//  EditViewController.h
//  AddressBook2
//
//  Created by 何建新 on 16/3/2.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKContactModel, EditViewController;
@protocol EditViewControllerDelegate <NSObject>

@optional
-(void)enditeViewController:(EditViewController *)editVc didSaveContact:(JKContactModel *)model;

@end
@interface EditViewController : UIViewController
@property(nonatomic, assign)id<EditViewControllerDelegate> delegate;
@property(nonatomic, copy) JKContactModel *contactModel;
@end
