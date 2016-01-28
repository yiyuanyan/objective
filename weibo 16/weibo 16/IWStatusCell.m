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
@interface IWStatusCell()
@property(nonatomic, weak)UIImageView *headImage;
@property(nonatomic, weak)UILabel *contentLabel;
@property(nonatomic, weak)UILabel *nameLabel;
@property(nonatomic ,weak)UILabel *createLabel;
@property(nonatomic ,weak)UILabel *sourceLabel;
@property(nonatomic, weak) UIImageView *photoView;
//微博工具条
@property(nonatomic, weak) IWStatusToolBar *statusToolBar;
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
        //添加子空间
        //1.添加头像
        UIImageView *headImage = [[UIImageView alloc] init];
        [self.contentView addSubview:headImage];
        self.headImage = headImage;
        //2.添加昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = SYS_FONT(NAME_LABEL_SIZE);
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //3.添加原创微博的内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = SYS_FONT(CONTENT_LABEL_SIZE);
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        //4.添加时间的label
        UILabel *createLabel = [[UILabel alloc] init];
        createLabel.font = SYS_FONT(CREATE_TIME_SIZE);
        [self.contentView addSubview:createLabel];
        self.createLabel = createLabel;
        
        //5.添加来源的label
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = SYS_FONT(CREATE_TIME_SIZE);
        [self.contentView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        //添加图片
        UIImageView *photoView = [[UIImageView alloc]init];
        [self.contentView addSubview:photoView];
        self.photoView = photoView;
        
        IWStatusToolBar *statusToolBar = [[IWStatusToolBar alloc] init];
        [self.contentView addSubview:statusToolBar];
        self.statusToolBar = statusToolBar;
        
    }
    
    return self;
}

-(void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
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
        NSString *imageUrlStr = self.statusFrame.status.thumbnail_pic;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.frame = statusFrame.photoViewF;
    }else{
        self.photoView.hidden = YES;
    }
    
    self.statusToolBar.frame = statusFrame.statusToolBarF;
    
    //2.给子控件设置数据
    //self.textLabel.text = statusFrame.status.text;
}

@end
