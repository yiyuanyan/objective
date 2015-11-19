//
//  ContactsViewController.m
//  03-通讯录
//
//  Created by 何建新 on 15/11/18.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ContactsViewController.h"
#import "AddViewController.h"
@interface ContactsViewController ()<UIActionSheetDelegate,AddViewControllerDelegate>
- (IBAction)logout:(UIBarButtonItem *)sender;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //拼接字符串
    NSString *str = [NSString stringWithFormat:@"%@的联系人",self.userName];
    //设置nav的title
    self.title = str;
    NSLog(@"%@",self.userName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//添加联系人代理方法
-(void)addViewController:(AddViewController *)viewController withName:(NSString *)name andNumber:(NSString *)number
{
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //通过添加联系人的页面设置代理
   AddViewController *add = segue.destinationViewController;
    add.addViewControllerDelegate = self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//注销按钮
- (IBAction)logout:(UIBarButtonItem *)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    //定义sheet弹出提示框。delegate为自身
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"确定要注销吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //显示提示框，在那个视图
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
