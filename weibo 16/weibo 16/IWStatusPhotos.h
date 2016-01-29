//
//  IWStatusPhotos.h
//  weibo 16
//
//  Created by 何建新 on 16/1/28.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWStatusPhotos : UIView
@property(nonatomic, strong)NSArray *pic_url;
+(CGSize)sizeWithCount:(NSInteger)count;
@end
