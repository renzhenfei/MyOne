//
//  MLBSearchMovieCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSearchMovieCell.h"
#import "MLBMovieListItem.h"
NSString *const KMLSearchMovieCellID = @"KMLSearchMovieCellID";

@interface MLBSearchMovieCell()
@property(nonatomic,strong) UILabel *titleLable;
@end

@implementation MLBSearchMovieCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    if (self.titleLable) {
        return;
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.titleLable = ({
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.textColor = MLBLightBlackTextColor;
        lable.font = FontWithSize(17);
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 8, 0, 0));
        }];
        lable;
    });
}

+ (CGFloat)cellHeight{
    return 44;
}

- (void)configureWithMovieItem:(MLBMovieListItem *)movieItem{
    self.titleLable.text = movieItem.title;
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
