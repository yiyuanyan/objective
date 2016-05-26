//
//  SchoolListTableViewCell.h
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolListTableViewCell : UITableViewCell
//传递过来的cell要显示的内容的字典
@property(nonatomic, strong) NSMutableDictionary *infoDic;
@property(nonatomic, strong)NSArray *infoArray;
@end
