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
#import "MLBCommonHeaderFooterView.h"
#import "MLBRelatedMusicCollectionCell.h"
#import "MLBNoneMessageCell.h"
#import "MLBCommentCell.h"
#import "MLBhttpRequester.h"
#import "MLBComment.h"
#import <UITableView+FDTemplateLayoutCell.h>

NSString *const KMLMusicViewID = @"KMLMusicViewID";

@interface MLBMusicView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSString *musicId;
@property(nonatomic,strong) MLBMusicDetail *musicDetail;
@property(nonatomic,strong) MLBCommentList *commentList;
@property(nonatomic,strong) NSArray<MLBRelatedMusic *> *relatedMusic;
@property(nonatomic,assign) NSInteger initStatusContentOffsetY;

@property(nonatomic,strong) MLBMusicContentCell *musicContentCell;
@property(nonatomic,strong) MLBRelatedMusicCollectionCell *relatedMusicCollectionCell;

@end

@implementation MLBMusicView{
    BOOL firstLoad;//标记，加载完成回到顶部
}

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (firstLoad) {
        [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];//加载完滚动到顶部
        firstLoad = false;
    }
}

#pragma mark - Private Method

-(void)configure{
    [self setupViews];
    [self initData];
}

-(void)setupViews{
    if (self.tableView) {
        return;
    }
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[MLBCommonHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kMLBCommonHeaderFooterViewIDForTypeHeader];
        [tableView registerClass:[MLBMusicContentCell class] forCellReuseIdentifier:KMLMusicContentCellID];
        [tableView registerClass:[MLBRelatedMusicCollectionCell class] forCellReuseIdentifier:KMLRelatedMusicCollectionCellID];
        [tableView registerClass:[MLBNoneMessageCell class] forCellReuseIdentifier:KMLNoneMessageCellID];
        [tableView registerClass:[MLBCommentCell class] forCellReuseIdentifier:KMLCommentCellID];
        tableView.tableFooterView = [UIView new];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        tableView;
    });
}

-(void)initData{
    self.initStatusContentOffsetY = [@(ceil(SCREEN_WIDTH * 0.6)) integerValue];
    self.commentList = [MLBCommentList new];
    self.commentList.comments = [NSMutableArray array];
    self.commentList.hotComments = [NSMutableArray array];
    self.relatedMusic = [NSMutableArray array];
}

#pragma mark - Public Method

- (void)prepareForReuse{
    self.relatedMusic = nil;
    self.musicDetail = nil;
    self.commentList = nil;
    [self.tableView reloadData];
}

-(void)configureViewWithMusicId:(NSString *)musicId viewIndex:(NSInteger)viewIndex{
    [self configureViewWithMusicId:musicId viewIndex:viewIndex inViewController:nil];
}

-(void)configureViewWithMusicId:(NSString *)musicId viewIndex:(NSInteger)viewIndex inViewController:(MLBBaseViewController *)inViewController{
    self.viewIndex = viewIndex;
    self.musicId = musicId;
    self.parentViewController = inViewController;
    
    self.tableView.contentOffset = CGPointMake(0, self.initStatusContentOffsetY);
    firstLoad = true;
    [self requestMusicDetails];
}

#pragma mark - NetWork

-(void)requestMusicDetails{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestMusicDetailsById:self.musicId success:^(id responseObject) {
       __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            self.musicDetail = [MTLJSONAdapter modelOfClass:[MLBMusicDetail class] fromJSONDictionary:responseObject[@"data"] error:&error];
            if (error) {
                [strongSelf showHUDModelTransformFailedWithError:error];
                return;
            }
            [strongSelf.tableView reloadData];
            [strongSelf requestMusicRelatedMusics];
            [strongSelf requestMusicComments];
        }else{
            [strongSelf showHUDErrorWithText:@"解析音乐对象失败"];
        }
        
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf showHUDNetError];
    }];
}

// 看返回结果应该最多是3首
-(void)requestMusicRelatedMusics{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestMusicDetailsRelatedMusicsById:self.musicId success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            self.relatedMusic = [MTLJSONAdapter modelsOfClass:[MLBRelatedMusic class] fromJSONArray:responseObject[@"data"] error:&error];
            if (error) {
                [strongSelf showHUDModelTransformFailedWithError:error];
                return;
            }
            [strongSelf.tableView reloadData];
        }else{
            [strongSelf showHUDErrorWithText:@"解析音乐推荐对象失败"];
        }
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf showHUDNetError];
    }];
}

-(void)requestMusicComments{
    NSString *commentId;
    if (self.commentList && self.commentList.comments.count > 0) {
        commentId = ((MLBComment *)self.commentList.comments.lastObject).commentId;
    }
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestMusicPraiseAndTimeCommentsWithItemId:self.musicId lastCommentId:commentId success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf processingForCommentsWithResponseObject:responseObject];
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf showHUDNetError];
    }];
}

