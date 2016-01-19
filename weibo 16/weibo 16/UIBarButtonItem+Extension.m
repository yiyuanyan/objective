//
//  UIBarButtonItem+Extension.m
//  weibo 16
//
//  Created by 何建新 on 16/1/19.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    //初始化一个自定义view(UIButton)
    UIButton *button = [[UIButton alloc] init];
    //高亮状态
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    //普通状态
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //按钮的大小就是图片的大小
    button.size = button.currentImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
