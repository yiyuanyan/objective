//
//  CategoryTableViewController.m
//  Login
//
//  Created by 何建新 on 16/3/4.
//  Copyright © 2016年 何建新. All rights reserved.
//
/*
 http://test.benniaoyasi.cn/api.php?m=api&c=category&a=listcategory&appid=1&pid=1&mobile=18600562546&version=4.4.7&devtype=ios&uuid=21DCEFDF-5B85-4FF9-9A5D-5C3AD103D083
 */

#import "CategoryTableViewController.h"
#import "getNetworkQuest.h"
#import "alertMessageViewController.h"
#import "PartOneTableViewCell.h"
#import "PartOneSecondColumnTableViewController.h"
#import "PartTwoSecondColumnTableViewController.h"
@interface CategoryTableViewController ()
- (IBAction)backAction:(UIBarButtonItem *)sender;
//栏目数组
@property(nonatomic, copy) NSDictionary *categoryDic;
@property(nonatomic, copy) NSArray *catArray;
@property(nonatomic, strong) UIWindow *win;
@property(nonatomic, strong)UIView *footView;
@property(nonatomic, strong)UIButton *part1;
@property(nonatomic, strong)UIButton *part23;
@property(nonatomic, strong)UIView *partBottomView;
@property(nonatomic, assign) NSInteger partType;  //part1=1  part2_3 = 23
@end