-(void)processingForCommentsWithResponseObject:(id)responseObject{
    if ([responseObject[@"res"] integerValue] == 0) {
        NSError *error;
        MLBCommentList *commentList = [MTLJSONAdapter modelOfClass:[MLBCommentList class] fromJSONDictionary:responseObject[@"data"] error:&error];
        if (error) {
            [self showHUDModelTransformFailedWithError:error];
            return;
        }
        if (!self.commentList) {
            self.commentList = [MLBCommentList new];
            self.commentList.comments = @[].mutableCopy;
            self.commentList.hotComments = @[].mutableCopy;
        }
        self.commentList.count = commentList.count;
        MLBComment *lastHotComment;
        for (MLBComment *comment in commentList.comments) {
            if (comment.commentType == MLBCommentTypeHot) {
                lastHotComment = comment;
                [self.commentList.hotComments addObject:comment];
            }else{
                [self.commentList.comments addObject:comment];
            }
        }
        [self.tableView reloadData];
    }
}

-(MLBComment *)commentAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return self.commentList.hotComments[indexPath.row];
    }else if(indexPath.section == 3){
        return self.commentList.comments[indexPath.row];
    }
    return nil;
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.relatedMusic && self.relatedMusic.count > 0 ? 1 : 0;
    }else if (section == 2){
        return self.commentList ? self.commentList.hotComments.count : 0;
    }else if (section == 3){
        return self.commentList ? self.commentList.comments.count : 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (!self.musicContentCell) {
            self.musicContentCell = [tableView dequeueReusableCellWithIdentifier:KMLMusicContentCellID forIndexPath:indexPath];
        }
        [self.musicContentCell configurCellWithMusicetail:self.musicDetail];//todo
        if (!self.musicContentCell.contentTypeButtonSelected) {
            __weak typeof(self) weakSelf = self;
            self.musicContentCell.contentTypeButtonSelected = ^(MLBMusicDetailsType buttonType) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf.tableView reloadData];
            };
        }
        return self.musicContentCell;
    }else if (indexPath.section == 1){
        if (!self.relatedMusicCollectionCell) {
            self.relatedMusicCollectionCell = [tableView dequeueReusableCellWithIdentifier:KMLRelatedMusicCollectionCellID forIndexPath:indexPath];
        }
        [self.relatedMusicCollectionCell configureCellWithRelatedMusic:self.relatedMusic];
        return self.relatedMusicCollectionCell;
    }else if (indexPath.section == 2 || indexPath.section == 3){
        if (indexPath.section == 3 && (!self.commentList || self.commentList.comments.count <= 0)) {
            return [tableView dequeueReusableCellWithIdentifier:KMLNoneMessageCellID forIndexPath:indexPath];
        }
        MLBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLCommentCellID forIndexPath:indexPath];
        [cell configureCellForCommonWithComment:[self commentAtIndexPath:indexPath] atIndexPath:indexPath];
        if (!cell.cellButtonClicked) {
            __weak typeof(self) weakSelf = self;
            cell.cellButtonClicked = ^(MLBCommentCellButtonType type, NSIndexPath *indexPath) {
              __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf commentCellButtonClickedWithType:type indexPath:indexPath];
            };
        }
        return cell;
    }
    return nil;
}

#pragma mark - Action

- (void)commentCellButtonClickedWithType:(MLBCommentCellButtonType)type indexPath:(NSIndexPath *)indexPath {
    switch (type) {
        case MLBCommentCellButtonTypeUserAvatar: {
            break;
        }
        case MLBCommentCellButtonTypePraise: {
            break;
        }
        case MLBCommentCellButtonTypeUnfold: {
            MLBComment *comment = [self commentAtIndexPath:indexPath];
            if (!comment.isUnfolded) {
                comment.unfolded = YES;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            break;
        }
    }
}

#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        __weak typeof(self) weakSelf = self;
        return [tableView fd_heightForCellWithIdentifier:KMLMusicContentCellID cacheByIndexPath:indexPath configuration:^(MLBMusicContentCell *cell) {
           __strong typeof(weakSelf) strongSelf = weakSelf;
            [cell configurCellWithMusicetail:strongSelf.musicDetail];
        }];
    }else if (indexPath.section == 1){
        return [MLBRelatedMusicCollectionCell cellHeight];
    }else if (indexPath.section == 2 || indexPath.section == 3){
        if (indexPath.section == 3 && (!self.commentList || self.commentList.comments.count <= 0)) {
            return [MLBNoneMessageCell cellHeight];
        }
        __weak typeof(self) weakSelf = self;
        return [tableView fd_heightForCellWithIdentifier:KMLCommentCellID cacheByIndexPath:indexPath configuration:^(MLBCommentCell *cell) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [cell configureCellForCommonWithComment:[strongSelf commentAtIndexPath:indexPath] atIndexPath:indexPath];
        }];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MLBCommonHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kMLBCommonHeaderFooterViewIDForTypeHeader];
    if (section == 1 && self.relatedMusic && self.relatedMusic.count > 0) {
        header.viewType = MLBCommonHeaderFooterViewTypeRelatedMusic;
        return header;
    }else if (section == 2){
        header.viewType = MLBCommonHeaderFooterViewTypeComment;
        return header;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2 && self.commentList && self.commentList.hotComments.count > 0) {
        MLBCommonHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kMLBCommonHeaderFooterViewIDForTypeHeader];
        footer.viewType = MLBCommonHeaderFooterViewTypeAboveIsHotComments;
        return footer;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 && self.relatedMusic && self.relatedMusic.count > 0) {
        return [MLBCommonHeaderFooterView viewHeight];
    }else if (section == 2){
        return [MLBCommonHeaderFooterView viewHeight];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2 && self.commentList && self.commentList.hotComments.count > 0){
        return [MLBCommonHeaderFooterView viewHeight];
    }
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

@end
