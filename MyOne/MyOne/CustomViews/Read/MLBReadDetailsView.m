//
//  MLBReadDetailsView.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/21.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadDetailsView.h"

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "MLBReadDetailsAuthorCell.h"
#import "MLBReadDetailsTitleAndOperationCell.h"
#import "MLBReadDetailsContentCell.h"
#import "MLBReadDetailsAuthorInfoCell.h"
#import "MLBReadBaseCell.h"
#import "MLBCommentCell.h"
#import "MLBReadDetailsQuestionTitleCell.h"
#import "MLBReadDetailsQuestionAnswerCell.h"

#import "MLBCommonHeaderFooterView.h"

#import "MLBReadEssay.h"
#import "MLBReadEssayDetails.h"
#import "MLBReadSerial.h"
#import "MLBReadSerialDetails.h"
#import "MLBReadQuestion.h"
#import "MLBReadQuestionDetails.h"

#import "MLBCommentList.h"

#import "MLBSerialCollectionView.h"

#import <MJRefresh/MJRefresh.h>

#import "MLBSingleReadDetailsViewController.h"

#import "MLBUIFactory.h"
#import "MLBhttpRequester.h"
#import "UIScrollView+MLBEndMJRefreshing.h"
#import "MLBComment.h"

NSString *const KMLReadDetailsID = @"KMLReadDetailsID";

@interface MLBReadDetailsView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) MLBReadDetailsContentCell *contentCell;

@property (strong, nonatomic) UIButton *praiseButton;
@property (strong, nonatomic) UIButton *commentButton;
@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UILabel *praiseCountLabel;
@property (strong, nonatomic) UIButton *commentCountButton;
@property (strong, nonatomic) UIToolbar *bottomBar;

@property (strong, nonatomic) MLBSerialCollectionView *serialCollectionView;

@property (assign, nonatomic) MLBReadType viewType;
@property (strong, nonatomic) MLBBaseModel *readModel;
@property (strong, nonatomic) MLBBaseModel *readDetailsModel;
@property (strong, nonatomic) NSArray *relatedList;

@property (strong, nonatomic) MASConstraint *bottomBarBottomOffsetConstraint;

@property (strong, nonatomic) MLBCommentList *commentList;

@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (assign, nonatomic) BOOL showBottomBar;
@end

@implementation MLBReadDetailsView

#pragma mark - LifeCycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config];
    }
    return self;
}

#pragma mark - Getter Method

- (MLBSerialCollectionView *)serialCollectionView{
    if (_serialCollectionView) {
        return _serialCollectionView;
    }
    _serialCollectionView = [[MLBSerialCollectionView alloc] init];
    __weak typeof(self) weakSelf = self;
    _serialCollectionView.didSelectedSerial = ^(MLBReadSerial *readSerail) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.serialCollectionView dismissWithCompleted:^{
            [strongSelf showSingleReadDetailWithReadModel:readSerail];
        }];
    };
    return _serialCollectionView;
}

