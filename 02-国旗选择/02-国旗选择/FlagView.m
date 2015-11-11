//
//  FlagView.m
//  02-国旗选择
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "FlagView.h"

@implementation FlagView

-(void)setFlag:(Flag *)flag
{
    _flag = flag;
    self.nameView.text = flag.name;
    self.iconView.image = [UIImage imageNamed:flag.icon];
}
+(instancetype)flagView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"FlagView" owner:nil options:nil]lastObject];
}
@end
