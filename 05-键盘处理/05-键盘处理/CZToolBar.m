//
//  CZToolBar.m
//  05-键盘处理
//
//  Created by 何建新 on 15/11/11.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZToolBar.h"

@implementation CZToolBar
//上一个
- (IBAction)preBtnClick:(id)sender {
    if ([_toolBarDelegate respondsToSelector:@selector(toolBar:didClickWithBtnType:)]) {
        [_toolBarDelegate toolBar:self didClickWithBtnType:CZToolBarButtonTypePre];
    }
}
//下一个
- (IBAction)nextBtnClick:(id)sender {
    if ([_toolBarDelegate respondsToSelector:@selector(toolBar:didClickWithBtnType:)]) {
        [_toolBarDelegate toolBar:self didClickWithBtnType:CZToolBarButtonTypeNext];
    }
}
//完成
- (IBAction)doneBtnClick:(id)sender {
    if ([_toolBarDelegate respondsToSelector:@selector(toolBar:didClickWithBtnType:)]) {
        [_toolBarDelegate toolBar:self didClickWithBtnType:CZToolBarButtonTypeDone];
    }
}

+(instancetype)toolBar
{
    return [[[NSBundle mainBundle]loadNibNamed:@"CZToolBar" owner:nil options:nil]lastObject];
}

@end