- (NSOperationQueue *)operationQueue{
    if (_operationQueue) {
        return _operationQueue;
    }
    _operationQueue = [NSOperationQueue mainQueue];
    _operationQueue.maxConcurrentOperationCount = 1;
    return _operationQueue;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!_readDetailsModel) {
        return 0;
    }
    
    return 4; // 内容 + 推荐 + 热门评论 + 普通评论
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.viewType == 0) {
        switch (self.viewType) {
            case MLBReadTypeEssay:
            case MLBReadTypeSerial:
                return 4; // 作者信息 + 标题 + 内容 + 作者介绍
                break;
            case MLBReadTypeQuestion:
                return 3;// 问题 + 回答作者及时间 + 回答内容
                break;
        }
    }else if (self.viewType == 1 && self.relatedList){
        return self.relatedList.count;
    }else if (self.viewType == 2 && self.commentList){
        return self.commentList.hotComments.count;
    }else if (self.viewType == 3 && self.commentList){
        return self.commentList.comments.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.viewType) {
        case MLBReadTypeEssay:
        case MLBReadTypeSerial:
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {// 作者信息
                    MLBReadDetailsAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLReadDetailsAuthorCellID forIndexPath:indexPath];
                    [self configureAuthorCell:cell];
                    return cell;
                }else if (indexPath.row == 1){// 标题
                    MLBReadDetailsTitleAndOperationCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLReadDetailsTitleAndOperationCellID forIndexPath:indexPath];
                    [self configureTitleCell:cell];
                    __weak typeof(self) weakSelf = self;
                    if (!cell.serialsClicked) {
                        cell.serialsClicked = ^(){
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            strongSelf.serialCollectionView.readSerail = (MLBReadSerial *)strongSelf.readModel;
                            [strongSelf.serialCollectionView show];
                        };
                    }
                    return cell;
                }else if (indexPath.row == 2){// 内容
                    if (!self.contentCell) {
                        self.contentCell = [tableView dequeueReusableCellWithIdentifier:KMLReadDetailsContentCellID forIndexPath:indexPath];
                        [self configureContentCell:self.contentCell];
                    }
                    return self.contentCell;
                }else if (indexPath.row == 3){// 作者介绍
                    MLBReadDetailsAuthorInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLReadDetailsAuthorInfoCellID forIndexPath:indexPath];
                    [self configureAuthorInfoCell:cell];
                    return cell;
                }
            }
            break;
        case MLBReadTypeQuestion:
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    MLBReadDetailsQuestionTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLReadDetailsQuestionTitleCellID forIndexPath:indexPath];
                    [cell configureCellWithQuestionDetails:(MLBReadQuestionDetails *)self.readDetailsModel];
                    return cell;
                }else if (indexPath.row == 1){
                    MLBReadDetailsQuestionAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLReadDetailsQuestionAnswerCellID forIndexPath:indexPath];
                    [cell configureCellWithQuestionDetails:(MLBReadQuestionDetails *)self.readDetailsModel];
                    return cell;
                }else if (indexPath.row == 2){
                    if (!self.contentCell) {
                        self.contentCell = [tableView dequeueReusableCellWithIdentifier:KMLReadDetailsContentCellID forIndexPath:indexPath];
                        [self configureContentCell:self.contentCell];
                    }
                    return self.contentCell;
                }
            }
            break;
    }
    if (indexPath.section == 1) {
        MLBReadBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLReadBaseCellID forIndexPath:indexPath];
        if (indexPath.row < self.relatedList.count) {
            [cell configureCellWithBaseModel:self.relatedList[indexPath.row]];
        }
        return cell;
    }else if (indexPath.section == 2 || indexPath.section == 3){
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

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 && _relatedList && _relatedList.count > 0) { // 相关推荐
        return [MLBCommonHeaderFooterView viewHeight];
    } else if (section == 2 && [self hasComments]) { // 评论列表
        return [MLBCommonHeaderFooterView viewHeight];
    }
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2 && _commentList && _commentList.hotComments.count > 0) { // 以上是热门评论
        return [MLBCommonHeaderFooterView viewHeight];
    }
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_viewType) {
        case MLBReadTypeEssay:
        case MLBReadTypeSerial: {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) { // 作者信息
                    __weak typeof(self) weakSelf = self;
                    return [tableView fd_heightForCellWithIdentifier:KMLReadDetailsAuthorCellID cacheByIndexPath:indexPath configuration:^(MLBReadDetailsAuthorCell *cell) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [strongSelf configureAuthorCell:cell];
                    }];
                } else if (indexPath.row == 1) { // 标题
                    __weak typeof(self) weakSelf = self;
                    return [tableView fd_heightForCellWithIdentifier:KMLReadDetailsTitleAndOperationCellID cacheByIndexPath:indexPath configuration:^(MLBReadDetailsTitleAndOperationCell *cell) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [strongSelf configureTitleCell:cell];
                    }];
                } else if (indexPath.row == 2) { // 内容
                    if (!_readDetailsModel) {
                        return 0;
                    }
                    
                    __weak typeof(self) weakSelf = self;
                    return [tableView fd_heightForCellWithIdentifier:KMLReadDetailsContentCellID cacheByIndexPath:indexPath configuration:^(MLBReadDetailsContentCell *cell) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [strongSelf configureContentCell:cell];
                    }];
                } else if (indexPath.row == 3) { // 作者介绍
                    __weak typeof(self) weakSelf = self;
                    return [tableView fd_heightForCellWithIdentifier:KMLReadDetailsAuthorInfoCellID cacheByIndexPath:indexPath configuration:^(MLBReadDetailsAuthorInfoCell *cell) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [strongSelf configureAuthorInfoCell:cell];
                    }];
                }
            }
        }
            break;
        case MLBReadTypeQuestion: {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) { // 问题
                    __weak typeof(self) weakSelf = self;
                    return [tableView fd_heightForCellWithIdentifier:KMLReadDetailsQuestionTitleCellID cacheByIndexPath:indexPath configuration:^(MLBReadDetailsQuestionTitleCell *cell) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [cell configureCellWithQuestionDetails:(MLBReadQuestionDetails *)strongSelf.readDetailsModel];
                    }];
                } else if (indexPath.row == 1) { // 回答作者及时间
                    __weak typeof(self) weakSelf = self;
                    return [tableView fd_heightForCellWithIdentifier:KMLReadDetailsQuestionAnswerCellID cacheByIndexPath:indexPath configuration:^(MLBReadDetailsQuestionAnswerCell *cell) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [cell configureCellWithQuestionDetails:(MLBReadQuestionDetails *)strongSelf.readDetailsModel];
                    }];
                } else if (indexPath.row == 2) { // 回答内容
                    if (!_readDetailsModel) {
                        return 0;
                    }
                    
                    __weak typeof(self) weakSelf = self;
                    return [tableView fd_heightForCellWithIdentifier:KMLReadDetailsContentCellID cacheByIndexPath:indexPath configuration:^(MLBReadDetailsContentCell *cell) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [strongSelf configureContentCell:cell];
                    }];
                }
            }
        }
            break;
    }
    
    if (indexPath.section == 1) {
        __weak typeof(self) weakSelf = self;
        return [tableView fd_heightForCellWithIdentifier:KMLReadBaseCellID cacheByIndexPath:indexPath configuration:^(MLBReadBaseCell *cell) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (indexPath.row < strongSelf.relatedList.count) {
                [cell configureCellWithBaseModel:strongSelf.relatedList[indexPath.row]];
            }
        }];
    } else if (indexPath.section == 2 || indexPath.section == 3) {
        __weak typeof(self) weakSelf = self;
        return [tableView fd_heightForCellWithIdentifier:KMLCommentCellID cacheByIndexPath:indexPath configuration:^(MLBCommentCell *cell) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [cell configureCellForCommonWithComment:[strongSelf commentAtIndexPath:indexPath] atIndexPath:indexPath];
        }];
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1 && _relatedList && _relatedList.count > 0) { // 相关推荐
        MLBCommonHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kMLBCommonHeaderFooterViewIDForTypeHeader];
        view.viewType = MLBCommonHeaderFooterViewTypeRelatedRec;
        
        return view;
    } else if (section == 2 && [self hasComments]) { // 评论列表
        MLBCommonHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kMLBCommonHeaderFooterViewIDForTypeHeader];
        view.viewType = MLBCommonHeaderFooterViewTypeComment;
        
        return view;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2 && _commentList && _commentList.hotComments.count > 0) { // 以上是热门评论
        MLBCommonHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kMLBCommonHeaderFooterViewIDForTypeHeader];
        view.viewType = MLBCommonHeaderFooterViewTypeAboveIsHotComments;
        
        return view;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) { // 相关推荐
        [self showSingleReadDetailWithReadModel:self.relatedList[indexPath.row]];
    }
}

