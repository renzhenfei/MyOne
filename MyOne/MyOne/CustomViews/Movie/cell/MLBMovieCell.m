//
//  MLBMovieCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/4/7.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBMovieCell.h"
#import "MLBScoreView.h"
#import "MZTimerLabel.h"
NSString *const KMLMovieCellID = @"MLBMovieCell";

@interface MLBMovieCell()

@property(nonatomic,strong)UIImageView *coverView;
@property(nonatomic,strong)MLBScoreView *scoreView;
@property(nonatomic,strong)UILabel *comingSoonLabel;
@property(nonatomic,strong)MZTimerLabel *timerLabel;

@end

@implementation MLBMovieCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
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

- (void)prepareForReuse{
    [super prepareForReuse];
    self.coverView.image = nil;
    [self.coverView sd_cancelCurrentImageLoad];
}

-(void)setupViews{
    
    if (self.coverView) {
        return;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    self.coverView = ({
        UIImageView *coverView = [UIImageView new];
        coverView.contentMode = UIViewContentModeScaleAspectFill;
        coverView.clipsToBounds = YES;
        [self.contentView addSubview:coverView];
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        coverView;
    });
    
    self.scoreView = ({
        MLBScoreView *scoreView =  [MLBScoreView new];
        [self.contentView addSubview:scoreView];
        [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.contentView).offset(-10);
        }];
        scoreView;
    });
    
    self.comingSoonLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"即将上映";
        label.textColor = MLBColor555555;
        label.font = FontWithSize(12);
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.contentView).offset(-6);
        }];
        label;
    });
    
    self.timerLabel = ({
        MZTimerLabel *label = [[MZTimerLabel alloc] initWithTimerType:MZTimerLabelTypeTimer];
        label.textColor = MLBColor555555;
        label.font = FontWithSize(12);
        label.timeFormat = @"距离公布分数还剩：HH:mm:ss";
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.right.equalTo(self).offset(-6);
        }];
        label;
    });
}

-(void)configureWithMovie:(MLBMovieListItem *)movitItem indexPath:(NSIndexPath *)indexPath{
    NSString *placeHolderImageName = [NSString stringWithFormat:@"movieList_placeholder_%ld",indexPath.row % 12];
    [self.coverView mlb_sd_setImageWithURL:movitItem.cover placeholderImageName:placeHolderImageName];
    if (IsStringEmpty(movitItem.score)) {
        self.scoreView.hidden = YES;
        NSTimeInterval scoreDiffTimeInterval = [MLBUtilities difftimeIntervalSinceNowToDateString:movitItem.scoreTime];
        if (scoreDiffTimeInterval < 24 * 60 * 60) {
            self.comingSoonLabel.hidden = YES;
            self.timerLabel.hidden = NO;
            [self.timerLabel setCountDownTime:scoreDiffTimeInterval];
            [self.timerLabel start];
        }else{
            self.comingSoonLabel.hidden = NO;
        }
    }else{
        self.scoreView.hidden = NO;
        self.comingSoonLabel.hidden = YES;
        self.timerLabel.hidden = YES;
        self.scoreView.scoreLabel.text = movitItem.score;
    }
}

-(void)stopCountDownIfNeed{
    [self.timerLabel pause];
    [self.timerLabel reset];
}

@end
