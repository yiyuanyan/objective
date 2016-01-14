//
//  CZLoopImageController.m
//  网易新闻
//
//  Created by 何建新 on 16/1/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZLoopImageController.h"
#import "CZLoopImage.h"
#import "CZLoopImageCell.h"
@interface CZLoopImageController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong)NSArray *loopImages;
//记录当前显示的第几张图片
@property(nonatomic, assign)NSInteger currentIndex;
@end

@implementation CZLoopImageController

static NSString * const reuseIdentifier = @"loopimage";
//重写属性的setter方法。档赋值之后刷新collectionView
-(void)setLoopImages:(NSArray *)loopImages
{
    _loopImages = loopImages;
    
    //重新加载
    [self.collectionView reloadData];
    //无限滚动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [CZLoopImage loopImages:^(NSArray *array) {
        //成功,拿到数据
        self.loopImages = array;
    } error:^(NSError *error) {
        
    }];
    
    //不显示滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //允许滚动分页显示
    self.collectionView.pagingEnabled = YES;
}
//当视图将要出现的时候对cell进行大小的设置，这样显示画面后大小就设置好了
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置flowLayout横向滚动
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置没有边框
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    //设置flowlayout的大小为内容的大小
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
    // Configure the cell
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
    //解决快速移动图片跳跃的问题
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
