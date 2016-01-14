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
@interface CZHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic, strong) NSArray *channels;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
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
        UILabel *lbl = [[UILabel alloc]init];
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

@end
