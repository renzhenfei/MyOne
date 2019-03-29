//
//  MLBSerialCollectionView.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSerialCollectionView.h"
#import "MLBSerialList.h"
#import "MLBSerialCCell.h"
#import "MLBReadSerial.h"
#import "MLBhttpRequester.h"

NSString *kCollectionViewReuseHeaderID = @"MLBCollectionViewReuseHeaderID";
NSInteger kCollectionViewHeaderHeight = 50;

@interface MLBSerialCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UIButton *closeButton;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) MASConstraint *collectionViewHeightConstraint;
@property(nonatomic,strong) MLBSerialList *serialList;

@end

@implementation MLBSerialCollectionView

#pragma mark - LifeCycle

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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Public Method

-(void)show{
    self.alpha = 0;
    [kKeyWindow addSubview:self];
    [self requestSerialList];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss{
    [self dismissWithCompleted:nil];
}

-(void)dismissWithCompleted:(void(^)(void))completedBlock{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.collectionViewHeightConstraint.mas_equalTo(kCollectionViewHeaderHeight);
        self.serialList = nil;
        if (completedBlock) {
            completedBlock();
        }
    }];
}

#pragma mark - Private Method

-(void)setupViews{
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if (self.closeButton) {
        return;
    }
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = [MLBSerialCCell cellSize];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 13;
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH - 24 * 2, kCollectionViewHeaderHeight);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[MLBSerialCCell class] forCellWithReuseIdentifier:kMLBSerialCCellID];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionViewReuseHeaderID];
        [self addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            self.collectionViewHeightConstraint = make.height.mas_equalTo(kCollectionViewHeaderHeight);
            make.left.equalTo(self).offset(24);
            make.right.equalTo(self).offset(-24);
        }];
        collectionView;
    });
    
    self.closeButton = ({
        UIButton *closeButton = [MLBUIFactory buttonWithImageName:@"close_normal" highLightImageName:@"close_highlighted" target:self action:@selector(dismiss)];
        closeButton.backgroundColor = [UIColor whiteColor];
        [self addSubview:closeButton];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(44);
            make.left.equalTo(self).offset(3);
            make.right.equalTo(self).offset(20);
        }];
        closeButton;
    });
    
    
}

#pragma mark NetWork

-(void)requestSerialList{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestSerialListById:self.readSerail.serialId success:^(id responseObject) {
        NSError *error;
        if ([responseObject[@"res"] integerValue] == 0) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            self.serialList = [MTLJSONAdapter modelOfClass:[MLBSerialList class] fromJSONDictionary:responseObject[@"data"] error:&error];
            if (!error) {
                [strongSelf.collectionView reloadData];
            }else{
                [self showHUDModelTransformFailedWithError:error];
            }
        }else{
            [self showHUDErrorWithText:@"解析失败"];
        }
    } fail:^(NSError *error) {
        [self showHUDNetError];
    }];
}

#pragma mark - DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.serialList.list.count;
}

//headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionViewReuseHeaderID forIndexPath:indexPath];
    if (headerView.subviews.count <= 0) {
        UILabel *lable = [UILabel new];
        lable.text = self.readSerail.title;
        lable.font = FontWithSize(18);
        lable.textColor = MLBLightBlackTextColor;
        lable.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(headerView);
        }];
        UIView *line = [MLBUIFactory separatorLine];
        [headerView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.bottom.equalTo(headerView);
        }];
    }
    return headerView;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MLBSerialCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMLBSerialCCellID forIndexPath:indexPath];
    MLBReadSerial *item = self.serialList.list[indexPath.row];
    cell.numberLabel.text = item.title;
    return cell;
}

#pragma mark - Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.didSelectedSerial) {
        self.didSelectedSerial(self.serialList.list[indexPath.row]);
    }
}
@end
