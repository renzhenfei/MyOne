//
//  MLBMusicView.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/29.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBMusicView.h"
#import "MLBMusicDetail.h"
#import "MLBCommentList.h"
#import "MLBMusicContentCell.h"
NSString *const KMLMusicViewID = @"KMLMusicViewID";

@interface MLBMusicView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSString *musicId;
@property(nonatomic,strong) MLBMusicDetail *musicDetail;
@property(nonatomic,strong) MLBCommentList *commentList;
@property(nonatomic,strong) NSArray *relatedMusic;

//@property(nonatomic,strong) mlb

@end

@implementation MLBMusicView

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Private Method

-(void)setupViews{
    if (self.tableView) {
        return;
    }
    self.tableView = ({
        UITableView *tableView = [UITableView new];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView;
    });
}

#pragma mark - Public Method

-(void)prepareForReuse{
    
}

-(void)configureViewWithMusicId:(NSString *)musicId indexpath:(NSIndexPath *)indexPath{
    
}

-(void)configureViewWithMusicId:(NSString *)musicId indexpath:(NSInteger)index inViewController:(UIViewController *)inViewController{
    
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLBMusicContentCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLMusicContentCellID forIndexPath:indexPath];
    [cell configurCellWithMusicetail:nil];//todo
    return cell;
}

#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.bounds.size.height;
}

@end