#pragma mark - Private Method

-(void)config{
    [self setupViews];
    [self initData];
}

-(void)initData{
    self.viewIndex = -1;
}

-(void)setupViews{
    if (self.tableView) {
        return;
    }
    self.backgroundColor = [UIColor whiteColor];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[MLBCommonHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kMLBCommonHeaderFooterViewIDForTypeHeader];
        [tableView registerClass:[MLBReadDetailsAuthorCell class] forCellReuseIdentifier:KMLReadDetailsAuthorCellID];
        [tableView registerClass:[MLBReadDetailsTitleAndOperationCell class] forCellReuseIdentifier:KMLReadDetailsTitleAndOperationCellID];
        [tableView registerClass:[MLBReadDetailsContentCell class] forCellReuseIdentifier:KMLReadDetailsContentCellID];
        [tableView registerClass:[MLBReadDetailsAuthorInfoCell class] forCellReuseIdentifier:KMLReadDetailsAuthorInfoCellID];
        [tableView registerClass:[MLBReadBaseCell class] forCellReuseIdentifier:KMLReadBaseCellID];
        [tableView registerClass:[MLBCommentCell class] forCellReuseIdentifier:KMLCommentCellID];
        [tableView registerClass:[MLBReadDetailsQuestionTitleCell class] forCellReuseIdentifier:KMLReadDetailsQuestionTitleCellID];
        [tableView registerClass:[MLBReadDetailsQuestionAnswerCell class] forCellReuseIdentifier:KMLReadDetailsQuestionAnswerCellID];
        tableView.tableFooterView = [UIView new];
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 44, 0);
        tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        tableView;
    });
    
    self.bottomBar = ({
        UIToolbar *toolBar = [[UIToolbar alloc] init];
        [self addSubview:toolBar];
        [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(44);
            _bottomBarBottomOffsetConstraint = make.bottom.equalTo(self).offset(44);
        }];
        toolBar;
    });
    
    self.praiseButton = ({
        UIButton *praiseButton = [MLBUIFactory buttonWithImageName:@"like_normal" selectedImageName:@"like_selected" target:self action:@selector(praiseButtonSelected)];
        praiseButton.backgroundColor = [UIColor clearColor];
        [self.bottomBar addSubview:praiseButton];
        [praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(praiseButton.mas_height).multipliedBy(1.0);
            make.top.left.bottom.equalTo(self.bottomBar);
        }];
        praiseButton;
    });
    
    self.commentButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:@"icon_toolbar_comment" selectedImageName:nil target:self action:@selector(commontButtonClick)];
        button.backgroundColor = [UIColor clearColor];
        [self.bottomBar addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.bottom.equalTo(self.praiseButton);
            make.left.equalTo(self.praiseButton.mas_right);
        }];
        button;
    });
    
    self.shareButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:@"share_image" selectedImageName:nil target:self action:@selector(shareButtonClick)];
        button.backgroundColor = [UIColor clearColor];
        [self.bottomBar addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.bottom.equalTo(self.praiseButton);
            make.left.equalTo(self.commentButton.mas_right);
        }];
        button;
    });
    
    self.praiseCountLabel = ({
        UILabel *lable = [UILabel new];
//        lable.backgroundColor = UIColor
        [self.bottomBar addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.bottomBar);
        }];
        lable;
    });
    
    self.commentCountButton = ({
        UIButton *button = [MLBUIFactory buttonWithTitle:@"0" titleColor:MLBDarkGrayTextColor fontSize:13 target:self action:@selector(commentCountButtonClick)];
        [self.bottomBar addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.bottomBar).insets(UIEdgeInsetsMake(0, 0, 0, 15));
            make.left.equalTo(self.praiseCountLabel.mas_right);
        }];
        button;
    });
}

