//
//  IWStatusCell.m
//  weibo 16
//
//  Created by 何建新 on 16/1/27.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWStatusCell.h"
#import "IWStatus.h"
#import "IWStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "IWUser.h"
#import "IWStatusToolBar.h"
#import "IWStatusPhotos.h"
@interface IWStatusCell()
@property(nonatomic, weak)UIView *originalView;
@property(nonatomic, weak)UIImageView *headImage;
@property(nonatomic, weak)UILabel *contentLabel;
@property(nonatomic, weak)UILabel *nameLabel;
@property(nonatomic ,weak)UILabel *createLabel;
@property(nonatomic ,weak)UILabel *sourceLabel;
@property(nonatomic, weak) IWStatusPhotos *photoView;
//微博工具条
@property(nonatomic, weak) IWStatusToolBar *statusToolBar;
//转发微博整体view
@property(nonatomic, weak) UIView *retweetView;
//转发微博的内容
@property(nonatomic, weak) UILabel *retweetContentLabel;
@property(nonatomic, weak) IWStatusPhotos *retweetPhoto;

@end
@implementation IWStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    IWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[IWStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *spliteView = [[UIView alloc] init];
        spliteView.backgroundColor = RGB(240, 240, 240);
        spliteView.size = CGSizeMake(SCREENW, 10);
        [self.contentView addSubview:spliteView];
        //添加子空间
        [self setupOriginalView];
        
//        //1.添加头像
//        UIImageView *headImage = [[UIImageView alloc] init];
//        [self.contentView addSubview:headImage];
//        self.headImage = headImage;
//        //2.添加昵称
//        UILabel *nameLabel = [[UILabel alloc] init];
//        nameLabel.font = SYS_FONT(NAME_LABEL_SIZE);
//        [self.contentView addSubview:nameLabel];
//        self.nameLabel = nameLabel;
//        
//        //3.添加原创微博的内容
//        UILabel *contentLabel = [[UILabel alloc] init];
//        contentLabel.numberOfLines = 0;
//        contentLabel.font = SYS_FONT(CONTENT_LABEL_SIZE);
//        [self.contentView addSubview:contentLabel];
//        self.contentLabel = contentLabel;
//        
//        //4.添加时间的label
//        UILabel *createLabel = [[UILabel alloc] init];
//        createLabel.font = SYS_FONT(CREATE_TIME_SIZE);
//        [self.contentView addSubview:createLabel];
//        self.createLabel = createLabel;
//        
//        //5.添加来源的label
//        UILabel *sourceLabel = [[UILabel alloc] init];
//        sourceLabel.font = SYS_FONT(CREATE_TIME_SIZE);
//        [self.contentView addSubview:sourceLabel];
//        self.sourceLabel = sourceLabel;
//        
//        //添加图片
//        IWStatusPhotos *photoView = [[IWStatusPhotos alloc]init];
//        [self.contentView addSubview:photoView];
//        self.photoView = photoView;
        
        IWStatusToolBar *statusToolBar = [[IWStatusToolBar alloc] init];
        [self.contentView addSubview:statusToolBar];
        self.statusToolBar = statusToolBar;
        //设置转发微博内容
        [self setupRetWeetView];
    }
    
    return self;
}
//设置原创微博的内容
-(void)setupOriginalView{
    
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    //1.添加头像
    UIImageView *headImage = [[UIImageView alloc] init];
    [originalView addSubview:headImage];
    self.headImage = headImage;
    //2.添加昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = SYS_FONT(NAME_LABEL_SIZE);
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //3.添加原创微博的内容
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = SYS_FONT(CONTENT_LABEL_SIZE);
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //4.添加时间的label
    UILabel *createLabel = [[UILabel alloc] init];
    createLabel.font = SYS_FONT(CREATE_TIME_SIZE);
    [originalView addSubview:createLabel];
    self.createLabel = createLabel;
    
    //5.添加来源的label
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = SYS_FONT(CREATE_TIME_SIZE);
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    //添加图片
    IWStatusPhotos *photoView = [[IWStatusPhotos alloc]init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
}


//设置转发微博的view及子控件
-(void)setupRetWeetView{
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = RGB(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    //转发微博的内容
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = SYS_FONT(CONTENT_LABEL_SIZE);
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    //转发微博的配图
    IWStatusPhotos *retweetPhoto = [[IWStatusPhotos alloc] init];
    [retweetView addSubview:retweetPhoto];
    self.retweetPhoto = retweetPhoto;
}
-(void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    self.originalView.frame = statusFrame.originalViewF;
    //1.给子控件设置大小
    self.headImage.frame = statusFrame.headImageF;
    NSString *userProfile =  statusFrame.status.user.profile_image_url;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:userProfile] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = statusFrame.status.user.screen_name;
    
    self.createLabel.text = statusFrame.status.created_at;
    self.createLabel.frame = statusFrame.createLabelF;
    
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = statusFrame.status.text;
    
    self.sourceLabel.text = statusFrame.status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    if (statusFrame.status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.pic_url = statusFrame.status.pic_urls;
        self.photoView.frame = statusFrame.photoViewF;
    }else{
        self.photoView.hidden = YES;
    }
    //判断是否有转发微博
    if (statusFrame.status.retweeted_status) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@:%@",statusFrame.status.retweeted_status.user.screen_name,statusFrame.status.retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        //是否有转发微博的图片
        if (statusFrame.status.retweeted_status.pic_urls) {
            self.retweetPhoto.hidden = NO;
            self.retweetPhoto.frame = statusFrame.retweetPhotoF;
            self.retweetPhoto.pic_url = statusFrame.status.retweeted_status.pic_urls;
        }else{
            self.retweetPhoto.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    self.statusToolBar.frame = statusFrame.statusToolBarF;
    
    self.statusToolBar.status = statusFrame.status;
    
    //2.给子控件设置数据
    //self.textLabel.text = statusFrame.status.text;
}


@end
