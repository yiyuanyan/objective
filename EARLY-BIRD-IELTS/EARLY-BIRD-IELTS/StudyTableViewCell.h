//
//  StudyTableViewCell.h
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/15.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyTableViewCell : UITableViewCell
@property(nonatomic, strong)NSMutableDictionary *dic;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)createCell;
@end