-(void)updatePraiseCount:(NSInteger)praiseCount{
    self.praiseCountLabel.text = [NSString stringWithFormat:@"%ld 赞 ・ ",praiseCount];
}

-(void)updateCommentCount:(NSInteger)commentCount{
    [self.commentCountButton setTitle:[NSString stringWithFormat:@"%ld 评论",commentCount] forState:UIControlStateNormal];
}

-(void)preUpdateViews{
    [self updatePraiseCount:0];
    [self updateCommentCount:0];
    
    [_tableView reloadData];
}

-(void)updateViewsAfterRequestDetails{
    [self.tableView reloadData];
    switch (self.viewType) {
        case MLBReadTypeEssay:
            [self updatePraiseCount:((MLBReadEssayDetails *)self.readDetailsModel).praiseNum];
            [self updateCommentCount:((MLBReadEssayDetails *)self.readDetailsModel).commentNum];
            break;
        case MLBReadTypeSerial:
            [self updatePraiseCount:((MLBReadSerialDetails *)self.readDetailsModel).praiseNum];
            [self updateCommentCount:((MLBReadSerialDetails *)self.readDetailsModel).commentNum];
            break;
        case MLBReadTypeQuestion:
            [self updatePraiseCount:((MLBReadQuestionDetails *)self.readDetailsModel).praiseNum];
            [self updateCommentCount:((MLBReadQuestionDetails *)self.readDetailsModel).commentNum];
            break;
        default:
            break;
    }
    
    if (!self.bottomBar) {
        self.showBottomBar = YES;
        self.bottomBarBottomOffsetConstraint.offset(0);
        [self.bottomBar setNeedsLayout];
        [UIView animateWithDuration:0.5 animations:^{
            [self.bottomBar layoutIfNeeded];
        }];
    }
    
    if (self.tableView.mj_header) {
        [self.tableView mlb_addRefreshingWithTarget:self refreshAction:@selector(tableviewRefresh) loadMoreDataAction:@selector(loadMoreComments)];
    }
    
    [self requestRelateds];
    [self requestComments];
}

