//
//  CZWheelView.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/1.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZWheelView.h"
#import "UIView+Ex.h"
@interface CZWheelView()
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *wheelView;
@property(weak, nonatomic)UIButton *preButton;
@end
@implementation CZWheelView
//点击开始按钮
- (IBAction)startClick:(UIButton *)sender {
}
+(instancetype)wheelView{
    return [[[NSBundle mainBundle]loadNibNamed:@"CZWheelView" owner:nil options:nil] lastObject];
}//生成12个按钮
-(void)awakeFromNib{
    int count = 12;  //12个按钮
    //加载按钮上显示的图片。要分割成12份
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selBigImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    //获取的是点(pt)，转换成px(像素)
    CGFloat scale = [UIScreen mainScreen].scale;  //这个就是获取屏幕是@1x @2x @3x
    CGFloat imgW = bigImage.size.width / count * scale;
    CGFloat imgH = bigImage.size.height * scale;
    for (int i = 0; i < count; i++) {
        //剪切图片
        CGFloat x = i * imgW;
        CGFloat y = 0;
        CGImageRef cgImg = CGImageCreateWithImageInRect(bigImage.CGImage, CGRectMake(x, y, imgW, imgH));
        CGImageRef cgSelImg = CGImageCreateWithImageInRect(selBigImage.CGImage, CGRectMake(x, y, imgW, imgH));
        //CGImage转换成UIImage
        UIImage *img = [UIImage imageWithCGImage:cgImg];
        UIImage *selImg = [UIImage imageWithCGImage:cgSelImg];
        //释放掉CGImage
        CGImageRelease(cgImg);
        CGImageRelease(cgSelImg);
        //创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.wheelView addSubview:btn];
        
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:selImg forState:UIControlStateSelected];
        //设置按钮选中的背景图片
        UIImage *selBackImg = [UIImage imageNamed:@"LuckyRototeSelected"];
        [btn setBackgroundImage:selBackImg forState:UIControlStateSelected];
        btn.width = selBackImg.size.width;
        btn.height = selBackImg.size.height;
        
        btn.center = self.wheelView.center;
        //旋转图片
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.transform = CGAffineTransformMakeRotation(i * M_PI * 2 / count);
        //设置点击事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //允许wheelView视图与用户交互
        self.wheelView.userInteractionEnabled = YES;
    }
}
//按钮点击事件
-(void)btnClick:(UIButton *)sender
{
    self.preButton.selected = NO;
    sender.selected = YES;
    
    self.preButton = sender;
}

@end
