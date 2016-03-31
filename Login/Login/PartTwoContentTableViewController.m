//
//  PartTwoContentTableViewController.m
//  Login
//
//  Created by 何建新 on 16/3/29.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoContentTableViewController.h"
#import "getNetworkQuest.h"
@interface PartTwoContentTableViewController ()
@property(nonatomic, copy)NSDictionary *contentInfo;
@property(nonatomic, assign) NSInteger num;
@property(nonatomic, assign) NSInteger s;
@property(nonatomic, assign) NSInteger r;
@property(nonatomic, assign) int param;
@property(nonatomic, copy)UITextView *textView;
@property(nonatomic, assign) BOOL isHidden;
@property(nonatomic, assign) float chh;
@end
/*
 http://test.benniaoyasi.cn/api.php?m=api&c=content&a=contentinfo&appid=1&mobile=18600562546&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C&id=518
*/
@implementation PartTwoContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = item;
    NSString *url = @"http://test.benniaoyasi.cn/api.php";
    NSString *param = [NSString stringWithFormat:@"m=api&c=content&a=contentinfo&appid=1&mobile=%@&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C&id=%@",self.mobile,self.cateDic[@"id"]];
    getNetworkQuest *quest = [[getNetworkQuest alloc]init];
    [quest sendGetQuest2:url param:param];
    NSData *data = quest.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableDictionary *contentDic = [NSMutableDictionary dictionary];
    if ([dic[@"ecode"] isEqualToString:@"0"]) {
        for (NSDictionary *d in dic[@"edata"]) {
            [contentDic addEntriesFromDictionary:d];
        }
    }
    self.contentInfo = contentDic;
    NSLog(@"%@",self.contentInfo);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger count = 0;
    if (section == 2) {
        count = [self.contentInfo[@"part3List"] count];
    }else if(section == 1){
        count = [self.contentInfo[@"part2List"] count];
    }else{
        count = 1;
    }
    self.num = section;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.textLabel.numberOfLines = 0;
    NSLog(@"%f",cell.frame.size.width);
    NSString *cellText = nil;
    NSString *cellChText = nil;
    if (indexPath.section == 0) {
        cellText = self.contentInfo[@"title"];
        UIFont *strFont = cell.textLabel.font;
        CGSize strSize = [cellText boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
        UITextView *contentText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, strSize.height)];
        contentText.text = cellText;
        contentText.scrollEnabled = NO;
        contentText.editable = NO;
        //不可选择
        contentText.userInteractionEnabled = NO;
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, contentText.frame.size.height, contentText.frame.size.width, 40)];
        
        UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-10-33, 5, 33, 33)];
        UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(playBtn.frame.origin.x-10-33, 5, 33, 33)];
        [playBtn setImage:[UIImage imageNamed:@"play_press.png"] forState:UIControlStateNormal];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin_press.png"] forState:UIControlStateNormal];
        [btnView addSubview:playBtn];
        [btnView addSubview:luyinBtn];
        
        [cell.contentView addSubview:contentText];
        
        [cell.contentView addSubview:btnView];
        NSLog(@"%f",contentText.frame.size.height+btnView.frame.size.height);
    }else if(indexPath.section == 1){
        cellText = self.contentInfo[@"part2List"][indexPath.row][@"p2_english"];
        UIFont *strFont = [UIFont fontWithName:@"Arial" size:14];
        CGSize strSize = [cellText boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
        //创建一个文本编辑器
        UITextView *contentText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, strSize.height-15)];
        //允许用户交互
        contentText.userInteractionEnabled = NO;
        //创建一个手势并设置监听方法
       /* UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showChinaese:)];

        //contentText.tag = i;
        UIView *tagView = [tapGesture view];
        tagView.tag = (int)indexPath.section;
        NSLog(@"%d",tagView.tag);
        //给创建的view添加手势识别
        [contentText addGestureRecognizer:tapGesture];*/
        contentText.text = cellText;
        //不可滚动
        contentText.scrollEnabled = NO;
        //不可编辑
        contentText.editable = NO;
        //不可选择
        //contentText.userInteractionEnabled = NO;
        cellChText = self.contentInfo[@"part2List"][indexPath.row][@"p2_chines"];
        CGSize strChSize = [cellChText boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
        UITextView *chineseText = [[UITextView alloc] initWithFrame:CGRectMake(0, contentText.frame.size.height+45, contentText.frame.size.width, strChSize.height)];
        //chineseText.hidden = YES;
        CGFloat btnH = 0.0;
        chineseText.hidden = YES;
        if(self.s == indexPath.section && self.r == indexPath.row){
            if (self.chh == 0.0) {
                chineseText.hidden = YES;
                self.chh = chineseText.frame.size.height;
            }else{
                chineseText.hidden = NO;
                self.chh = 0.0;
                btnH = strChSize.height;
            }
        }
        chineseText.backgroundColor = [UIColor redColor];
        chineseText.text = cellChText;
        chineseText.scrollEnabled = NO;
        chineseText.editable = NO;
        NSString *tag = [NSString stringWithFormat:@"%ld%ld",(long)[indexPath section],(long)[indexPath row]];
        chineseText.tag = (int)tag;
        
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, contentText.frame.size.height, contentText.frame.size.width, 40)];
        
        UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-10-33, 5, 33, 33)];
        UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(playBtn.frame.origin.x-10-33, 5, 33, 33)];
        [playBtn setImage:[UIImage imageNamed:@"play_press.png"] forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(showChinaese:) forControlEvents:UIControlEventTouchUpInside];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin_press.png"] forState:UIControlStateNormal];
        [btnView addSubview:playBtn];
        [btnView addSubview:luyinBtn];
        
        
        
        
        [cell.contentView addSubview:chineseText];
        [cell.contentView addSubview:contentText];
        [cell.contentView addSubview:btnView];
    }

    return cell;
}
-(void)showChinaese:(UITapGestureRecognizer *) tapGesture{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)tapGesture;
    //NSLog(@"%d",[tap view].tag);
    NSLog(@"点击了播放按钮");
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.s = indexPath.section;
    self.r = indexPath.row;
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float enHeight = 0.0;
    float cnHeight = 0.0;
    if(indexPath.section == 0){
        enHeight = [self getStringSize:self.contentInfo[@"title"]];
        cnHeight = 0.0;
    }else if(indexPath.section == 1){
        enHeight = [self getStringSize:self.contentInfo[@"part2List"][indexPath.row][@"p2_english"]];
        if(indexPath.row == self.r){
            NSLog(@"%f++--++--",self.chh);
            if (self.chh == 0.0) {
                cnHeight = [self getStringSize:self.contentInfo[@"part2List"][indexPath.row][@"p2_chines"]];
                self.chh = cnHeight;
                NSLog(@"显示啦------%f",cnHeight);
            }else{
                cnHeight = 0.0;
                self.chh = cnHeight;
                NSLog(@"隐藏了。应该是0.0-------%f",cnHeight);
            }

        }else{
            
        }
    }
    
    return enHeight+cnHeight+44;
}
-(float)getStringSize:(NSString *)string{
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:14];
   // CGSize strSize = [string sizeWithAttributes:@{NSFontAttributeName:strFont}];
    CGSize strSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    return strSize.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = nil;
    if (section == 2) {
        headerTitle = @"Part3List";
    }else if(section == 1){
        headerTitle = @"Part2List";
    }else{
        headerTitle = @"问题";
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    headerView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, 100, 42)];
    //titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = headerTitle;
    
    
    UIView *borderTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 1)];
    borderTop.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    UIView *borderBottom = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-1, headerView.frame.size.width, 1)];
    borderBottom.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [headerView addSubview:titleLabel];
    [headerView addSubview:borderTop];
    [headerView addSubview:borderBottom];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
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
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
