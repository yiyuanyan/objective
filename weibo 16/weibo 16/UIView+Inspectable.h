//
//  UIView+Inspectable.h
//  weibo 16
//
//  Created by 何建新 on 16/1/20.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Inspectable)
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic, strong)IBInspectable UIColor *bordercolor;
@property(nonatomic,assign)IBInspectable CGFloat borderWidth;
@end
