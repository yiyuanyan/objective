//
//  CZKeyboard.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZKeyboard;
@protocol CZKeyboardDeletage <NSObject>
-(void)keyboardDidClickedCancel:(CZKeyboard *)kb;
-(void)keyboardDidClickedSure:(CZKeyboard *)kb;
@end
@interface CZKeyboard : UIView
+(instancetype)keyboardTool;

@property(nonatomic, weak)id <CZKeyboardDeletage>delegate;
@end
