//
//  ContactTableViewController.m
//  AddressBook2
//
//  Created by 何建新 on 16/3/2.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ContactTableViewController.h"
#import "JKContactModel.h"
#import "AddViewController.h"
#import "EditViewController.h"

//宏定义一个文件路径用来存储归档文件
#define ContactFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]

@interface ContactTableViewController ()<AddViewControllerDelegate>
- (IBAction)backAction:(id)sender;
@property(nonatomic, strong) NSMutableArray *contactArr;
@end

@implementation ContactTableViewController
- (NSMutableArray *)contactArr{
    if (!_contactArr) {
        _contactArr = [NSKeyedUnarchiver unarchiveObjectWithFile:ContactFilePath];
        if (_contactArr == nil) {
            _contactArr = [NSMutableArray array];
        }
        
    }
    return _contactArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self clearExtraLine:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.contactArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    // Configure the cell...
    JKContactModel *contactModel = self.contactArr[indexPath.row];
    cell.textLabel.text = contactModel.name;
    cell.detailTextLabel.text = contactModel.phone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
#pragma mark - 取消多余的线
//去掉tableView的空白cell，切记在viewDidLoad中调用这个方法
-(void)clearExtraLine:(UITableView *)tableView{
    //创意一个view
    UIView *view = [[UIView alloc] init];
    //设置view的背景颜色
    view.backgroundColor = [UIColor clearColor];
    //设置tableView的footerView为这个view
    [self.tableView setTableFooterView:view];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    //拿到一下个控制器，
//    AddViewController *addVc = segue.destinationViewController;
//    //设置下一个控制器的代理为自身
//    addVc.delegate = self;
    //因为本视图要跳转两个不同的视图控制器，所以，通过segue.destinationViewController获取将要跳转的控制器
    //然后进行判断要跳转到哪里
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[AddViewController class]]) {
        //如果跳转添加到联系人控制器
        AddViewController *addVc = vc;
        addVc.delegate = self;
    }else if([vc isKindOfClass:[EditViewController class]]){
        EditViewController *editVc = vc;
        //因为当前页面是tableView所以要获取当前选中的是哪一行，要把数据传递过去
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editVc.contactModel = self.contactArr[path.row];
        editVc.delegate = self;
    }
}
#pragma mark - UITableVIew delegate
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //1.删除数据模型
        [self.contactArr removeObjectAtIndex:indexPath.row];
        //2.刷新表视图
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        //3归档
        [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
    }
}
#pragma mark - EditVc delegate
//编辑页面的代理，用于处理编辑页面点击保存后列表页面内容没有刷新的问题
-(void)enditeViewController:(EditViewController *)editVc didSaveContact:(JKContactModel *)model{
    //刷新列表页面
    [self.tableView reloadData];
    //归档
    [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
}

#pragma mark - AddViewController delegate
-(void)addContact:(AddViewController *)addVc didAddContact:(JKContactModel *)contact{
    //添加数据模型
    [self.contactArr addObject:contact];
    //刷新视图
    [self.tableView reloadData];
    //3归档
    [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
}
- (IBAction)backAction:(id)sender {
    //初始化弹出信息
    //alertControllerWithTitle:消息标题
    //message:消息内容
    //preferredStyle:弹出样式
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"真的要注销吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    /*
     为弹出提示信息添加按钮和按钮动作
     actionWithTitle:按钮名称
     style:按钮样式
     handler:按钮动作，没有动作则nil
    */
    //取消按钮
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //确定按钮
    UIAlertAction *destuctiveBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //返回上一级控制器
        [self.navigationController popViewControllerAnimated:NO];
    }];
    [alert addAction:cancelBtn];
    [alert addAction:destuctiveBtn];
    //提示信息创建完毕后必须执行弹出方法
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
