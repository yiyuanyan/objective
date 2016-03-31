//
//  PartTwoContentTableViewCell.h
//  Login
//
//  Created by 何建新 on 16/3/31.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartTwoContentTableViewCell : UITableViewCell
@property(nonatomic, copy)NSMutableDictionary *part2Dic;
@property(nonatomic, copy)NSMutableDictionary *part3Dic;

@property(nonatomic, strong)NSString *playUrl;
@property(nonatomic, strong)NSString *luyinUrl;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)enLabel:(NSString *)enString;
@end
