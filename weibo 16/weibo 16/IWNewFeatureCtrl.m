//
//  IWNewFeatureCtrl.m
//  weibo 16
//
//  Created by 何建新 on 16/1/21.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWNewFeatureCtrl.h"
#import "IWViewController.h"
#import "IWAcount.h"
#import "IWOAuthViewCtrl.h"
#import "UIWindow+Extension.h"
@interface IWNewFeatureCtrl ()<UIScrollViewDelegate>
@property(nonatomic, weak)UIPageControl *pageConrol;
@end

@implementation IWNewFeatureCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //添加UISCrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //打开scrollView的分页模式
    scrollView.pagingEnabled = YES;
    //关闭scrollView的滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //为了监听scrollView的滚动，要让self成为scrollView的代理
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:scrollView];
    NSInteger count = 4;
    for (int i = 0; i<4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%zd",i+1]];
        //设置imageView的位置与大小
        imageView.size = scrollView.size;
        imageView.x = i * scrollView.width;
        
        [scrollView addSubview:imageView];
        //如果是最后一张imageView，就往其身上添加两个按钮
        if (i==count - 1) {
            [self setupLastPage:imageView];
        }
        
    }
    //设置scrollView的滚动区域
    scrollView.contentSize = CGSizeMake(count * scrollView.width, 0);
    
    //pageControl
    UIPageControl *control = [[UIPageControl alloc] init];
    //指定分页标签个数
    control.numberOfPages = count;
    //选中的颜色
    control.currentPageIndicatorTintColor = [UIColor orangeColor];
    //未选中的颜色
    control.pageIndicatorTintColor = [UIColor grayColor];
    control.size = CGSizeMake(SCREENW, 30);
    control.centerX = SCREENW * 0.5;
    control.y = SCREENH - 100;
    
    [self.view addSubview:control];
    self.pageConrol = control;
}
//设置新特性的最后一页
-(void)setupLastPage:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    //添加进入微博的button
    UIButton *enterBtn = [[UIButton alloc]init];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [enterBtn setTitle:@"进入微博" forState:UIControlStateNormal];
    //按钮的size就是背景图片的size
    enterBtn.size = enterBtn.currentBackgroundImage.size;
    enterBtn.centerX = imageView.width * 0.5;
    enterBtn.y = imageView.height - 150;
    [enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:enterBtn];
    //添加分享按钮
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateSelected];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享到微博" forState:UIControlStateNormal];
    
    [shareBtn sizeToFit];
    shareBtn.centerX = enterBtn.centerX;
    shareBtn.y = enterBtn.y - 50;
    
    
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
}
-(void)enterBtnClick:(UIButton *)btn{
    //进入首页
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //判断用户是否登陆过
    [window switchRootViewCtrl];
}
//scrollViwe的监听滚动的代理方法                  
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算出当前偏移页数，小数
    CGFloat count = scrollView.contentOffset.x /scrollView.width;
    //在四舍五入
    NSInteger pageNum = (int)(count + 0.5);
    self.pageConrol.currentPage = pageNum;
}
-(void)shareBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

@end
