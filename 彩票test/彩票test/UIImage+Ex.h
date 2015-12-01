//
//  UIImage+Ex.h
//  彩票test
//
//  Created by 何建新 on 15/11/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ex)
//定义一个方法，返回图片调用时使用图片原始状态。不进行特殊渲染
-(UIImage *)originalImage;
@end
