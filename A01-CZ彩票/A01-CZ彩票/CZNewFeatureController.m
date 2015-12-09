//
//  CZNewFeatureController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/8.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZNewFeatureController.h"
#import "CZNewFeatureCell.h"
#import "UIView+Ex.h"
#define kCOUNT 4
@interface CZNewFeatureController ()
@property(nonatomic,weak)UIImageView *guideView;
@property(nonatomic,weak)UIImageView *guideLargeTextView;
@property(nonatomic,weak)UIImageView *guideSmallTextView;
@end

@implementation CZNewFeatureController

//设置flowlayout
-(instancetype)init{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell的大小和间距
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    //修改滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flowLayout];
}
//注册nib或者自定义cell的类
static NSString *reuseId = @"image";
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    UINib *nib = [UINib nibWithNibName:@"CZNewFeatureCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseId];
    
    [self addImageView];
    
    
}


-(void)addImageView{
    UIImageView *guideLineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideLine"]];
    guideLineView.x = -200;
    [self.collectionView addSubview:guideLineView];
    
    //添加参与动画的图片
    UIImageView *guideView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide1"]];
    self.guideView = guideView;
    [self.collectionView addSubview:guideView];
    
    UIImageView *guideLargeTextView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    guideLargeTextView.y = self.collectionView.height * 0.7;
    self.guideLargeTextView = guideLargeTextView;
    [self.collectionView addSubview:guideLargeTextView];
    
    UIImageView *guideSmallTextView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    guideSmallTextView.y = self.collectionView.height * 0.8;
    self.guideSmallTextView = guideSmallTextView;
    [self.collectionView addSubview:guideSmallTextView];
}
//当滚动停止的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //横向偏移
    CGFloat offsetX = scrollView.contentOffset.x;
    //宽度
    CGFloat w = scrollView.width;
    //判断左滚动还是右滚动
    if (offsetX < self.guideView.x) {
        w = -w;
    }
    self.guideView.x = offsetX + w;
    self.guideLargeTextView.x = offsetX + w;
    self.guideSmallTextView.x = offsetX + w;
    //动画
    [UIView animateWithDuration:0.2 animations:^{
        self.guideView.x = offsetX;
        self.guideLargeTextView.x = offsetX;
        self.guideSmallTextView.x = offsetX;
    }];
    //修改图片
    int page = offsetX / abs(w) + 1; //获取当前页
    NSString *guide = [NSString stringWithFormat:@"guide%d",page];
    NSString *guideLargeText = [NSString stringWithFormat:@"guideLargeText%d",page];
    NSString *guideSmallText = [NSString stringWithFormat:@"guideSmallText%d",page];
    
    self.guideView.image = [UIImage imageNamed:guide];
    self.guideLargeTextView.image = [UIImage imageNamed:guideLargeText];
    self.guideSmallTextView.image = [UIImage imageNamed:guideSmallText];
}
//数据源的方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kCOUNT;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"image";
    //创建
    CZNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    //设置自定义cell的背景图片
    cell.imageName = [NSString stringWithFormat:@"guide%zdBackground",indexPath.item + 1];
    if (indexPath.item + 1 == kCOUNT) {
        [cell setStartViewHidden:NO];
    }else{
        [cell setStartViewHidden:YES];
    }
    
    
    return cell;
}
@end
