//
//  CZToolBar.h
//  05-键盘处理
//
//  Created by 何建新 on 15/11/11.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZToolBar;
//通过枚举判断点击的按钮是哪个
typedef enum: NSUInteger
{
    CZToolBarButtonTypePre,
    CZToolBarButtonTypeNext,
    CZToolBarButtonTypeDone
}CZToolBarButtonType;
//自定义代理协议
@protocol CZToolBarDelegate <NSObject>

-(void)toolBar:(CZToolBar *)toolBar didClickWithBtnType:(CZToolBarButtonType) type;

@end
@interface CZToolBar : UIToolbar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *preButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

+(instancetype)toolBar;
@property(nonatomic, weak)id <CZToolBarDelegate>toolBarDelegate;
@end