-(Class)modelClass{
    return self.viewType == MLBReadTypeEssay ? [MLBReadEssay class] : (self.viewType == MLBReadTypeSerial ? [MLBReadSerial class] : [MLBReadQuestion class]);
}

-(Class)detailsModelClass{
    return (_viewType == MLBReadTypeEssay ? [MLBReadEssayDetails class] : (_viewType == MLBReadTypeSerial ? [MLBReadSerialDetails class] : [MLBReadQuestionDetails class]));
}

-(NSString *)contentId{
    return (_viewType == MLBReadTypeEssay ? ((MLBReadEssay *)_readModel).contentId : (_viewType == MLBReadTypeSerial ? ((MLBReadSerial *)_readModel).contentId : ((MLBReadQuestion *)_readModel).questionId));
}

- (BOOL)hasComments {
    return _commentList && (_commentList.hotComments.count > 0 || _commentList.comments.count > 0);
}

-(MLBComment *)commentAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row < self.commentList.hotComments.count) {
        return self.commentList.hotComments[indexPath.row];
    }else if (indexPath.section == 3 && indexPath.row < _commentList.comments.count){
        return self.commentList.comments[indexPath.row];
    }
    return nil;
}

#pragma mark - Public Method

-(void)prepareForReuseWithViewType:(MLBReadType)type{
    _readDetailsModel = nil;
    _relatedList = nil;
    [_commentList.hotComments removeAllObjects];
    [_commentList.comments removeAllObjects];
    _commentList = nil;
    _contentCell = nil;
    
    [self preUpdateViews];
}

-(void)configureViewWithReadModel:(MLBBaseModel *)model type:(MLBReadType)type atIndex:(NSInteger)index inViewController:(MLBBaseViewController *)parentViewController{
    self.viewIndex = index;
    self.parentViewController = parentViewController;
    self.viewType = type;
    self.readModel = model;
    [self requestDetails];
}

#pragma mark - Action

-(void)showSingleReadDetailWithReadModel:(MLBBaseModel *)model{
    MLBSingleReadDetailsViewController *singleReadDetailsViewController = [[MLBSingleReadDetailsViewController alloc] init];
    singleReadDetailsViewController.readType = self.viewType;
    singleReadDetailsViewController.readModel = model;
    [self.parentViewController.navigationController pushViewController:singleReadDetailsViewController animated:YES];
}

