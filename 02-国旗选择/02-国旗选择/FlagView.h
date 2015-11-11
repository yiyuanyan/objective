//
//  FlagView.h
//  02-国旗选择
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flag.h"
@interface FlagView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;


@property(nonatomic, strong)Flag *flag;
+(instancetype)flagView;
@end
