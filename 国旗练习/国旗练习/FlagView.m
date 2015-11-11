//
//  FlagView.m
//  国旗练习
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "FlagView.h"

@implementation FlagView
-(void)setFlags:(Flags *)flags
{
    _flags = flags;
    self.nameView.text = flags.name;
    self.iconView.image = [UIImage imageNamed:flags.icon];
    
}


@end
