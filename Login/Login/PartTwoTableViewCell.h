//
//  PartTwoTableViewCell.h
//  Login
//
//  Created by 何建新 on 16/4/8.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickButton)(NSIndexPath *);
@interface PartTwoTableViewCell : UITableViewCell
//@property(nonatomic, strong)NSMutableDictionary *allDic;  //所有数据
////@property(nonatomic, copy)NSMutableArray *part2List;  //part2List数据
////@property(nonatomic, copy)NSMutableArray *part3List;  //part3List数据
////@property(nonatomic, copy)NSIndexPath *indexPath;
////@property(nonatomic, copy)NSString *title;
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic, strong)UIView *enView;
@property(nonatomic, strong)UIView *chView;
@property(nonatomic, strong)clickButton clickButton;
@end
