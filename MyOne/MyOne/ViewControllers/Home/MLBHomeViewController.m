//
//  MLBHomeViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/15.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBHomeViewController.h"
#import "MLBHomeView.h"
#import "MLBUIFactory.h"
#import "MLBHomeItem.h"
#import "MLBPreviousViewController.h"
#import "UIView+MyOne.h"
#import "MLBhttpRequester.h"
@interface MLBHomeViewController ()<GMCPagingScrollViewDataSource,GMCPagingScrollViewDelegate>{
    AAPullToRefresh *pullToRefreshLeft;
    AAPullToRefresh *pullToRefreshRight;
}

@property(nonatomic,strong)GMCPagingScrollView *pagingScrollView;
@property(nonatomic,strong)UIButton *diaryButton;
@property(nonatomic,strong)UIButton *likeButton;
@property(nonatomic,strong)UILabel *likeNumLable;
@property(nonatomic,strong)UIButton *moreButton;

@property(nonatomic,strong)NSArray *dataSource;

@end

@implementation MLBHomeViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    pullToRefreshLeft.showPullToRefresh = NO;
    pullToRefreshRight.showPullToRefresh = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeAll;
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_home_title"]];
    self.navigationItem.titleView = titleView;
    [self addNavigationBarLeftBarItem];
    [self addNavigationBarRightMeItem];
    
    [self initDatas];
    [self setupViews];
    [self loadCaches];
    [self requestHomeMore];
}

#pragma mark - Private Method

-(void)initDatas{
    
}

-(void)setupViews{
    __weak typeof(self) weakSelf = self;
    self.pagingScrollView = ({
        GMCPagingScrollView *pagingScrollView = [[GMCPagingScrollView alloc] init];
        pagingScrollView.backgroundColor = [UIColor whiteColor];
        [pagingScrollView registerClass:[MLBHomeView class] forReuseIdentifier:KMLHomeViewId];
        pagingScrollView.dataSource = self;
        pagingScrollView.delegate = self;
        pagingScrollView.pageInsets = UIEdgeInsetsZero;
        pagingScrollView.interpageSpacing = 0;
        pullToRefreshLeft = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionLeft actionHandler:^(AAPullToRefresh *v) {
            [weakSelf refreshHomemore];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToRefreshLeft.threshold = 100;
        pullToRefreshLeft.borderColor = MLBAppThemeColor;
        pullToRefreshLeft.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRefreshLeft.imageIcon = [UIImage new];
        
        pullToRefreshRight = [self.pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionRight actionHandler:^(AAPullToRefresh *v) {
            [weakSelf showPreviousList];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToRefreshRight.borderColor = MLBAppThemeColor;
        pullToRefreshRight.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRefreshRight.imageIcon = [UIImage new];
        [self.view addSubview:pagingScrollView];
        [pagingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        pagingScrollView.hidden = YES;
        pagingScrollView;
    });
    
    self.diaryButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:@"diary_normal" highLightImageName:nil target:self action:@selector(diaryButtonClicked)];
        [self.pagingScrollView insertSubview:button atIndex:0];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.left.equalTo(self.pagingScrollView).offset(12);
            make.bottom.equalTo(self.pagingScrollView).offset(-80);
        }];
        button;
    });
    
    self.moreButton = ({
        UIButton *moreButton = [MLBUIFactory buttonWithImageName:@"share_image" highLightImageName:nil target:self action:@selector(moreButtonClicked)];
        [self.pagingScrollView insertSubview:moreButton atIndex:1];
        [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.right.equalTo(self.pagingScrollView).offset(-8);
            make.bottom.equalTo(self.diaryButton);
        }];
        moreButton;
    });
    
    self.likeNumLable = ({
        UILabel *lable = [[UILabel alloc] init];
        lable.textColor = MLBDarkGrayTextColor;
        lable.font = FontWithSize(11);
        [self.pagingScrollView insertSubview:lable atIndex:2];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.right.equalTo(self.moreButton.mas_left);
            make.bottom.equalTo(self.diaryButton);
        }];
        lable;
    });
    
    self.likeButton = ({
        UIButton *likeButton = [MLBUIFactory buttonWithImageName:@"like_normal" highLightImageName:@"like_selected" target:self action:@selector(likeButtonClicked)];
        [self.pagingScrollView insertSubview:likeButton atIndex:3];
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.moreButton);
            make.right.equalTo(self.likeNumLable.mas_left);
            make.bottom.equalTo(self.diaryButton);
        }];
        likeButton;
    });
}

