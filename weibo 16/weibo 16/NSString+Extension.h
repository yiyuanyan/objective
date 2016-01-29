//
//  NSString+Extension.h
//  weibo 16
//
//  Created by 何建新 on 16/1/29.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font;

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
