//
//  UIBarButtonItem+Extension.h
//  weibo 16
//
//  Created by 何建新 on 16/1/19.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
//返回一个barButtonItem(根据图片名字--自定义一个button座位customView)
+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action title:(NSString *)title;
@end
