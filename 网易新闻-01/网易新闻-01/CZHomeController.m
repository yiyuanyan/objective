//
//  CZHomeController.m
//  网易新闻-01
//
//  Created by 何建新 on 16/1/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZHomeController.h"
#import "CZChannel.h"
#import "CZHomeCell.h"
#import "CZChannelView.h"
@interface CZHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic, strong) NSArray *channels;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic, assign)NSInteger currentIndex;
@end

@implementation CZHomeController
-(NSArray *)channels
{
    if (_channels ==nil) {
        _channels = [CZChannel channels];
    }
    return _channels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadChannels];
    
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //此处的collectionView的frame是从sb中加载
    
    
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
}
//自动布局之后在设置cell的size
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.flowLayout.itemSize = self.collectionView.bounds.size;
}
-(void)loadChannels{
    //关闭自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    //
    CGFloat marginX = 5;
    CGFloat x = marginX;
    CGFloat h = self.scrollView.bounds.size.height;
    
    //遍历频道列表,生成label
    for (CZChannel *channel in self.channels) {
        CZChannelView *lbl = [CZChannelView channelViewWithTName:channel.tname];
        [self.scrollView addSubview:lbl];
        lbl.text = channel.tname;
        [lbl sizeToFit];
        lbl.frame = CGRectMake(x, 0, lbl.frame.size.width, h);
        x += lbl.frame.size.width + marginX;
    }
    //设置scrollView滚动
    self.scrollView.contentSize = CGSizeMake(x, 0);
    //去掉滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    CZChannelView *first = self.scrollView.subviews[self.currentIndex];
    first.scale = 1;
}
//返回有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CZHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"home" forIndexPath:indexPath];
    CZChannel *channel = self.channels[indexPath.item];
    cell.urlStr = channel.urlStr;
    return cell;
}
//正在滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //
    CZChannelView *currentLabel = self.scrollView.subviews[self.currentIndex];
    CZChannelView *nextLabel = nil;
    NSArray *array = [self.collectionView indexPathsForVisibleItems];
    for (NSIndexPath *indexPath in array) {
        if (indexPath.item != self.currentIndex) {
            nextLabel = self.scrollView.subviews[indexPath.item];
            break;
        }
    }
    if (nextLabel == nil) {
        return;
    }
    float scale = ABS(scrollView.contentOffset.x / scrollView.bounds.size.width - self.currentIndex);
    nextLabel.scale = scale;
    currentLabel.scale = 1-scale;
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
}
@end
