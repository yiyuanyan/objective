//
//  CZProductsController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/8.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZProductsController.h"
#import "CZProduct.h"
#import "CZProductCell.h"
@interface CZProductsController ()
@property(nonatomic, strong)NSArray *products;
@end

@implementation CZProductsController
-(NSArray *)products
{
    if (_products == nil) {
        //加载json
        NSString *path = [[NSBundle mainBundle]pathForResource:@"products" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        //字典转模型
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            CZProduct *pro = [CZProduct productWithDic:dic];
            [mArray addObject:pro];
        }
        _products = mArray.copy;
        
    }
    return _products;
}
//1.重写ini方法。设置flowLayout
-(instancetype)init
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(75, 75);
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 15;
    flow.headerReferenceSize = CGSizeMake(0, 20);
    return [super initWithCollectionViewLayout:flow];
}
    static NSString *reuseId = @"product";
//2.注册nib或者自定义类
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    
    UINib *nib = [UINib nibWithNibName:@"CZProductView" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseId];
}


//3.
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CZProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    
    cell.product = self.products[indexPath.item];
    
    
    return cell;
    
}


@end
