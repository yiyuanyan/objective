//
//  CZProductCell.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/8.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZProductCell.h"
#import "CZProduct.h"
@interface CZProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end
@implementation CZProductCell
-(void)setProduct:(CZProduct *)product
{
    _product = product;
    self.titleView.text = product.title;
    self.iconView.image = [UIImage imageNamed:product.icon];
}
-(void)awakeFromNib
{
    //设置为圆角
    self.iconView.layer.cornerRadius = 10;
    self.iconView.layer.masksToBounds = YES;
}
@end
