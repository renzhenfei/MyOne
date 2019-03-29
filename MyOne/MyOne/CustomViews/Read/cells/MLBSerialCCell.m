//
//  MLBSerialCCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/27.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSerialCCell.h"

NSString *const kMLBSerialCCellID = @"MLBSerialCCellID";

@implementation MLBSerialCCell

+ (CGSize)cellSize{
    return CGSizeMake(44, 44);
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
    if (self.numberLabel) {
        return;
    }
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.numberLabel = ({
        UILabel *numberLabel = [UILabel new];
        numberLabel.font = FontWithSize(15);
        numberLabel.textColor = MLBAppThemeColor;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        numberLabel;
    });
}

@end
