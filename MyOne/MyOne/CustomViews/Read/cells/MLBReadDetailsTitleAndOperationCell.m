//
//  MLBReadDetailsTitleAndOperationCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadDetailsTitleAndOperationCell.h"

NSString *const KMLReadDetailsTitleAndOperationCellID = @"KMLReadDetailsTitleAndOperationCellID";

@interface MLBReadDetailsTitleAndOperationCell ()

@end


@implementation MLBReadDetailsTitleAndOperationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    if (_titleLable) {
        return;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLable = ({
        UILabel *label = [MLBUIFactory lableWithTextColor:MLBDarkBlackTextColor font:BoldFontWithSize(20) numberOfLine:0];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8, 12, 8, 44 + 15 + 8));
        }];
        
        label;
    });
    
    self.serialsButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:@"icon_article_list_normal" highLightImageName:@"icon_article_list_highlighted" target:self action:@selector(serialsButtonClicked)];
        button.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.centerY.equalTo(self.titleLable);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        button;
    });
}

#pragma mark - Action

- (void)serialsButtonClicked {
    if (_serialsClicked) {
        _serialsClicked();
    }
}
@end
