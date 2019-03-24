//
//  MLBSearchMusicCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSearchMusicCell.h"
#import "MLBRelatedMusic.h"
NSString *const KMLSearchRelatedMusicID = @"KMLSearchRelatedMusicID";

@interface MLBSearchMusicCell()

@property(strong,nonatomic) UIImageView *albumView;
@property(strong,nonatomic) UIImageView *coverView;
@property(strong,nonatomic) UILabel *musicNameLable;
@property(strong,nonatomic) UILabel *authorNameLable;

@end

@implementation MLBSearchMusicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    if (self.albumView) {
        return;
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.albumView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@48);
            make.centerY.equalTo(self.contentView).offset(-2);
            make.left.equalTo(self.contentView).offset(12);
        }];
        imageView;
    });
    
    self.musicNameLable = ({
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.textColor = MLBLightBlackTextColor;
        lable.font = FontWithSize(16);
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.albumView).offset(3);
            make.left.equalTo(self.albumView.mas_right).offset(6);
        }];
        lable;
    });
    
    self.authorNameLable = ({
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.textColor = MLBAppThemeColor;
        lable.font = FontWithSize(12);
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.musicNameLable.mas_bottom).offset(5);
            make.left.equalTo(self.musicNameLable);
        }];
        lable;
    });
    
    self.coverView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.opaque = YES;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(62, 56));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(6);
        }];
        imageView;
    });
}

+ (CGFloat)cellHeight{
    return 72;
}

#pragma mark - Public Method

- (void)configureWithMLBRelatedMusic:(MLBRelatedMusic *)music{
    [self.albumView mlb_sd_setImageWithURL:music.cover placeholderImageName:@"cover_cd_cover"];
    self.musicNameLable.text = music.title;
    self.authorNameLable.text = music.author.username;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
