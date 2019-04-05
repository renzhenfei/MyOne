//
//  MLBMusicContentCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/30.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBMusicContentCell.h"
#import "MLBMusicDetail.h"

NSString *const KMLMusicContentCellID = @"KMLMusicContentCellID";

@interface MLBMusicContentCell()

@property (strong, nonatomic) UIImageView *coverView;
@property (strong, nonatomic) UIView *authorView;
@property (strong, nonatomic) UIImageView *authorAvatarView;
@property (strong, nonatomic) UILabel *authorNameLabel;
@property (strong, nonatomic) UIImageView *firstPublishView;
@property (strong, nonatomic) UILabel *authorDescLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIButton *musicControlButton;
@property (strong, nonatomic) UILabel *contentTypeLabel;
@property (strong, nonatomic) UIButton *storyButton;
@property (strong, nonatomic) UIButton *lyricButton;
@property (strong, nonatomic) UIButton *aboutButton;
@property (strong, nonatomic) UITextView *contentTextView;
@property (strong, nonatomic) UIButton *praiseButton;
@property (strong, nonatomic) UIButton *commentButton;
@property (strong, nonatomic) UIButton *shareButton;

@property (nonatomic,strong) NSArray *typeButtons;
@property (nonatomic,strong) MLBMusicDetail *musicDetail;

@end

@implementation MLBMusicContentCell

#pragma mark LifeCycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Public Method

-(void)configurCellWithMusicetail:(MLBMusicDetail *)musicDetail{
    
    self.musicDetail = musicDetail;
    if (self.musicDetail) {
        [self.coverView mlb_sd_setImageWithURL:self.musicDetail.cover placeholderImageName:@"music_cover_small" cachePlaceholderImage:NO];
        [self.authorAvatarView mlb_sd_setImageWithURL:self.musicDetail.author.webURL placeholderImageName:@"personal"];
        self.authorNameLabel.text = self.musicDetail.author.username;
        self.authorDescLabel.text = self.musicDetail.author.desc;
        self.titleLabel.text = self.musicDetail.title;
        self.dateLabel.text = [MLBUtilities stringDateForMusicDetailsDateString:self.musicDetail.makeTime];
        self.firstPublishView.image = [self firstPublishImageWithMusicDetails:self.musicDetail];
        self.storyButton.selected = NO;
        [self showContentWithType:self.musicDetail.contenttype == MLBMusicDetailsTypeNone ? MLBMusicDetailsTypeStory : self.musicDetail.contenttype];
        [self.praiseButton setTitle:[NSString stringWithFormat:@"%ld",self.musicDetail.praiseNum] forState:UIControlStateNormal];
        [self.commentButton setTitle:[NSString stringWithFormat:@"%ld",self.musicDetail.commentNum] forState:UIControlStateNormal];
        [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",self.musicDetail.shareNum] forState:UIControlStateNormal];
    }else{
        self.coverView.image = [UIImage mlb_imageWithName:@"music_cover_small" cached:NO];
        self.authorAvatarView.image = [UIImage imageNamed:@"personal"];
        self.authorNameLabel.text = @"";
        self.authorDescLabel.text = @"";
        self.titleLabel.text = @"";
        self.dateLabel.text = @"";
        self.firstPublishView.image = nil;
        self.storyButton.selected = NO;
        [self showContentWithType:MLBMusicDetailsTypeNone];
        [self.praiseButton setTitle:@"0" forState:UIControlStateNormal];
        [self.commentButton setTitle:@"0" forState:UIControlStateNormal];
        [self.shareButton setTitle:@"0" forState:UIControlStateNormal];
    }
    
}

#pragma mark - Private Method

-(void)showContentWithType:(MLBMusicDetailsType)musicType{
    for (UIButton *bt in self.typeButtons) {
        bt.selected = bt.tag == musicType;
    }
    switch (musicType) {
        case MLBMusicDetailsTypeNone:
            self.contentTypeLabel.text = @"音乐故事";
            self.contentTextView.text = @"";
            self.contentTextView.attributedText = nil;
            break;
        case MLBMusicDetailsTypeStory:
            self.contentTypeLabel.text = @"音乐故事";
            break;
        case MLBMusicDetailsTypeLyric:
            self.contentTypeLabel.text = @"歌词";
            break;
        case MLBMusicDetailsTypeInfo:
            self.contentTypeLabel.text = @"歌曲信息";
            break;
            
        default:
            break;
    }
    [self updateContentTextViewWithType:musicType];
}

-(void)updateContentTextViewWithType:(MLBMusicDetailsType)type{
    NSString *text = @"";
    switch (type) {
        case MLBMusicDetailsTypeNone:
            
            break;
        case MLBMusicDetailsTypeStory:
            text = self.musicDetail.story;
            break;
        case MLBMusicDetailsTypeLyric:
            text = self.musicDetail.lyric;
            break;
        case MLBMusicDetailsTypeInfo:
            text = self.musicDetail.info;
            break;
    }
    if (IsStringEmpty(text)) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    if (type == MLBMusicDetailsTypeStory) {
        [attributedString appendAttributedString:[MLBUtilities mlb_attributedStringWithText:self.musicDetail.storyTitle lineSpacing:8 font:BoldFontWithSize(20) textColor:[UIColor blackColor]]];
        [attributedString appendAttributedString:[MLBUtilities mlb_attributedStringWithText:[NSString stringWithFormat:@"\n%@\n\n",self.musicDetail.storyAuthor.username] lineSpacing:8 font:FontWithSize(12) textColor:MLBLightBlueTextColor]];
        NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithAttributedString: [[NSAttributedString alloc] initWithData:[text dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil]];
        [attributeString1 setAttributes:@{NSFontAttributeName:FontWithSize(16),
                                          NSForegroundColorAttributeName:MLBLightBlackTextColor,
                                          NSParagraphStyleAttributeName:paragraphStyle
                                          } range: NSMakeRange(0, attributeString1.string.length)];
        
        [attributedString appendAttributedString:attributeString1];
    }else{
        attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[MLBUtilities mlb_attributedStringWithText:text lineSpacing:8 font:FontWithSize(16) textColor:MLBColor7F7F7F]];
    }
    
    NSString *editorText = [NSString stringWithFormat:@"\n\n%@\n\n", self.musicDetail.chargeEditor];
    [attributedString appendAttributedString:[MLBUtilities mlb_attributedStringWithText:editorText lineSpacing:8 font:FontWithSize(12) textColor:MLBColor7F7F7F]];
    
    self.contentTextView.attributedText = attributedString;
}

