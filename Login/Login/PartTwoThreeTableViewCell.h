//
//  PartTwoThreeTableViewCell.h
//  Login
//
//  Created by 何建新 on 16/4/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMContent;
typedef void(^clickButton)(NSIndexPath *); //播放按钮block
typedef void (^luyinButton)(NSString *);  //录音按钮block
typedef void (^luyinAnimation)(UIView *, NSIndexPath *);  //录音动画block
typedef void (^luyinPlayBtn)(NSString *, NSIndexPath *);  //录音播放按钮block
@interface PartTwoThreeTableViewCell : UITableViewCell
@property(nonatomic, strong)NSIndexPath *index;
@property(nonatomic, strong)clickButton clickButton;
@property(nonatomic, strong)luyinButton luyinButton;
@property(nonatomic, strong)luyinAnimation luyinAnimation;
@property(nonatomic, strong)luyinPlayBtn luyinPlayBtn;
@property(nonatomic, strong)NSString *luyinFilePath;
@property(nonatomic, strong)NSIndexPath *luyinIndexPath;
@property(nonatomic, strong)NSIndexPath *luyinAnimationIndexPath;
@property(nonatomic, strong)NSString *cellId;
//创建title的cell
-(void)createTitleCell:(NSString *)titleString TM:(TMContent *)TM indexPath:(NSIndexPath *)indexPath;
-(void)createPart2ListCell:(TMContent *)TM indexPath:(NSIndexPath*)indexPath;
@end
