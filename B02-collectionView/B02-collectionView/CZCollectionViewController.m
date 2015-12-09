//
//  CZCollectionViewController.m
//  B02-collectionView
//
//  Created by 何建新 on 15/12/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZCollectionViewController.h"

@interface CZCollectionViewController ()

@end

@implementation CZCollectionViewController
-(instancetype)init
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //设置cell的默认大小
    return [super initWithCollectionViewLayout:flow];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //注册创建cell的自定义类
    static NSString *reuseId = @"cell";
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseId];
}

//数据源的方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


@end
