//
//  CZWheelButton.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZWheelButton : UIButton
@property(nonatomic, assign)CGFloat imgW;
@property(nonatomic, assign)CGFloat imgH;

+(instancetype)wheelButton:(CGFloat)imgW imgH:(CGFloat)imgH;
@end
