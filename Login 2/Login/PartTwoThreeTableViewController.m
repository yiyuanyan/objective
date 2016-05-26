//
//  PartTwoThreeTableViewController.m
//  Login
//
//  Created by 何建新 on 16/4/6.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoThreeTableViewController.h"
#import "getUserInfo.h"
#import "getNetworkQuest.h"
#import "TMContent.h"
#import "playBlockButton.h"
#import <AVFoundation/AVFoundation.h>
#define kScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
typedef void (^ButtonBlock)(NSIndexPath *indexPath);
@interface PartTwoThreeTableViewController ()
@property(nonatomic, copy) NSDictionary *conDic;
@property(nonatomic, copy)NSMutableArray *part2List;
@property(nonatomic, copy)NSMutableArray *part3List;
@property(nonatomic, strong)AVAudioPlayer *player;
@property(nonatomic, copy)ButtonBlock buttonBlock;
@end

@implementation PartTwoThreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    getUserInfo *user = [[getUserInfo alloc]init];
    self.mobile = [user getUser];
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
    
    self.conDic = contentDic;
    // NSLog(@"%@",self.conDic[@"part2List"]);
    _part2List = [NSMutableArray array];
    for (NSDictionary *d in self.conDic[@"part2List"]) {
        TMContent *TM = [[TMContent alloc] init];
        TM.english = d[@"p2_english"];
        TM.chines = d[@"p2_chines"];
        TM.audio = d[@"p2_audio"];
        [_part2List addObject:TM];
        //NSLog(@"%@",TM.p2_english);
    }
    _part3List = [NSMutableArray array];
    for (NSDictionary *d in self.conDic[@"part3List"]) {
        TMContent *TM = [[TMContent alloc] init];
        TM.english = d[@"p2_english"];
        TM.chines = d[@"p2_chines"];
        TM.audio = d[@"p2_audio"];
        [_part3List addObject:TM];
        //NSLog(@"%@",TM.p2_english);
    }
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
    if(section == 0){
        return 1;
    }else if(section == 1){
        return self.part2List.count;
    }else{
        return self.part3List.count;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }else{
        while([cell.contentView.subviews lastObject] != nil){
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if(indexPath.section == 0){
        UIView *cellView = [self cellView:self.conDic[@"title"] chString:nil indexPath:indexPath];
        [cell.contentView addSubview:cellView];
    }
    if(indexPath.section == 1){
        TMContent *TM = self.part2List[indexPath.row];
        UIView *cellView = [self cellView:TM.english chString:TM.chines indexPath:indexPath];
        [cell.contentView addSubview:cellView];
    }
    if(indexPath.section == 2){
        TMContent *TM = self.part3List[indexPath.row];
        UIView *cellView = [self cellView:TM.english chString:TM.chines indexPath:indexPath];
        [cell.contentView addSubview:cellView];
    }
    // Configure the cell...
    
    //取消cell的点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//创建cell内的各个view
-(UIView *)cellView:(NSString *)enString chString:(NSString *)chString indexPath:(NSIndexPath *)indexPath{
    
    //英文字体高度
    CGFloat enStringHeight = [self getStringHeight:enString];
    //中文字体高度
    CGFloat chStringHeight = [self getStringHeight:chString];
    //英文Label
    UILabel *enLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth-10, enStringHeight+10)];
    enLabel.font = [UIFont systemFontOfSize:14];
    enLabel.numberOfLines = 0;
    enLabel.text = enString;
    
    //录音播放按钮view&btn
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, enLabel.frame.size.height, kScreenWidth, 44)];
    
    UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-43, 5, 33, 33)];
    [playBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
//    [playBtn addTarget:self action:@selector(playMp3:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-86, 5, 33, 33)];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateHighlighted];
    [btnView addSubview:playBtn];
    [btnView addSubview:luyinBtn];
    UIView *chView = [[UIView alloc] init];
    //中文View&Label
    if(indexPath.section != 0 && chString != nil){
        TMContent *TM = nil;
        if(indexPath.section == 1){
            TM = self.part2List[indexPath.row];
        }else{
            TM = self.part3List[indexPath.row];
        }
        
        UILabel *chLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth-10, chStringHeight)];
        chLabel.font = [UIFont systemFontOfSize:14];
        chLabel.numberOfLines = 0;
        chLabel.text = chString;
        chLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //UIView *chView = [[UIView alloc] initWithFrame:CGRectMake(0, enLabel.frame.size.height+btnView.frame.size.height, kScreenWidth, chLabel.frame.size.height+10)];
        [chView setFrame:CGRectMake(0, enLabel.frame.size.height+btnView.frame.size.height, kScreenWidth, chLabel.frame.size.height+10)];
        chView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        chView.hidden = !TM.state;
        [chView addSubview:chLabel];
    }
    //大View，包含所有元素
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, enLabel.frame.size.height+btnView.frame.size.height+chView.frame.size.height)];
    [bgView addSubview:enLabel];
    [bgView addSubview:btnView];
    [bgView addSubview:chView];
    return bgView;
}
-(void)playMp3:(id)sender{
    if(self.buttonBlock){
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return [self getStringHeight:self.conDic[@"title"]]+54;
    }else if(indexPath.section == 1){
        TMContent *TM = self.part2List[indexPath.row];
        if(!TM.state){
            return [self getStringHeight:TM.english]+54;
        }else{
            return [self getStringHeight:TM.english]+54+[self getStringHeight:TM.chines]+10;
        }
        
    }else{
        TMContent *TM = self.part3List[indexPath.row];
        if(!TM.state){
            return [self getStringHeight:TM.english]+54;
        }else{
            return [self getStringHeight:TM.english]+54+[self getStringHeight:TM.chines]+10;
        }
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return @"问题";
    }else if(section == 1){
        return @"part2List";
    }else{
        return @"part3List";
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        TMContent *TM = self.part2List[indexPath.row];
        TM.state = !TM.state;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if(indexPath.section == 2){
        TMContent *TM = self.part3List[indexPath.row];
        TM.state = !TM.state;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else{
    
    }
}
//根据字符串返回高度
-(CGFloat)getStringHeight:(NSString *)string{
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect strRect = [string boundingRectWithSize:CGSizeMake(kScreenWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return CGRectGetHeight(strRect);
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
