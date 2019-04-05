//
//  MLBRelatedMusicCCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/31.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBRelatedMusicCCell.h"

NSString *const KMLRelatedMusicCCellID = @"MLBRelatedMusicCCell";

@interface MLBRelatedMusicCCell()

@property(nonatomic,strong) UIImageView *coverBGView;
@property(nonatomic,strong) UIImageView *coverView;
@property(nonatomic,strong) UILabel *musicNameLabel;
@property(nonatomic,strong) UILabel *authorNameLabel;

@end

@implementation MLBRelatedMusicCCell

+(CGSize)cellSize{
    return CGSizeMake(135, 180);
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.coverView.image = nil;
    [self.coverView sd_cancelCurrentImageLoad];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    if (self.coverBGView) {
        return;
    }
    self.coverBGView = ({
        UIImageView *coverBGView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"music_cover_light"]];
        coverBGView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:coverBGView];
        [coverBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(106, 98));
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(20);
        }];
        coverBGView;
    });
    
    self.coverView = ({
        UIImageView *coverView = [UIImageView new];
        coverView.backgroundColor = [UIColor whiteColor];
        coverView.contentMode = UIViewContentModeScaleToFill;
        coverView.clipsToBounds = YES;
        [self.contentView addSubview:coverView];
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.coverBGView).insets(UIEdgeInsetsMake(4, 9, 11, 15));
        }];
        coverView;
    });
    
    self.musicNameLabel = ({
        UILabel *musicNameLabel = [MLBUIFactory lableWithTextColor:MLBColor6A6A6A font:FontWithSize(14)];
        [self.contentView addSubview:musicNameLabel];
        [musicNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coverBGView.mas_bottom).offset(10);
            make.left.equalTo(self.coverBGView);
            make.right.lessThanOrEqualTo(self.contentView);
        }];
        musicNameLabel;
    });
    
    self.authorNameLabel = ({
        UILabel *authorNameLabel = [MLBUIFactory lableWithTextColor:MLBColor80ACE1 font:FontWithSize(11)];
        [self.contentView addSubview:authorNameLabel];
        [authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.musicNameLabel.mas_bottom).offset(5);
            make.left.equalTo(self.musicNameLabel);
            make.right.lessThanOrEqualTo(self.contentView);
        }];
        authorNameLabel;
    });
}

-(void)configureCellWithRelatedMusic:(MLBRelatedMusic *)relatedMusic{
    [self.coverView mlb_sd_setImageWithURL:relatedMusic.cover placeholderImageName:@"music_cover_small" cachePlaceholderImage:NO];
    self.musicNameLabel.text = relatedMusic.title;
    self.authorNameLabel.text = relatedMusic.author.username;
}

@end
