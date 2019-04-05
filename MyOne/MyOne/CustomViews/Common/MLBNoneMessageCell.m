//
//  MLBNoneMessageCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/31.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBNoneMessageCell.h"

NSString *const KMLNoneMessageCellID = @"MLBNoneMessageCell";

@implementation MLBNoneMessageCell

+ (CGFloat)cellHeight{
    return 100;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    if (self.hintView) {
        return;
    }
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.hintView = ({
        UIImageView *hintView = [UIImageView new];
        hintView.backgroundColor = [UIColor whiteColor];
        hintView.contentMode = UIViewContentModeScaleAspectFit;
        hintView.image = [UIImage imageNamed:@"sofa_image"];
        [self.contentView addSubview:hintView];
        [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        hintView;
    });
}

@end
