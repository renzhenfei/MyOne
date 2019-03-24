//
//  MLBSearchPictureCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSearchPictureCell.h"
#import "MLBHomeItem.h"

NSString *const kMLBSearchPictureCellID = @"MLBSearchPictureCellID";

@interface MLBSearchPictureCell()

@property(strong,nonatomic) UIImageView *coverView;
@property(strong,nonatomic) UILabel *titleLable;
@property(strong,nonatomic) UILabel *contentLable;

@end

@implementation MLBSearchPictureCell

#pragma mark - Class Method

+ (CGFloat)cellHeight{
    return 64;
}

#pragma mark -View Lifecycle

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.coverView.image = nil;
}

#pragma mark - Public Method

- (void)configureCellWithHomeItem:(MLBHomeItem *)item{
    [self.coverView mlb_sd_setImageWithURL:item.imageURL placeholderImageName:@"home_cover_placeholder"];
    self.titleLable.text = item.title;
    self.contentLable.text = item.content;
}

#pragma mark - Private Method

-(void)setUpViews{
    if (self.coverView) {
        return;
    }
    self.coverView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(65, 48));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(8);
        }];
        imageView;
    });
    self.titleLable = ({
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.font = FontWithSize(13);
        lable.textColor = MLBLightBlueTextColor;
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coverView);
            make.left.equalTo(self.coverView.mas_right).offset(8);
            make.right.equalTo(self.contentView);
        }];
        lable;
    });
    self.contentLable = ({
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.font = FontWithSize(13);
        lable.textColor = MLBLightBlackTextColor;
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLable);
            make.right.equalTo(self.coverView);
        }];
        lable;
    });
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
