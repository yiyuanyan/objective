//
//  CZNewFeatureCell.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/9.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZNewFeatureCell : UICollectionViewCell
@property(nonatomic, copy)NSString *imageName;  //背景图片的名字
-(void)setStartViewHidden:(BOOL)hidden;
@end
