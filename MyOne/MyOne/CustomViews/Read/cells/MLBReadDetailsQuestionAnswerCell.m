//
//  MLBReadDetailsQuestionAnswerCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadDetailsQuestionAnswerCell.h"
#import "MLBReadQuestionDetails.h"

NSString *const KMLReadDetailsQuestionAnswerCellID = @"KMLReadDetailsQuestionAnswerCellID";

@interface MLBReadDetailsQuestionAnswerCell ()

@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation MLBReadDetailsQuestionAnswerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    if (_contentLabel) {
        return;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentLabel = ({
        UILabel *label = [MLBUIFactory lableWithTextColor:MLBDarkBlackTextColor font:BoldFontWithSize(20) numberOfLine:0];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(24, 12, 24, 0));
        }];
        
        label;
    });
    
    self.dateLabel = ({
        UILabel *label = [MLBUIFactory lableWithTextColor:MLBLightGrayTextColor font:FontWithSize(12)];
        [label setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel);
            make.left.equalTo(_contentLabel.mas_right).offset(4);
            make.right.equalTo(self.contentView).offset(-12);
        }];
        
        label;
    });
}

#pragma mark - Public Methods

- (void)configureCellWithQuestionDetails:(MLBReadQuestionDetails *)questionDetails {
    _contentLabel.text = questionDetails.answerTitle;// [MLBUtilities mlb_attributedStringWithText:questionDetails.answerTitle lineSpacing:MLBLineSpacing font:_contentLabel.font textColor:_contentLabel.textColor];
    _dateLabel.text = [MLBUtilities stringDateForReadDetailsDateString:questionDetails.questionMakeTime];
}

@end
