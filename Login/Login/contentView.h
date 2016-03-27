//
//  contentView.h
//  Login
//
//  Created by 何建新 on 16/3/21.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contentView : UIView
-(UIView *)stringView:(NSString *)string stringFont:(UIFont *)stringFont;
@property(nonatomic, assign)CGFloat height;
@property(nonatomic, assign)BOOL hid;
@end
