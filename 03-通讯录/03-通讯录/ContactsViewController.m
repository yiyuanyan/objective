//
//  ContactsViewController.m
//  03-通讯录
//
//  Created by 何建新 on 15/11/18.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ContactsViewController.h"
#import "AddViewController.h"
#import "Contact.h"
#import "EditViewController.h"
#define kContactsFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contacts.data"]
@interface ContactsViewController ()<UIActionSheetDelegate,AddViewControllerDelegate>
- (IBAction)logout:(UIBarButtonItem *)sender;
//记录输入的信息，从AddViewController页面逆传的值
@property(nonatomic, strong)NSMutableArray *contacts;
@property(nonatomic, strong)Contact *con;
@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //拼接字符串
    NSString *str = [NSString stringWithFormat:@"%@的联系人",self.userName];
    //设置nav的title
    self.title = str;
    //让cell有数据就有下分割线，没有数据就没有下分割线
    self.tableView.tableFooterView = [[UIView alloc]init];
    //解档
    self.contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:kContactsFilePath];
    //NSLog(@"%@",kContactsFilePath);
    
}
//懒加载
-(NSMutableArray *)contacts
{
    if (_contacts == nil) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

//添加联系人代理方法
-(void)addViewController:(AddViewController *)viewController withCibtact:(Contact *)contact
{
    
    [self.contacts addObject:contact];
    [self.tableView reloadData];
    
    

    //归档操作
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kContactsFilePath];
    
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //判断目标控制器是哪个
    //获取要跳转的控制器
    UIViewController *vc = segue.destinationViewController;
    //判断控制器是哪个
    if ([vc isKindOfClass:[AddViewController class]]) {
        //转换VC类型
        AddViewController *add = (AddViewController *)vc;
        add.addViewControllerDelegate = self;
    }else{
        //进入编辑界面
        //获取编辑页面
        EditViewController *edit = (EditViewController *)vc;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Contact *c = self.contacts[indexPath.row];
        edit.con = c;
    }
    
    //通过添加联系人的页面设置代理
   //AddViewController *add = segue.destinationViewController;
    
}

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
//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.contacts.count;
}

//cell的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义cell的ID
    static NSString *cellid = @"conteactsCell";
    //查找缓存池
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    Contact *contact = self.contacts[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.number;
    
    return cell;
    
}
//pop回来的时候将要显示时刷新页面
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    //归档
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kContactsFilePath];
}
////点击cell的时候调用
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.con = self.contacts[indexPath.row];
//}
//代理方法。cell的滑动删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    //[self.contacts removeObject:self.contacts[indexPath.row]];
    //从数组中删除指定元素
    [self.contacts removeObjectAtIndex:indexPath.row];
    //刷新页面
    //[self.tableView reloadData];
    //第二种方法刷新页面
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
//改变滑动删除按钮上的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
@end
