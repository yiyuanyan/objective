//
//  CZLoopImageController.m
//  网易新闻-01
//
//  Created by 何建新 on 16/1/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZLoopImageController.h"
#import "CZLoopImage.h"
#import "CZLoopImageCell.h"
@interface CZLoopImageController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong)NSArray *loopImages;
//当前图片的索引
@property(nonatomic, assign)NSInteger currentIndex;
@end

@implementation CZLoopImageController

static NSString * const reuseIdentifier = @"loopimage";
//重写属性的set方法.当赋值后刷新collectionView
-(void)setLoopImages:(NSArray *)loopImages
{
    _loopImages = loopImages;
    //重新加载
    [self.collectionView reloadData];
    //无限滚动
    //1 启动后显示第二个cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CZLoopImage loopImages:^(NSArray *array) {
        self.loopImages = array;
        
        
    } error:^(NSError *e) {
        
    }];
    
    //滚动条不显示
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //分页滚动
    self.collectionView.pagingEnabled = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置flowlayout滚动方向为横向
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //取消边框
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    //设定flowLayout的大小为窗口大小
    self.flowLayout.itemSize = self.collectionView.bounds.size;
}


#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.loopImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CZLoopImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //计算当前显示的图片的索引
    NSInteger index = (indexPath.item - 1 + self.currentIndex + self.loopImages.count) % self.loopImages.count;
    
    cell.tag = index;
    cell.loopImage = self.loopImages[index];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//当滚动停止以后
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int num = scrollView.contentOffset.x / scrollView.frame.size.width - 1;
    self.currentIndex = (self.currentIndex + num + self.loopImages.count) % self.loopImages.count;
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
    //解决快速移动,图片跳跃的问题
    [UIView setAnimationsEnabled:NO];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [UIView setAnimationsEnabled:YES];
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
