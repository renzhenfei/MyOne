//
//  MLBReadDetailsAuthorInfoCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadDetailsAuthorInfoCell.h"
#import "MLBTapImageView.h"
#import "MLBAuthor.h"

NSString *const KMLReadDetailsAuthorInfoCellID = @"KMLReadDetailsAuthorInfoCellID";

@interface MLBReadDetailsAuthorInfoCell ()

@property (strong, nonatomic) MLBTapImageView *userAvatarView;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *userIntroduceLabel;
@property (strong, nonatomic) UILabel *userWeiboNameLabel;

@end

@implementation MLBReadDetailsAuthorInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    if (_userAvatarView) {
        return;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.userAvatarView = ({
        MLBTapImageView *imageView = [[MLBTapImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        [imageView zy_cornerRadiusRoundingRect];
        [imageView zy_attachBorderWidth:1 color:[UIColor whiteColor]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@48).priority(999);
            make.top.left.equalTo(self.contentView).offset(20);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-20);
        }];
        
        imageView;
    });
    
    self.usernameLabel = ({
        UILabel *label = [MLBUIFactory lableWithTextColor:MLBLightBlueTextColor font:FontWithSize(15)];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userAvatarView);
            make.left.equalTo(_userAvatarView.mas_right).offset(16);
            make.right.equalTo(self.contentView).offset(-20);
        }];
        
        label;
    });
    
    self.userIntroduceLabel = ({
        UILabel *label = [MLBUIFactory lableWithTextColor:MLBColor979797 font:FontWithSize(12) numberOfLine:0];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_usernameLabel.mas_bottom).offset(5);
            make.left.right.equalTo(_usernameLabel);
        }];
        
        label;
    });
    
    self.userWeiboNameLabel = ({
        UILabel *label = [MLBUIFactory lableWithTextColor:MLBColor979797 font:FontWithSize(12) numberOfLine:0];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userIntroduceLabel.mas_bottom).offset(5);
            make.left.right.equalTo(_usernameLabel);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-20);
        }];
        
        label;
    });
    
    UIView *topSeparator = [UIView new];
    topSeparator.backgroundColor = MLBSeparatorColor;
    [self.contentView addSubview:topSeparator];
    [topSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.top.right.equalTo(self.contentView);
    }];
    
    UIView *bottomSeparator = [UIView new];
    bottomSeparator.backgroundColor = MLBSeparatorColor;
    [self.contentView addSubview:bottomSeparator];
    [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

#pragma mark - Action



#pragma mark - Public Methods

- (void)configureCellWithAuthor:(MLBAuthor *)author {
    if (author) {
        [_userAvatarView mlb_sd_setImageWithURL:author.webURL placeholderImageName:@"personal"];
        _usernameLabel.text = author.username;
        _userIntroduceLabel.text = author.desc;
        _userWeiboNameLabel.text = [NSString stringWithFormat:@"Weibo: %@", author.wbName];
    } else {
        _userAvatarView.image = [UIImage imageNamed:@"personal"];
        _usernameLabel.text = @"";
        _userIntroduceLabel.text = @"";
        _userWeiboNameLabel.text = @"";
    }
}

@end
