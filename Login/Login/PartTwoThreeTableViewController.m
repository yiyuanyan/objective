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
#import "PartTwoThreeTableViewCell.h"

#import <AVFoundation/AVFoundation.h>
static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;
#define kScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])

@interface PartTwoThreeTableViewController ()<AVAudioPlayerDelegate,AVAudioRecorderDelegate>
@property(nonatomic, copy) NSDictionary *conDic;
@property(nonatomic, copy)NSMutableArray *part2List;
@property(nonatomic, copy)NSMutableArray *part3List;
//接收partTwoThreeTableViewCell中的按钮View
@property(nonatomic, strong)UIView *btnView;
@property(nonatomic, strong)NSIndexPath *luyinAnimationIndexPath;
@property(nonatomic, strong)AVAudioPlayer *player;
@property(nonatomic, strong)AVAudioRecorder *recorder;
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
    NSLog(@"%@",self.conDic[@"part2List"]);
    _part2List = [NSMutableArray array];
    for (NSDictionary *d in self.conDic[@"part2List"]) {
        TMContent *TM = [[TMContent alloc] init];
        TM.english = d[@"p2_english"];
        TM.chines = d[@"p2_chines"];
        TM.audio = d[@"p2_audio"];
        TM.cellId = [NSString stringWithFormat:@"part2List%@-%@",d[@"yid"],d[@"id"]];
        [_part2List addObject:TM];
        
    }
    _part3List = [NSMutableArray array];
    for (NSDictionary *d in self.conDic[@"part3List"]) {
        TMContent *TM = [[TMContent alloc] init];
        TM.english = d[@"p2_english"];
        TM.chines = d[@"p2_chines"];
        TM.audio = d[@"p2_audio"];
        TM.cellId = [NSString stringWithFormat:@"part3List%@-%@",d[@"yid"],d[@"id"]];
        [_part3List addObject:TM];
        
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
    TMContent *TM = nil;
    if(indexPath.section == 1){
        TM = self.part2List[indexPath.row];
    }else if(indexPath.section == 2){
        TM = self.part3List[indexPath.row];
    }
    PartTwoThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if(cell == nil){
        cell = [[PartTwoThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }else{
        while([cell.contentView.subviews lastObject] != nil){
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if(indexPath.section == 0){
        [cell createTitleCell:self.conDic[@"title"] TM:TM indexPath:indexPath];
    }else if(indexPath.section == 1){
        [cell createPart2ListCell:TM indexPath:indexPath];
    }else if(indexPath.section == 2){
        [cell createPart2ListCell:TM indexPath:indexPath];
    }
    cell.clickButton = ^(NSIndexPath* indexPath){
        [self clickBtn:indexPath];
    };
    cell.luyinButton = ^(NSString *cellId){
        [self luyinBtn:cellId];
    };
    cell.luyinAnimation = ^(UIView *btnView, NSIndexPath *indexPath){
        [self luyinAni:btnView indexPath:indexPath];
    };
    cell.luyinPlayBtn = ^(NSString *luyinFilePath,NSIndexPath *indexPath){
        [self luyinPlay:luyinFilePath indexPath:indexPath];
        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//录音播放
-(void)luyinPlay:(NSString *)luyinFilePath indexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",luyinFilePath);
    [self.player stop];
    NSURL *url = [NSURL URLWithString:luyinFilePath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //进行缓存
    [self.player prepareToPlay];
    //指定代理为自身
    self.player.delegate = self;
    //指定播放音量
    self.player.volume = 8;
    //开始播放
    [self.player play];
    
    
}
-(void)luyinAni:(UIView *)btnView indexPath:(NSIndexPath *)indexPath{
    self.btnView = btnView;
    self.luyinAnimationIndexPath = indexPath;
    NSMutableArray *arrayM = [NSMutableArray array];
    for(int i=1; i < 16; i++){
        [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"recording%d",i]]];
    }
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-103, 5, 33, 33)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
    [imageView setAnimationImages:arrayM];
    [imageView setAnimationRepeatCount:0];
    [imageView setAnimationDuration:arrayM.count*0.03];
    [imageView startAnimating];
    //给animationView添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopluyin:)];
    [animationView addGestureRecognizer:tapGesture];
    [animationView addSubview:imageView];
    [tapGesture setNumberOfTapsRequired:1];
    [btnView addSubview:animationView];
}
//停止录音
-(void)stopluyin:(UITapGestureRecognizer *)gesture{
    //录音停止
    [self.recorder stop];
    [[self.btnView.subviews lastObject] removeFromSuperview];
    //将cell的indexPath数组化
    NSArray *indexArray = [NSArray arrayWithObject:self.luyinAnimationIndexPath];
    //刷新指定indexPath的cell
    [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
}
//开始录音
-(void)luyinBtn:(NSString *)cellId{
    [self.player stop];
    //文件名称
    NSString *fileName = [NSString stringWithFormat:@"%@.caf",cellId];
    //整体路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    //设置录音参数
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
    setting[AVSampleRateKey] = @(8000.0);
    setting[AVNumberOfChannelsKey] = @(1);
    setting[AVLinearPCMBitDepthKey] = @(8);
    //创建录音对象
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:nil];
    //允许监听
    self.recorder.meteringEnabled = YES;
    //开始录音
    [self.recorder record];
}

-(void)clickBtn:(NSIndexPath *)indexPath{
    //NSLog(@"终于能点击按钮啦。%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    TMContent *TM = nil;
    if(indexPath.section == 1){
        TM = self.part2List[indexPath.row];
    }else if(indexPath.section == 2){
        TM = self.part3List[indexPath.row];
    }
    [self playMp3:TM.audio];
}
//播放音频
-(void)playMp3:(NSString *)url{
    [self.player stop];
    //将字符串URL化
    NSURL *pathUrl = [NSURL URLWithString:url];
    //将URLDATA
    NSData *audioData = [NSData dataWithContentsOfURL:pathUrl];
    //注：AVAudioPlayer必须进行全局属性声明
    self.player = [[AVAudioPlayer alloc] initWithData:audioData error:nil];
    //进行缓存
    [self.player prepareToPlay];
    //指定代理为自身
    self.player.delegate = self;
    //指定播放音量
    self.player.volume = 8;
    //开始播放
    [self.player play];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMContent *TM = nil;
    CGFloat enHeight = 0.0;
    CGFloat chHeight = 0.0;
    if(indexPath.section == 0){
        CGFloat titleHeight = [self getStringHeight:self.conDic[@"title"]]+50;
        return titleHeight;
    }else if(indexPath.section == 1){
        TM = self.part2List[indexPath.row];
        enHeight = [self getStringHeight:self.conDic[@"part2List"][indexPath.row][@"p2_english"]]+5;
        chHeight = [self getStringHeight:self.conDic[@"part2List"][indexPath.row][@"p2_chines"]]+5;
    }else if(indexPath.section == 2){
        TM = self.part3List[indexPath.row];
        enHeight = [self getStringHeight:self.conDic[@"part3List"][indexPath.row][@"p2_english"]]+5;
        chHeight = [self getStringHeight:self.conDic[@"part3List"][indexPath.row][@"p2_chines"]]+5;
    }
    //NSLog(@"%@",self.conDic[@"part2List"][indexPath.row]);
    
    
    if (TM.state) {
        return enHeight+chHeight+50;
    }else{
        return enHeight+45;
    }
    return 100;
    
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
    if(indexPath.section == 1){
        TMContent *TM = self.part2List[indexPath.row];
        TM.state = !TM.state;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if(indexPath.section == 2){
        TMContent *TM = self.part3List[indexPath.row];
        TM.state = !TM.state;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
