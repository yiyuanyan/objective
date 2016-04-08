//
//  playBlockButton.h
//  Login
//
//  Created by 何建新 on 16/4/7.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ButtonBlock) (NSIndexPath *indexPath);
@interface playBlockButton : UIButton
@property(nonatomic, copy)ButtonBlock buttonBlock;

@end
