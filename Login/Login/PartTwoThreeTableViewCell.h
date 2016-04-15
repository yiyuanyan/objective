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
@property(nonatomic, assign)BOOL hindex;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier contentDic:(NSDictionary *)contentDic indexPath:(NSIndexPath *)inexPath;
@end