-(UIImage *)firstPublishImageWithMusicDetails:(MLBMusicDetail *)musicDetail{
    // isFirst 为0时，platform 为1则为虾米音乐首发，为2则不显示首发平台,
    // isFirst 为1时，platform 为1则为虾米和一个联合首发，为2则为一个独家首发
    NSString *imageName = @"";
    if ([musicDetail.isFirst isEqualToString:@"0"] && [musicDetail.platform isEqualToString:@"1"]) {
        imageName = @"xiami_music_first";
    }else if ([musicDetail.isFirst isEqualToString:@"1"] && [musicDetail.platform isEqualToString:@"1"]){
        imageName = @"one_and_xiami_music";
    }else if ([musicDetail.isFirst isEqualToString:@"1"] && [musicDetail.platform isEqualToString:[@(2) stringValue]]){
        imageName = @"one_first";
    }
    if (IsStringNotEmpty(imageName)) {
        return [UIImage imageNamed:imageName];
    }
    return nil;
}

-(void)setupViews{
    if (self.coverView) {
        return;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.coverView = ({
        UIImageView *coverView = [UIImageView new];
        coverView.backgroundColor = [UIColor whiteColor];
        coverView.contentMode = UIViewContentModeScaleAspectFill;
        coverView.clipsToBounds = YES;
        [self.contentView addSubview:coverView];
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(coverView.mas_width).multipliedBy(1);
            make.left.top.right.equalTo(self.contentView);
        }];
        coverView;
    });
    
    self.authorView = ({
        UIView *authorView = [UIView new];
        authorView.backgroundColor = [UIColor whiteColor];
        authorView.layer.shadowColor = MLBShadowColor.CGColor;
        authorView.layer.shadowOffset = CGSizeZero;
        authorView.layer.shadowRadius = 2;
        authorView.layer.shadowOpacity = 0.5;
        authorView.layer.cornerRadius = 2;
        [self.contentView addSubview:authorView];
        [authorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@120);
            make.top.equalTo(self.coverView.mas_bottom).offset(-24);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        authorView;
    });
    
    self.authorAvatarView = ({
        UIImageView *avatarView = [UIImageView new];
        avatarView.backgroundColor = [UIColor whiteColor];
        avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
        avatarView.layer.borderWidth = 1;
        avatarView.layer.cornerRadius = 24;
        avatarView.clipsToBounds = YES;
        [self.authorView addSubview:avatarView];
        [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.authorView).offset(16);
            make.top.equalTo(self.authorView).offset(20);
            make.width.height.mas_equalTo(48);
        }];
        avatarView;
    });
    
    self.firstPublishView = ({
        UIImageView *firstPublishView = [UIImageView new];
        firstPublishView.backgroundColor = [UIColor whiteColor];
        [self.authorView addSubview:firstPublishView];
        [firstPublishView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorAvatarView);
            make.right.equalTo(self.authorView).offset(-10);
        }];
        firstPublishView;
    });
    
    self.authorNameLabel = ({
        UILabel *authorNameLabel = [MLBUIFactory lableWithTextColor:MLBAppThemeColor font:FontWithSize(12)];
        [self.authorView addSubview:authorNameLabel];
        [authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorAvatarView).offset(7);
            make.left.equalTo(self.authorAvatarView.mas_right).offset(12);
        }];
        authorNameLabel;
    });
    
    self.authorDescLabel = ({
        UILabel *authorDescLable = [MLBUIFactory lableWithTextColor:MLBLightGrayTextColor font:FontWithSize(12) numberOfLine:1];
        [self.authorView addSubview:authorDescLable];
        [authorDescLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.authorNameLabel);
            make.top.equalTo(self.authorNameLabel.mas_bottom).offset(4);
        }];
        authorDescLable;
    });
    
    self.titleLabel = ({
        UILabel *titleLabel = [MLBUIFactory lableWithTextColor:MLBLightBlackTextColor font:FontWithSize(18)];
        [self.authorView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(@[self.authorAvatarView.mas_bottom,self.authorDescLabel.mas_bottom]).offset(10);
            make.left.equalTo(self.authorAvatarView);
            make.bottom.equalTo(self.authorView).offset(-16);
        }];
        titleLabel;
    });
    
    self.dateLabel = ({
        UILabel *dateLabel = [MLBUIFactory lableWithTextColor:MLBLightGrayTextColor font:FontWithSize(12)];
        [dateLabel setContentCompressionResistancePriority:251 forAxis:UILayoutConstraintAxisHorizontal];
        [self.authorView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(5);
            make.right.bottom.equalTo(self.authorView).offset(-8);
        }];
        dateLabel;
    });
    
    self.musicControlButton = ({
        UIButton *musicControlButton = [MLBUIFactory buttonWithImageName:@"play_normal" highLightImageName:@"play_highlighted" target:self action:@selector(playMusic)];
        [self.authorView addSubview:musicControlButton];
        [musicControlButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@50);
            make.left.greaterThanOrEqualTo(@[self.authorNameLabel.mas_right,self.authorDescLabel.mas_right]).offset(5);
            make.right.equalTo(self.authorView).offset(-10);
            make.bottom.equalTo(self.dateLabel.mas_top).offset(-8);
        }];
        musicControlButton;
    });
    
    self.aboutButton = ({
        UIButton *aboutButton = [MLBUIFactory buttonWithImageName:@"music_about_normal" selectedImageName:@"music_about_selected" target:self action:@selector(aboutClick)];
        [self.contentView addSubview:aboutButton];
        [aboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(44, 44));
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.authorView.mas_bottom);
        }];
        aboutButton;
    });
    
    self.lyricButton = ({
        UIButton *lyricButton = [MLBUIFactory buttonWithImageName:@"music_lyric_normal" selectedImageName:@"music_lyric_selected" target:self action:@selector(lyricClick)];
        [self.contentView addSubview:lyricButton];
        [lyricButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.aboutButton);
            make.right.equalTo(self.aboutButton.mas_left).offset(-8);
            make.top.equalTo(self.aboutButton);
        }];
        lyricButton;
    });
    
    self.storyButton = ({
        UIButton *storyButton = [MLBUIFactory buttonWithImageName:@"music_story_normal" selectedImageName:@"music_story_selected" target:self action:@selector(storyClick)];
        [self.contentView addSubview:storyButton];
        [storyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.aboutButton);
            make.right.equalTo(self.lyricButton.mas_left).offset(-8);
            make.size.equalTo(self.aboutButton);
        }];
        storyButton;
    });
    
    self.typeButtons = @[self.aboutButton,self.lyricButton,self.storyButton];
    
    self.contentTypeLabel = ({
        UILabel *contentTypeLabel = [MLBUIFactory lableWithTextColor:MLBColor7F7F7F font:FontWithSize(12)];
        contentTypeLabel.text = @"音乐故事";
        [self.contentView addSubview:contentTypeLabel];
        [contentTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
            make.bottom.equalTo(self.storyButton).offset(-8);
        }];
        contentTypeLabel;
    });
    
    UIView *separator = [MLBUIFactory separatorLine];
    [self.contentView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView).offset(6);
        make.right.equalTo(self.contentView).offset(-6);
        make.top.equalTo(self.storyButton.mas_bottom);
    }];
    
    [self.contentView bringSubviewToFront:self.authorView];
    
    self.contentTextView = ({
        UITextView *contentTextView = [UITextView new];
        contentTextView.backgroundColor = [UIColor whiteColor];
        contentTextView.textColor = MLBDarkBlackTextColor;
        contentTextView.font = FontWithSize(15);
        contentTextView.editable = NO;
        contentTextView.scrollEnabled = NO;
        contentTextView.showsVerticalScrollIndicator = NO;
        contentTextView.showsHorizontalScrollIndicator = NO;
        contentTextView.textContainerInset = UIEdgeInsetsMake(8, 8, 0, 8);
        [self.contentView addSubview:contentTextView];
        [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(separator.mas_bottom);
        }];
        contentTextView;
    });
    
    self.praiseButton = ({
        UIButton *praiseButton = [MLBUIFactory buttonWithImageName:@"like_normal" selectedImageName:@"like_selected" target:self action:@selector(praiseClick)];
        praiseButton.titleLabel.font = FontWithSize(12);
        [praiseButton setTitleColor:MLBDarkGrayTextColor forState:UIControlStateNormal];
        [praiseButton setTitleColor:MLBDarkGrayTextColor forState:UIControlStateSelected];
        praiseButton.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:praiseButton];
        [praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentTextView.mas_bottom);
            make.left.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(44);
        }];
        praiseButton;
    });
    
    self.commentButton = ({
        UIButton *commentButton = [MLBUIFactory buttonWithImageName:@"icon_toolbar_comment" selectedImageName:@"" target:self action:@selector(commentClick)];
        commentButton.titleLabel.font = FontWithSize(12);
        [commentButton setTitleColor:MLBDarkGrayTextColor forState:UIControlStateNormal];
        [commentButton setTitleColor:MLBDarkGrayTextColor forState:UIControlStateSelected];
        commentButton.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:commentButton];
        [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.praiseButton.mas_right);
            make.top.equalTo(self.praiseButton);
            make.height.equalTo(self.praiseButton);
        }];
        commentButton;
    });
    
    self.shareButton = ({
        UIButton *shareButton = [MLBUIFactory buttonWithImageName:@"share_image" selectedImageName:@"" target:self action:@selector(shareClick)];
        shareButton.titleLabel.font = FontWithSize(12);
        [shareButton setTitleColor:MLBDarkGrayTextColor forState:UIControlStateNormal];
        [shareButton setTitleColor:MLBDarkGrayTextColor forState:UIControlStateSelected];
        shareButton.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:shareButton];
        [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@[self.praiseButton,self.commentButton]);
            make.left.equalTo(self.commentButton.mas_right);
            make.height.top.equalTo(self.commentButton);
            make.right.equalTo(self.contentView);
        }];
        shareButton;
    });
    
    UIImageView *imageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_toolbar_line"]];
    imageView0.backgroundColor = [UIColor whiteColor];
    imageView0.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:imageView0];
    [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.left.equalTo(self.praiseButton.mas_right);
        make.top.bottom.equalTo(self.praiseButton);
    }];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_toolbar_line"]];
    imageView1.backgroundColor = [UIColor whiteColor];
    imageView1.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.left.equalTo(self.commentButton.mas_right);
        make.top.bottom.equalTo(self.commentButton);
    }];
    
    UIView *sepatrator0 = [MLBUIFactory separatorLine];
    [self.contentView addSubview:sepatrator0];
    [sepatrator0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.praiseButton);
    }];
    
    UIView *sepatrator1 = [MLBUIFactory separatorLine];
    [self.contentView addSubview:sepatrator1];
    [sepatrator1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.praiseButton);
    }];
}

#pragma mark - Action

-(void)playMusic{
    
}

-(void)aboutClick{
    
}

-(void)lyricClick{
    
}

-(void)storyClick{
    
}

-(void)praiseClick{
    
}

-(void)commentClick{
    
}

-(void)shareClick{
    
}

/**
 复用的时候清空上次的内容
 */
- (void)prepareForReuse{
    [super prepareForReuse];
    self.coverView.image = nil;
    [self.coverView sd_cancelCurrentImageLoad];
    self.authorAvatarView.image = nil;
    [self.authorAvatarView sd_cancelCurrentImageLoad];
    self.musicDetail = nil;
}

@end
