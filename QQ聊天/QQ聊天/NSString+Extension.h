//
//  NSString+Extension.h
//  QQ聊天
//
//  Created by 何建新 on 15/10/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)
//根据最大尺寸和字体计算文字的实际尺寸
-(CGSize) sizeWithMaxSize:(CGSize) maxSize andFont:(UIFont *)font;
@end
