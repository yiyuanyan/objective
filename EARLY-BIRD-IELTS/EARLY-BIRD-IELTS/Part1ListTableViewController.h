//
//  Part1ListTableViewController.h
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Part1ListTableViewController : UITableViewController
@property(nonatomic, strong)NSString *cateId;  //父ID
@property(nonatomic, strong)NSString *newflg;  //标题标新
@property(nonatomic, copy)NSString *navTitle;  //导航栏标题
@end