-(void)praiseButtonSelected{
    
}

-(void)commontButtonClick{
    
}

-(void)shareButtonClick{
    
}

-(void)commentCountButtonClick{
    
}

-(void)requestDetails{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestReeadDetailsWithType:[MLBhttpRequester apiStringForReadWithReadType:self.viewType] itemId:[self contentId] success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf processingForDetailsWithResponseObject:responseObject];
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf showHUDServerError];
    }];
}

-(void)tableviewRefresh{
    
}

-(void)loadMoreComments{
    
}

#pragma mark - Network Request

-(void)requestRelateds{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestRelatedWithType:[MLBhttpRequester apiStringForReadWithReadType:self.viewType] itemId:[self contentId] success:^(id responseObject) {
       __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf processingForRelatedWithResponseObject:responseObject];
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf showHUDServerError];
    }];
}

-(void)requestComments{
    NSString *commentId = @"0";
    if (self.commentList && self.commentList.comments.count > 0) {
        commentId = ((MLBComment *)[self.commentList.comments lastObject]).commentId;
    }
    
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestPraiseAndTimeCommentWithType:self.viewType itemId:[self contentId] lastCommentId:commentId success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf processingForCommentsWithResponseObject:responseObject];
    } fali:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf showHUDServerError];
    }];
}

#pragma mark - Data Processing

-(void)processingForDetailsWithResponseObject:(id)responseObject{
    if ([responseObject[@"res"] integerValue] == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error;
            MLBBaseModel *details = [MTLJSONAdapter modelOfClass:[self detailsModelClass] fromJSONDictionary:responseObject[@"data"] error:&error];
            if (!error) {
                self.readDetailsModel = details;
                dispatch_async(dispatch_get_main_queue(), ^{
                    DDLogDebug(@"%@ finish, viewIndex = %ld",NSStringFromSelector(_cmd),self.viewIndex);
                    [self updateViewsAfterRequestDetails];
                });
            }else{
                DDLogDebug(@"%@ error = %@",NSStringFromSelector(_cmd),error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showHUDErrorWithText:@"数据解析失败"];
                });
            }
        });
    }else{
        [self showHUDErrorWithText:@"数据获取失败"];
    }
}

-(void)processingForRelatedWithResponseObject:(id)responseObject{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            NSArray<MLBBaseModel *> *array = [MTLJSONAdapter modelsOfClass:[self modelClass] fromJSONArray:responseObject[@"data"] error:&error];
            if (error) {
                [self showHUDModelTransformFailedWithError:error];
            }else{
                self.relatedList = array;
                DDLogDebug(@"%@ finish,viewIndex = %ld",NSStringFromSelector(_cmd),self.viewIndex);
                if (self.readDetailsModel) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.operationQueue cancelAllOperations];
                        [self.operationQueue addOperationWithBlock:^{
                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                        }];
                    });
                }
            }
        }else{
            [self showHUDErrorWithText:@"数据解析出错"];
        }
    });
    
}

