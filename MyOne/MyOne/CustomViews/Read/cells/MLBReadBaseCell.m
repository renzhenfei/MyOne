//
//  MLBReadBaseCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/20.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadBaseCell.h"
#import "MLBBaseModel.h"
#import "MLBReadEssay.h"
#import "MLBReadQuestion.h"
#import "MLBReadSerial.h"
#import "MLBAuthor.h"
NSString *const KMLReadBaseCellID = @"KMLReadBaseCellID";

@interface MLBReadBaseCell()

@property(strong,nonatomic) UIImageView *readTypeView;
@property(strong,nonatomic) UILabel *titleLable;
@property(strong,nonatomic) UILabel *authorLable;
@property(strong,nonatomic) UILabel *contentLable;
@property(strong,nonatomic) UIView *bottomLine;

@end

@implementation MLBReadBaseCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupView{
    
    if (self.readTypeView) {
        return;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.readTypeView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(41, 19));
            make.top.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        imageView;
    });
    
    self.titleLable = ({
        UILabel *lable = [UILabel new];
        lable.textColor = MLBDarkBlackTextColor;
        lable.font = BoldFontWithSize(16);
        lable.numberOfLines = 0;
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.readTypeView);
            make.left.equalTo(self.contentView).offset(10);
            make.right.lessThanOrEqualTo(self.readTypeView.mas_left).offset(-10);
        }];
        lable;
    });
    
    self.authorLable = ({
        UILabel *lable = [UILabel new];
        lable.textColor = MLBLightBlackTextColor;
        lable.font = FontWithSize(13);
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLable);
            make.top.equalTo(self.titleLable.mas_bottom).offset(10);
        }];
        lable;
    });
    
    self.contentLable = ({
        UILabel *label = [UILabel new];
        label.textColor = MLBLightBlackTextColor;
        label.font = FontWithSize(13);
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_authorLable.mas_bottom).offset(10);
            make.left.right.equalTo(_authorLable);
            make.bottom.equalTo(self.contentView).offset(-24);
        }];
        label;
    });
    
    self.bottomLine = ({
        UIView *line = [UIView new];
        line.backgroundColor = MLBSeparatorColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        }];
        line;
    });
}

-(void)configureCellWithBaseModel:(MLBBaseModel *)model{
    if ([model isKindOfClass:[MLBReadEssay class]]) {
        [self configureCellWithReadEssay:(MLBReadEssay *)model];
    }else if([model isKindOfClass:[MLBReadSerial class]]){
        [self configureCellWithReadSerial:(MLBReadSerial *)model];
    }else if ([model isKindOfClass:[MLBReadQuestion class]]){
        [self configureCellWithReadQuestion:(MLBReadQuestion *)model];
        self.bottomLine.hidden = NO;
    }
}

-(void)configureCellWithReadEssay:(MLBReadEssay *)model{
    self.readTypeView.image = [UIImage imageNamed:@"icon_read"];
    self.titleLable.text = model.title;
    if (model.authors.count > 0) {
        MLBAuthor *author = model.authors[0];
        self.authorLable.text = author.username;
    }else{
        self.authorLable.text = @"";
    }
    [self commonConfigureContentLabelWithText:model.guideWord];
    _bottomLine.hidden = NO;
}

-(void)configureCellWithReadSerial:(MLBReadSerial *)model{
    self.readTypeView.image = [UIImage imageNamed:@"icon_serial"];
    self.titleLable.text = model.title;
    self.authorLable.text = model.author.username;
    [self commonConfigureContentLabelWithText:model.excerpt];
    _bottomLine.hidden = NO;
}

-(void)configureCellWithReadQuestion:(MLBReadQuestion *)model{
    self.readTypeView.image = [UIImage imageNamed:@"icon_question"];
    self.titleLable.text = model.questionTitle;
    self.authorLable.text = model.answerTitle;
    [self commonConfigureContentLabelWithText:model.answerContent];
    _bottomLine.hidden = YES;
}

-(void)commonConfigureContentLabelWithText:(NSString *)content{
    if (IsStringEmpty(content)) {
        return;
    }
    self.contentLable.attributedText = [MLBUtilities mlb_attributedStringWithText:content lineSpacing:MLBLineSpacing font:self.contentLable.font textColor:self.contentLable.textColor];
}

@end
