//
//  CZToolBar.h
//  键盘处理-练习
//
//  Created by 何建新 on 15/11/12.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZToolBar;
//枚举，判断按钮类型
typedef enum: NSUInteger
{
    CZToolBarButtonTypePre,
    CZToolBarButtonTypeNext,
    CZToolBarButtonTypeDone
}CZToolBarButtonType;
//定义代理方法
@protocol CZToolBarDelegate <NSObject>

-(void)toolBar:(CZToolBar *)toolBar didClickWithBtnType:(CZToolBarButtonType)type;

@end
@interface CZToolBar : UIToolbar
//上一个
@property (weak, nonatomic) IBOutlet UIBarButtonItem *preButton;
//下一个
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
//关闭
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
//定义类方法，拿到xib文件
+(instancetype)toolBar;
//定义要遵守代理协议
@property(nonatomic, weak)id<CZToolBarDelegate>toolBarDelegate;
@end
