//
//  MLBScoreView.m
//  MyOne
//
//  Created by zhenfei ren on 2019/4/7.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBScoreView.h"

@interface MLBScoreView()

@property(nonatomic,strong)UIImageView *scoreBottomline;

@end

@implementation MLBScoreView

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

-(void)setupViews{
    self.backgroundColor = [UIColor whiteColor];
    self.transform = CGAffineTransformMake(0.97, -0.242, 0.242, 0.97, 0, 0);
    
    self.scoreLabel = ({
        UILabel *scoreLable = [UILabel new];
        scoreLable.textColor = MLBScoreTextColor;
        scoreLable.font = ScoreFontWithSize(48);
        scoreLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:scoreLable];
        [scoreLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@60);
            make.top.greaterThanOrEqualTo(self);
        }];
        scoreLable;
    });
    
    self.scoreBottomline = ({
        UIImageView *bottomLine = [UIImageView new];
        bottomLine.image = [UIImage imageNamed:@"readline"];
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(81, 5));
            make.top.equalTo(self.scoreLabel.mas_bottom);
            make.left.bottom.right.equalTo(self);
            make.centerX.equalTo(self.scoreLabel);
        }];
        bottomLine;
    });
}

@end
