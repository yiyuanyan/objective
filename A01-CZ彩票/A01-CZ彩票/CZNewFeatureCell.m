//
//  CZNewFeatureCell.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/9.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZNewFeatureCell.h"
#import "CZTabBarController.h"
@interface CZNewFeatureCell()
@property (weak, nonatomic) IBOutlet UIImageView *backgroudView;

- (IBAction)startClicked:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *startView;

@end
@implementation CZNewFeatureCell

//重写set方法，设置背景图片
-(void)setImageName:(NSString *)imageName
{
    self.backgroudView.image = [UIImage imageNamed:imageName];
}
- (IBAction)startClicked:(UIButton *)sender {
    CZTabBarController *vc = [[CZTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}
//设置按钮显示或隐藏
-(void)setStartViewHidden:(BOOL)hidden{
    self.startView.hidden = hidden;
}
@end
