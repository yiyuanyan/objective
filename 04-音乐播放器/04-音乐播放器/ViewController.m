//
//  ViewController.m
//  04-音乐播放器
//
//  Created by 何建新 on 16/1/17.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "CZMusic.h"
#import "CZMusicTool.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property(nonatomic, strong)NSArray *allMusics;
//记录当前播放第几首
@property(nonatomic, assign)NSInteger currentMusicIndex;
- (IBAction)playMusic:(UIButton *)sender;
- (IBAction)preMusic:(UIButton *)sender;
- (IBAction)nextMusic:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
//定时器
@property(nonatomic, strong)NSTimer *mainTimer;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
//总时间
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
//专辑
@property (weak, nonatomic) IBOutlet UILabel *zhuanji;
//名称
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

@property (weak, nonatomic) IBOutlet UIImageView *zhuanjiImageView;
@property (weak, nonatomic) IBOutlet UILabel *lrcLable;



@end

@implementation ViewController


-(NSArray *)allMusics
{
    if (!_allMusics) {
        _allMusics = [CZMusic objectArrayWithFilename:@"mlist.plist"];
    }
    return _allMusics;
}

- (IBAction)playMusic:(UIButton *)sender {
    //播放状态
    if (sender.selected == NO) {
        //获取当前要播放的歌曲
        CZMusic *music = self.allMusics[_currentMusicIndex];
        //播放
        [[CZMusicTool shareMusicTool]playWithMusicFileName:music.mp3];
        //一秒更新一次,需要定时器
        _mainTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(mainUpdateInfo) userInfo:nil repeats:YES];
        //更新固定信息(每切换一首歌才需要跟新)
        [self updateMusicInfo];
    }else{
        //暂停状态
        [[CZMusicTool shareMusicTool]pause];
        //停止定时器
        [_mainTimer invalidate];
        
    }
    sender.selected = !sender.selected;
}
//更新固定信息
-(void)updateMusicInfo
{
    
    //总时长
    NSTimeInterval currentTime = [[CZMusicTool shareMusicTool]duration];
    NSInteger min = currentTime / 60;
    NSInteger sec = (NSInteger)currentTime % 60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
    //专辑名称
    CZMusic *music = self.allMusics[_currentMusicIndex];
    self.zhuanji.text = music.zhuanji;
    //名称
    self.singerLabel.text = music.singer;
    //专辑图片
    self.zhuanjiImageView.image = [UIImage imageNamed:music.image];
    //背景图片
    self.bgImage.image = [UIImage imageNamed:music.image];
    //title
    self.title = music.name;
}
//定时器方法,更新进度条和时间
-(void)mainUpdateInfo
{
    //时时更新进度条
    NSTimeInterval currentTime = [[CZMusicTool shareMusicTool]currentTime];
    NSInteger min = currentTime / 60;
    NSInteger sec = (NSInteger)currentTime % 60;
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
    
    //进度 = 当前时间 / 总时间.0
    self.progressView.progress = [[CZMusicTool shareMusicTool]progress];
    //当前时间
}

- (IBAction)preMusic:(UIButton *)sender {
    //改变当前播放的索引,然后调用播放方法
    _currentMusicIndex = _currentMusicIndex == 0 ? self.allMusics.count - 1 : _currentMusicIndex - 1;
    self.playBtn.selected = NO;
    [self playMusic:self.playBtn];
    
}

- (IBAction)nextMusic:(UIButton *)sender {
    _currentMusicIndex = _currentMusicIndex == self.allMusics.count - 1 ? 0 : _currentMusicIndex + 1;
    self.playBtn.selected = NO;
    [self playMusic:self.playBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _currentMusicIndex = 0;

    //背景毛玻璃效果
    //添加一个UIToolBar
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [self.bgImage addSubview:toolBar];
    
    [toolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.bgImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    //添加约束
    NSArray *conV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[toolBar]-margin-|" options:0 metrics:@{@"margin":@0} views:@{@"toolBar":toolBar}];
    NSArray *conH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[toolBar]-margin-|" options:0 metrics:@{@"margin":@0} views:@{@"toolBar":toolBar}];
    [self.bgImage addConstraints:conH];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
