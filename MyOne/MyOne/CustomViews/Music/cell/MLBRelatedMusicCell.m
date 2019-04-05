//
//  MLBRelatedMusicCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/31.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBRelatedMusicCell.h"

NSString *const KMLRelatedMusicCellID = @"KMLRelatedMusicCellID";

@implementation MLBRelatedMusicCell

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
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

#pragma mark - Private Method

-(void)setupViews{
    
}

#pragma mark - Public Method

+(CGSize)cellSiz{
    return CGSizeZero;
}

@end