@implementation CategoryTableViewController
-(NSArray *)catArray
{
    if (!_catArray) {
        _catArray = [NSArray array];
    }
    return _catArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.partType = 1;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getCategorys];
    [self clearExtraLine:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.footView.alpha=1;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryDic.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)[indexPath section],(long)[indexPath row]];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    PartOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
        cell = [[PartOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //}
    //设置cell选择样式
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    // Configure the cell...
    NSDictionary *dic = self.catArray[indexPath.row];
    cell.nameLabel.text = dic[@"ename"];

    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //获取文字
    NSString *stringText = cell.nameLabel.text;
    //获取文字字体
    UIFont *stringFont = cell.nameLabel.font;
    //获取文字大小
    CGSize stringSize = [stringText sizeWithAttributes:@{NSFontAttributeName:stringFont}];
    //计算nameLabel的宽度

    [cell.nameLabel setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - stringSize.width)/2, 0, stringSize.width, 52)];
    if ([dic[@"newflg"] isEqualToString:@"1"]) {
        CGRect newImageViewCGRect = CGRectMake(cell.nameLabel.frame.origin.x + cell.nameLabel.frame.size.width + 20, 17, 25, 10);
        cell.imageNewView = [[UIImageView alloc] initWithFrame:newImageViewCGRect];
        cell.imageNewView.image = [UIImage imageNamed:@"new@2x.png"];
        [cell.contentView addSubview:cell.imageNewView];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.3 animations:^{
        self.footView.alpha=0;
    }];
    if(self.partType == 1){
        PartOneSecondColumnTableViewController *second = [[PartOneSecondColumnTableViewController alloc]init];
        NSDictionary *dic = self.catArray[indexPath.row];
        //NSLog(@"%@",dic);
        second.navigationItem.title = dic[@"ename"];
    
        second.leval = dic[@"evalue"];
    //second.navigationItem.title = self.categoryDic[indexPath.row];
        [self.navigationController pushViewController:second animated:YES];
    }else if(self.partType == 23){
        PartTwoSecondColumnTableViewController *second = [[PartTwoSecondColumnTableViewController alloc] init];
        NSDictionary *dic = self.catArray[indexPath.row];
        NSLog(@"%@",dic);
        second.navigationItem.title = dic[@"ename"];
        second.evalue = dic[@"evalue"];
        second.cateDic = dic;
        [self.navigationController pushViewController:second animated:YES];
    }
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
#pragma mark - 自定义方法
- (IBAction)backAction:(UIBarButtonItem *)sender {
    //弹出提示信息
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"真的要注销吗" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *destuctiveBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //返回上一级
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
    [alert addAction:destuctiveBtn];
    [alert addAction:cancelBtn];
    [self presentViewController:alert animated:YES completion:nil];
}
//获取网络请求返回的JSON转换为ARRAY
-(void)getCategorys{
    NSString *urlStr = @"http://test.benniaoyasi.cn/api.php";
    NSString *mobile = [self userInfo];
    NSString *param = [NSString stringWithFormat:@"m=api&c=category&a=listcategory&appid=1&pid=1&mobile=%@&version=4.4.7",mobile];
    getNetworkQuest *quest = [[getNetworkQuest alloc] init];
    [quest sendGetQuest2:urlStr param:param];
    NSData *data = quest.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([dic[@"ecode"] isEqualToString:@"0"]) {
        self.categoryDic = dic[@"edata"];
        self.catArray = [dic objectForKey:@"edata"];
        NSLog(@"%@",self.catArray[0]);
    }else{
        alertMessageViewController *alert = [alertMessageViewController alertMessage:@"错误信息" message:@"返回错误"];
        [alert presentViewController:self animated:YES completion:nil];
    }
    
}
-(void)getPar1Cgatgorys:(NSString *)urlStr param:(NSString *)param{
    getNetworkQuest *quest = [[getNetworkQuest alloc] init];
    [quest sendGetQuest2:urlStr param:param];
    NSData *data = quest.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if([dic[@"ecode"] isEqualToString:@"0"]){
        self.categoryDic = dic[@"edata"];
        self.catArray = [dic objectForKey:@"edata"];
    }else{
        alertMessageViewController *alert = [alertMessageViewController alertMessage:@"错误信息" message:@"网络请求失败"];
        [alert presentViewController:self animated:YES completion:nil];
    }
}
//读取用户配置信息
-(NSString *)userInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *mobile = [defaults valueForKey:@"username"];
    return mobile;
}
//去掉tableView不显示内容的cell
-(void)clearExtraLine:(UITableView *)tableView{
    //创建一个view
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-40, [UIScreen mainScreen].bounds.size.width, 40)];
    self.footView.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    
    self.part1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.footView.frame.size.width/2, self.footView.frame.size.height-5)];

    [self.part1 setTitle:@"Part 1" forState:UIControlStateNormal];
    [self.part1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.part23 = [[UIButton alloc] initWithFrame:CGRectMake(self.part1.frame.size.width, 0, self.footView.frame.size.width/2, self.footView.frame.size.height-5)];
    [self.part23 setTitle:@"Part 1&2" forState:UIControlStateNormal];
    [self.part23 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.part1 addTarget:self action:@selector(part1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.part23 addTarget:self action:@selector(part23Click) forControlEvents:UIControlEventTouchUpInside];
    
    self.partBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.part1.frame.size.height, self.part1.frame.size.width, 5)];
    self.partBottomView.backgroundColor = [UIColor redColor];
    [self.footView addSubview:self.partBottomView];
    [self.footView addSubview:self.part1];
    [self.footView addSubview:self.part23];
    self.win = [[UIApplication sharedApplication] keyWindow];
    [self.win addSubview:self.footView];
    [self.tableView setTableFooterView:view];
}
-(void)part1Click{
    [self.part23 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.part1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        [self.partBottomView setFrame:CGRectMake(0, self.part1.frame.size.height, self.part1.frame.size.width, 5)];
    }];
    NSString *urlStr = @"http://test.benniaoyasi.cn/api.php";
    NSString *mobile = [self userInfo];
    NSString *param = [NSString stringWithFormat:@"m=api&c=category&a=listcategory&appid=1&pid=1&mobile=%@&version=4.4.7",mobile];
    [self getPar1Cgatgorys:urlStr param:param];
    self.partType = 1;
    [self.tableView reloadData];
}
-(void)part23Click{
    /*
     http://test.benniaoyasi.cn/api.php?m=api&c=category&a=listcategory&appid=1&pid=41&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C
     http://test.benniaoyasi.cn/api.php?c=content&a=listcontent_part2_3&mobile=18600562546&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C&leval=People&appid=1&pageindex=0&pagenum=10
     */
    NSString *urlStr = @"http://test.benniaoyasi.cn/api.php";
    NSString *mobile = [self userInfo];
    NSString *param = [NSString stringWithFormat:@"m=api&c=category&a=listcategory&appid=1&pid=41&mobile=%@&version=4.4.9&devtype=ios",mobile];
    [self getPar1Cgatgorys:urlStr param:param];
    [self.part23 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.part1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        [self.partBottomView setFrame:CGRectMake(self.part23.frame.origin.x, self.partBottomView.frame.origin.y, self.partBottomView.frame.size.width, self.partBottomView.frame.size.height)];
    }];
    self.partType = 23;
    [self.tableView reloadData];
    
}
@end
