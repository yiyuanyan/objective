//
//  FlagView.h
//  国旗练习
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flags.h"
@interface FlagView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
//定义Flags，用于重写方法
@property(nonatomic, strong)Flags *flags;
@end
