//
//  MLBRelatedMusicCollectionCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/31.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBRelatedMusicCollectionCell.h"
#import "MLBRelatedMusicCCell.h"

NSString *const KMLRelatedMusicCollectionCellID = @"MLBRelatedMusicCollectionCell";

@interface MLBRelatedMusicCollectionCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic) UICollectionView *collectionView;
@property(strong,nonatomic) NSArray<MLBRelatedMusic *> *relatedMusics;

@end

@implementation MLBRelatedMusicCollectionCell

#pragma mark - lifecycle

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
    self.relatedMusics = nil;
}

#pragma mark Private Method

-(void)setupViews{
    if (self.collectionView) {
        return;
    }
    self.collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = [MLBRelatedMusicCCell cellSize];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.alwaysBounceVertical = NO;
        collectionView.alwaysBounceHorizontal = YES;
        collectionView.contentOffset = CGPointZero;
        [collectionView registerClass:[MLBRelatedMusicCCell class] forCellWithReuseIdentifier:KMLRelatedMusicCCellID];
        [self.contentView addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        collectionView;
    });
}

#pragma Public Method

+(CGFloat)cellHeight{
    return [MLBRelatedMusicCCell cellSize].height;
}

-(void)configureCellWithRelatedMusic:(NSArray<MLBRelatedMusic *> *)musics{
    self.relatedMusics = musics;
    [self.collectionView reloadData];
}

#pragma mark DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.relatedMusics.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MLBRelatedMusicCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMLRelatedMusicCCellID forIndexPath:indexPath];
    [cell configureCellWithRelatedMusic:self.relatedMusics[indexPath.row]];
    return cell;
}

#pragma mark Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
