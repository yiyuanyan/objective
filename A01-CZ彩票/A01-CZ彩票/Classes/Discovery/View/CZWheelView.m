//
//  CZWheelView.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/1.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZWheelView.h"

#import "CZWheelButton.h"
#import "UIView+Ex.h"
@interface CZWheelView()
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *wheelView;
@property(weak, nonatomic)UIButton *preButton;

@property(nonatomic, strong)CADisplayLink *displayLink;
@end
@implementation CZWheelView
//点击开始按钮,让转盘开始旋转
- (IBAction)startClick:(UIButton *)sender {
    //属性方法，这个方法调用transform.rotation方法。进行动画旋转
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //旋转角度
    anim.toValue = @(M_PI * 2);
    //循环次数，MAXFLOAT为一直循环
    //anim.repeatCount = MAXFLOAT;
    //动画执行时间
    anim.duration = 0.5;
    
    anim.delegate = self;
    [self.wheelView.layer addAnimation:anim forKey:nil];
}
//快速动画的代理方法
-(void)animationDidStart:(CAAnimation *)anim
{
    //禁用和用户的交互
    self.userInteractionEnabled = NO;
    //当快速动画开始，暂停慢速动画
    self.displayLink.paused = YES;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    //当动画停止，让当前选中的按钮指向最上面
    self.wheelView.transform = CGAffineTransformMakeRotation(self.preButton.tag * -M_PI * 2/ 12);
    
    
    //快速动画停止以后
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.displayLink.paused = NO;
    });
}
//控制器加载后立即慢速旋转(不能使用核心动画，使用核心动画和用户交互有问题)
-(void)rotate{
    //和屏幕的刷新率保持一致
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotateStart)];
    self.displayLink = displayLink;
    //将其加入循环，消息循环
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}
-(void)rotateStart{
    self.wheelView.transform = CGAffineTransformRotate(self.wheelView.transform, M_PI_4/60);
}
+(instancetype)wheelView{
    return [[[NSBundle mainBundle]loadNibNamed:@"CZWheelView" owner:nil options:nil] lastObject];
}
//生成12个按钮
-(void)awakeFromNib{
    [self rotate];
    int count = 12;  //12个按钮
    //加载按钮上显示的图片。要分割成12份
    //默认图片
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    //选中图片
    UIImage *selBigImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    //获取的是点(pt)，转换成px(像素)
    CGFloat scale = [UIScreen mainScreen].scale;  //这个就是获取屏幕是@1x @2x @3x
    CGFloat imgW = bigImage.size.width / count * scale;
    CGFloat imgH = bigImage.size.height * scale;
    for (int i = 0; i < count; i++) {
        //剪切图片
        CGFloat x = i * imgW;
        CGFloat y = 0;
        //C语言函数，图片裁剪，返回的是像素，要转换为点，C语言必须释放内存，使用CGImageRelease()
        CGImageRef cgImg = CGImageCreateWithImageInRect(bigImage.CGImage, CGRectMake(x, y, imgW, imgH));
        CGImageRef cgSelImg = CGImageCreateWithImageInRect(selBigImage.CGImage, CGRectMake(x, y, imgW, imgH));
        //CGImage转换成UIImage
        UIImage *img = [UIImage imageWithCGImage:cgImg];
        UIImage *selImg = [UIImage imageWithCGImage:cgSelImg];
        //释放掉CGImage
        CGImageRelease(cgImg);
        CGImageRelease(cgSelImg);
        //创建按钮,自定义按钮
        CZWheelButton *btn = [CZWheelButton wheelButton:imgW / scale imgH:imgH / scale];
        [self.wheelView addSubview:btn];
        //改变btn的imageView的大小，让图片缩小
        btn.tag = i;
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:selImg forState:UIControlStateSelected];
        //设置按钮选中的背景图片
        UIImage *selBackImg = [UIImage imageNamed:@"LuckyRototeSelected"];
        [btn setBackgroundImage:selBackImg forState:UIControlStateSelected];
        //设置按钮大小
        btn.width = selBackImg.size.width;
        btn.height = selBackImg.size.height;
        
        btn.center = self.wheelView.center;
        //旋转图片
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        //旋转pi/12角度
        btn.transform = CGAffineTransformMakeRotation(i * M_PI * 2 / count);
        //设置点击事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        //允许wheelView视图与用户交互
        self.wheelView.userInteractionEnabled = YES;
        if (i == 0) {
            [self btnClick:btn];
        }
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
