//
//  CZLotteryHallController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZLotteryHallController.h"
#import "UIImage+Ex.h"
@interface CZLotteryHallController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property(nonatomic, weak)UIView *coverView;
@property(nonatomic, weak)UIImageView *imageView;
@property(nonatomic, weak)UIButton *closeButton;
@end

@implementation CZLotteryHallController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消按钮图片的蒙版
    self.leftButton.image = [self.leftButton.image originalImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击活动按钮弹出图片,点击弹出图片和遮盖的view
- (IBAction)leftClick:(UIBarButtonItem *)sender {
    //获取keyWindow
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //创建遮盖的view
    UIView *view = [[UIView alloc]init];
    self.coverView = view;
    //把遮盖view添加到window上
    [window addSubview:view];
    view.frame = [UIScreen mainScreen].bounds;
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    
    //显示图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aa"]];
    [window addSubview:imageView];
    imageView.center = view.center;
    self.imageView = imageView;
    //关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //将关闭按钮放入imageView中
    [imageView addSubview:closeBtn];
    //设置关闭按钮图片
    [closeBtn setImage:[UIImage imageNamed:@"alphaClose"] forState:UIControlStateNormal];
    //图片大小,让大小与内容一致
    [closeBtn sizeToFit];
    //点击按钮关闭
    [closeBtn addTarget:self action:@selector(btnClose) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton = closeBtn;
    //关闭按钮在imageView中，必须让imageView能和用户交互
    imageView.userInteractionEnabled = YES;
}
-(void)btnClose{
    //动画方式关闭遮盖view
    [UIView animateWithDuration:1 animations:^{
        self.coverView.alpha = 0;
        self.imageView.frame = CGRectMake(40, 45, 0, 0);
        self.closeButton.frame = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.imageView removeFromSuperview];
        [self.closeButton removeFromSuperview];
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 13;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.textLabel.text = @"这里是数据";
    
    
    return cell;
}


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