-(void)processingForCommentsWithResponseObject:(id)responseObject{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            MLBCommentList *cmList = [MTLJSONAdapter modelOfClass:[MLBCommentList class] fromJSONDictionary:responseObject[@"data"] error:&error];
            if (!error) {
                if (!self.commentList) {
                    self.commentList = [[MLBCommentList alloc] init];
                    self.commentList.count = cmList.count;
                    self.commentList.comments = @[].mutableCopy;
                    self.commentList.hotComments = @[].mutableCopy;
                }
                MLBComment *lastHotComment;
                for (MLBComment *comment in cmList.comments) {
                    if (comment.commentType == MLBCommentTypeHot) {
                        lastHotComment = comment;
                        [self.commentList.hotComments addObject:comment];
                    }else{
                        [self.commentList.comments addObject:comment];
                    }
                }
                
                NSMutableArray *indexPaths;
                if (lastHotComment) {
                    lastHotComment.lastHotComment = YES;
                }else{
                    indexPaths = [NSMutableArray arrayWithCapacity:cmList.comments.count];
                    for (NSInteger i = (self.commentList.comments.count - cmList.comments.count); i < self.commentList.comments.count; i++) {
                        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:3]];
                    }
                }
                DDLogDebug(@"%@ finished, viewindex = %ld tableView = %p",NSStringFromSelector(_cmd),self.viewIndex,self.tableView);
                
                if (self.readDetailsModel) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView mlb_endRefreshingHasMoreData:(self.commentList.comments.count != self.commentList.count || cmList.comments.count >= 20)];
                        
                        if (cmList.comments.count > 0) {
                            [self.operationQueue cancelAllOperations];
                            [self.operationQueue addOperationWithBlock:^{
                                if (lastHotComment) {
                                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 2)] withRowAnimation:UITableViewRowAnimationNone];
                                }else{
                                    if (indexPaths && indexPaths.count > 0) {
                                        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                                    }
                                }
                            }];
                        }
                        
                    });
                }
            }
        }
    });
}

#pragma mark - Configure Cells

-(void)configureAuthorCell:(MLBReadDetailsAuthorCell *)cell{
    if (_viewType == MLBReadTypeEssay) {
        [cell configureCellWithEssayDetails:(MLBReadEssayDetails *)_readDetailsModel];
    } else if (_viewType == MLBReadTypeSerial) {
        [cell configureCellWithSerialDetails:(MLBReadSerialDetails *)_readDetailsModel];
    }
}

-(void)configureTitleCell:(MLBReadDetailsTitleAndOperationCell *)cell{
    if (_viewType == MLBReadTypeEssay) {
        cell.titleLable.text = ((MLBReadEssay *)_readModel).title;
        cell.serialsButton.hidden = YES;
    } else if (_viewType == MLBReadTypeSerial) {
        cell.titleLable.text = ((MLBReadSerial *)_readModel).title;
        cell.serialsButton.hidden = NO;
    }
}

-(void)configureContentCell:(MLBReadDetailsContentCell *)cell{
    switch (_viewType) {
        case MLBReadTypeEssay: {
            [cell configureCellWithContent:((MLBReadEssayDetails *)_readDetailsModel).content editor:((MLBReadEssayDetails *)_readDetailsModel).chargeEditor];
            break;
        }
        case MLBReadTypeSerial: {
            [cell configureCellWithContent:((MLBReadSerialDetails *)_readDetailsModel).content editor:((MLBReadSerialDetails *)_readDetailsModel).chargeEditor];
            break;
        }
        case MLBReadTypeQuestion: {
            [cell configureCellWithContent:((MLBReadQuestionDetails *)_readDetailsModel).answerContent editor:((MLBReadQuestionDetails *)_readDetailsModel).chargeEditor];
            break;
        }
    }
}

-(void)configureAuthorInfoCell:(MLBReadDetailsAuthorInfoCell *)cell{
    switch (_viewType) {
        case MLBReadTypeEssay: {
            [cell configureCellWithAuthor:[((MLBReadEssayDetails *)_readDetailsModel).authors firstObject]];
            break;
        }
        case MLBReadTypeSerial: {
            [cell configureCellWithAuthor:((MLBReadSerialDetails *)_readDetailsModel).author];
            break;
        }
        case MLBReadTypeQuestion: {
            break;
        }
    }
}

-(void)commentCellButtonClickedWithType:(MLBCommentCellButtonType)type indexPath:(NSIndexPath *)indexPath{
    switch (type) {
        case MLBCommentCellButtonTypeUserAvatar:
            
            break;
        case MLBCommentCellButtonTypePraise:
            
            break;
        case MLBCommentCellButtonTypeUnfold:{
            MLBComment *comment = [self commentAtIndexPath:indexPath];
            if (!comment.isUnfolded) {
                comment.unfolded = YES;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            break;
        }
    }
}


@end




















