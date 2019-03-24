//
//  MLBSearchReadCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSearchReadCell.h"
#import "MLBSearchRead.h"

NSString *const KMLSearchReadCellID = @"KMLSearchReadCellID";

@interface MLBSearchReadCell()

@property(strong,nonatomic)UIImageView *readTypeView;
@property(strong,nonatomic)UILabel *titleLable;

@end

@implementation MLBSearchReadCell

+(CGFloat)cellHeight{
    return 64;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Private Method

-(void)setupView{
    if (self.readTypeView) {
        return;
    }
    self.readTypeView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(48));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(8);
        }];
        imageView;
    });
    self.titleLable = ({
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.font = FontWithSize(17);
        lable.textColor = MLBLightBlackTextColor;
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.readTypeView.mas_right).offset(8);
            make.right.equalTo(self.contentView);
        }];
        lable;
    });
}

#pragma mark - Public Method

-(void)configureCellWithSearchRead:(MLBSearchRead *)read{
    NSString *imgStr;
    if ([read.type isEqualToString:@"essay"]) {
        imgStr = @"icon_read";
    }else if ([read.type isEqualToString:@"serialcontent"]){
        imgStr = @"icon_serial";
    }else if ([read.type isEqualToString:@"question"]){
        imgStr = @"icon_question";
    }
    self.readTypeView.image = [UIImage imageNamed:imgStr];
    self.titleLable.text = read.title;
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
