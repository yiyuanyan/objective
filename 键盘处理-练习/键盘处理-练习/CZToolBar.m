//
//  CZToolBar.m
//  键盘处理-练习
//
//  Created by 何建新 on 15/11/12.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZToolBar.h"

@implementation CZToolBar


+(instancetype)toolBar
{
    //返回的是数组，所以要取到数组的lastObject个元素，才是NIB文件
    return [[[NSBundle mainBundle]loadNibNamed:@"CZToolBar" owner:nil options:nil]lastObject];
}

- (IBAction)preBtnClick:(UIBarButtonItem *)sender {
    //判断是否可以响应代理方法
    if ([_toolBarDelegate respondsToSelector:@selector(toolBar:didClickWithBtnType:)]) {
        [_toolBarDelegate toolBar:self didClickWithBtnType:CZToolBarButtonTypePre];
    }
}
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender {
    if ([_toolBarDelegate respondsToSelector:@selector(toolBar:didClickWithBtnType:)]) {
        [_toolBarDelegate toolBar:self didClickWithBtnType:CZToolBarButtonTypeNext];
    }
}
- (IBAction)doneBtnClick:(id)sender {
    if ([_toolBarDelegate respondsToSelector:@selector(toolBar:didClickWithBtnType:)]) {
        [_toolBarDelegate toolBar:self didClickWithBtnType:CZToolBarButtonTypeDone];
    }
}

@end
