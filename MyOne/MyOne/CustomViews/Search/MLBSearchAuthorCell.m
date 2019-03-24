//
//  MLBSearchAuthorCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSearchAuthorCell.h"
#import <ZYImageView.h>
#import "MLBUser.h"

NSString *const KMLSearchAuthorID = @"KMLSearchAuthorID";

@interface MLBSearchAuthorCell()

@property(nonatomic,strong) ZYImageView *avatarView;
@property(strong,nonatomic) UILabel *usernameLable;
@property(strong,nonatomic) UILabel *descLable;

@end

@implementation MLBSearchAuthorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    if (self.avatarView) {
        return;
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.avatarView = ({
        ZYImageView *img = [ZYImageView zy_roundingRectImageView];
        img.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@48);
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(8);
        }];
        img;
    });
    self.usernameLable = ({
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.font = FontWithSize(13);
        lable.textColor = MLBLightBlackTextColor;
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarView).offset(2);
            make.left.equalTo(self.avatarView.mas_right).offset(8);
            make.right.equalTo(self.contentView);
        }];
        lable;
    });
    self.descLable = ({
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.font = FontWithSize(12);
        lable.textColor = MLBAppThemeColor;
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.usernameLable);
            make.bottom.equalTo(self.avatarView).offset(-4);
        }];
        lable;
    });
}

+ (CGFloat)cellHeight{
    return 64;
}

- (void)configureCellWithUser:(MLBUser *)user{
    [self.avatarView mlb_sd_setImageWithURL:user.webURL placeholderImageName:nil];
    self.usernameLable.text = user.username;
    self.descLable.text = user.desc;
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
