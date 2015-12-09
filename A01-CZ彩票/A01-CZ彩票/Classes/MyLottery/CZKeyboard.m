//
//  CZKeyboard.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZKeyboard.h"

@implementation CZKeyboard
- (IBAction)cancel:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(keyboardDidClickedCancel:)]){
        [self.delegate keyboardDidClickedCancel:self];
    }
}
- (IBAction)sure:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(keyboardDidClickedSure:)]) {
        [self.delegate keyboardDidClickedSure:self];
    }
}

+(instancetype)keyboardTool
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CZKeyboard" owner:nil options:nil] lastObject];
}
@end
