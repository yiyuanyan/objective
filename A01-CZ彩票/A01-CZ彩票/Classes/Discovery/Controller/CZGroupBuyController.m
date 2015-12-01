//
//  CZGroupBuyController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/30.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZGroupBuyController.h"
#import "UIImage+Ex.h"
#import "UIView+Ex.h"
#import "CZTitleButton.h"
@interface CZGroupBuyController ()
@property(nonatomic, weak)UIView *popView;
@end

@implementation CZGroupBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //自定义后退按钮
//    //设置返回按钮,调用UIImage+Ex.h扩展类
//    UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"NavBack"] originalImage] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
//    //创建一个UIBarButtonImte。样式为弹簧样式fixedSpace.将其宽度设置为-10.让后用数组方式添加到navigationItem.leftBarButtonItems中。这样返回按钮就会往左移动10个像素
//    UIBarButtonItem* fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
//    fixedItem.width = -10;
//    
//    self.navigationItem.leftBarButtonItems = @[fixedItem, backItem];
//    
//    //自定义后退后，收拾返回上一级控制器的功能
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    //设置titleView的按钮
    CZTitleButton *titleButton = [CZTitleButton buttonWithType:UIButtonTypeCustom];
    self.navigationItem.titleView = titleButton;
    //设置按钮中显示的内容
    [titleButton setTitle:@"全部彩种" forState:UIControlStateNormal];
    //设置按钮的图片
    [titleButton setImage:[UIImage imageNamed:@"YellowDownArrow"] forState:UIControlStateNormal];
    //选中状态的背景图片
    UIImage *selBackImg = [UIImage imageNamed:@"navTitleSel"];
    [titleButton setImage:selBackImg forState:UIControlStateSelected];
    //设置按钮的大小和背景图片的大小一致
    //[titleButton sizeToFit];
    titleButton.width = selBackImg.size.width;
    titleButton.height = selBackImg.size.height;
    //调整按钮中label和imageView的位置
    //点击按钮
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置最右边两个按钮
//    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    item3.width = -10;
//    
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"发合买" style:UIBarButtonItemStylePlain target:self action:nil];
//
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"NavInfoFlat"] originalImage] style:UIBarButtonItemStylePlain target:nil action:nil];
//    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItems = @[item3,item2,item1];
    UIView *view = [[UIView alloc]init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn1];
    [btn1 setTitle:@"发合买" forState:UIControlStateNormal];
    [btn1 sizeToFit];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn2];
    [btn2 setImage:[UIImage imageNamed:@"NavInfoFlat"] forState:UIControlStateNormal];
    [btn2 sizeToFit];
    
    
    //计算各个控件和大小
    view.width = btn1.width + btn2.width + 5;
    view.height = 44;
    
    btn2.x = CGRectGetMaxX(btn1.frame) + 5;
    btn1.y = (view.height - btn1.height) * 0.5;
    btn2.y = (view.height - btn2.height) * 0.5;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item2.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[item2,item];
    
    
}

//点击全部彩种按钮 titleButton
-(void)titleClick:(UIButton *)sender{
    //状态取反
    sender.selected = !sender.isSelected;
    //旋转图片,带动画。CGAffineTransformRotate(上次图片的位置，下次图片的位置)
    [UIView animateWithDuration:0.5 animations:^{
        sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI);
    }];
    
    if (sender.selected) {
        //弹出一个View
        UIView *view = [[UIView alloc] init];
        self.popView = view;
        [self.view addSubview:view];
        //设置view的frame
        view.frame = CGRectMake(0, 0, self.view.width, self.view.height * 0.5);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.7;
    }else{
        [self.popView removeFromSuperview];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