-(void)loadCaches{
    id cacheItem = [NSKeyedUnarchiver unarchiveObjectWithFile:MLBCacheHomeItemFilePath];
    if (cacheItem) {
        self.dataSource =  cacheItem;
    }
}

#pragma mark NetWork Request

-(void)requestHomeMore{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestHomeMoreWithSuccess:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            NSArray *items = [MTLJSONAdapter modelsOfClass:[MLBHomeItem class] fromJSONArray:responseObject[@"data"] error:&error];
            if (!error) {
                strongSelf.dataSource = items;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [NSKeyedArchiver archiveRootObject:strongSelf.dataSource toFile:MLBCacheHomeItemFilePath];
                });
            }else{
                [strongSelf.view showHUDModelTransformFailedWithError:error];
            }
        }else{
            [strongSelf.view showHUDErrorWithText:responseObject[@"msg"]];
        }
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf.view showHUDServerError];
    }];
}

#pragma mark - DataSource

- (NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView{
    return self.dataSource.count;
}

- (UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index{
    MLBHomeView *homeView = [pagingScrollView dequeueReusablePageWithIdentifier:KMLHomeViewId];
    [homeView configureViewWithHomeItem:[self homeItemAtIndex:index] atIndex:index inViewController:self];
    return homeView;
}

#pragma mark - Delegate

- (void)pagingScrollViewDidScroll:(GMCPagingScrollView *)pagingScrollView{
    if (self.pagingScrollView.isDragging) {
        CGPoint contentOffset = pagingScrollView.scrollView.contentOffset;
        pagingScrollView.scrollView.contentOffset = CGPointMake(contentOffset.x, 0);
    }
}

- (void)pagingScrollView:(GMCPagingScrollView *)pagingScrollView didScrollToPageAtIndex:(NSUInteger)index{
    [self updateLikeNumLabelTextWithItemIndex:index];
}

#pragma mark - Setter Method

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    self.pagingScrollView.hidden = NO;
    [self.pagingScrollView reloadData];
    [self.pagingScrollView setCurrentPageIndex:0];
    if (dataSource.count > 0) {
        [self updateLikeNumLabelTextWithItemIndex:0];
    }
}

#pragma mark Private Method

-(MLBHomeItem *)homeItemAtIndex:(NSInteger)index{
    return self.dataSource[index];
}

-(void)updateLikeNumLabelTextWithItemIndex:(NSInteger)index{
    self.likeNumLable.text = [@([self homeItemAtIndex:index].praiseNum) stringValue];
}

#pragma mark - Action Method

-(void)diaryButtonClicked{
    [self presentLoginOptionsViewController];
}

-(void)moreButtonClicked{
    [self.view mlb_showPopMenuViewWithMenuSelectedBlock:^(MLBPopMenuType menuType) {
        DDLogDebug(@"menuType = %ld",menuType);
    }];
}

-(void)likeButtonClicked{
    
}

-(void)refreshHomemore{
//    [self.pagingScrollView setCurrentPageIndex:0 reloadData:NO];
    [self requestHomeMore];
}

-(void)showPreviousList{
    [self.pagingScrollView setCurrentPageIndex:0 reloadData:NO];
    //显示过期列表
    MLBPreviousViewController *previousVC = [MLBPreviousViewController new];
    previousVC.previousType = MLBPreviousTypeHome;
    [self.navigationController pushViewController:previousVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
