//
//  MLBMusicViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/15.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBMusicViewController.h"
#import "MLBMusicView.h"
#import "MLBhttpRequester.h"
#import "MLBRelatedMusic.h"

@interface MLBMusicViewController ()<GMCPagingScrollViewDataSource,GMCPagingScrollViewDelegate>{
    AAPullToRefresh *pullToLeftRefresh;
    AAPullToRefresh *pullToRightRefresh;
}

@property(nonatomic,strong) GMCPagingScrollView *pagingScrollView;
@property(nonatomic,strong) NSArray *dataSource;

@end

@implementation MLBMusicViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = MLBMusicTitle;
    [self addNavigationBarLeftBarItem];
    [self addNavigationBarRightMeItem];
    
    [self initData];
    [self setupView];
    [self requestMusicList];
}

#pragma mark - LifeCycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)dealloc
{
    pullToLeftRefresh.showPullToRefresh = NO;
    pullToRightRefresh.showPullToRefresh = NO;
}

#pragma mark - Private Method

-(void)initData{
    
}

-(void)setupView{
    __weak typeof(self) weakSelf = self;
    self.pagingScrollView = ({
        GMCPagingScrollView *pagingScrollView = [GMCPagingScrollView new];
        pagingScrollView.backgroundColor = MLBViewControllerBGColor;
        [pagingScrollView registerClass:[MLBMusicView class] forReuseIdentifier:KMLMusicViewID];
        pagingScrollView.dataSource = self;
        pagingScrollView.delegate = self;
        pagingScrollView.interpageSpacing = 0;
        pullToLeftRefresh = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionLeft actionHandler:^(AAPullToRefresh *v) {
            [weakSelf refreshHomeMore];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToLeftRefresh.threshold = 100;
        pullToLeftRefresh.borderColor = MLBAppThemeColor;
        pullToLeftRefresh.borderWidth = MLBPullToRefreshBorderWidth;
        pullToLeftRefresh.imageIcon = [UIImage new];
        
        pullToRightRefresh = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionRight actionHandler:^(AAPullToRefresh *v) {
            [weakSelf showPreviousList];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToRightRefresh.threshold = 100;
        pullToRightRefresh.borderColor = MLBAppThemeColor;
        pullToRightRefresh.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRightRefresh.imageIcon = [UIImage new];
        [self.view addSubview:pagingScrollView];
        [pagingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        pagingScrollView.hidden = YES;
        pagingScrollView;
    });
}

-(void)requestMusicList{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestMusicIdListWithSuccess:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ([responseObject[@"res"] integerValue] == 0) {
            strongSelf.dataSource = responseObject[@"data"];
            if (strongSelf.dataSource) {
                strongSelf.pagingScrollView.hidden = strongSelf.dataSource.count == 0;
                if (strongSelf.dataSource.count > 0) {
                    [strongSelf.pagingScrollView reloadData];
                }
            }
        }else{
            [strongSelf.view showHUDErrorWithText:@"数据解析出错"];
        }
        
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf.view showHUDNetError];
    }];
}

#pragma mark - Action

-(void)refreshHomeMore{
    
}

-(void)showPreviousList{
    
}

#pragma mark - DataSource

- (NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView{
    return self.dataSource.count;
}

- (UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index{
    MLBMusicView *musicView = [pagingScrollView dequeueReusablePageWithIdentifier:KMLMusicViewID];
    [musicView prepareForReuse];
    if (index == 0) {
        [musicView configureViewWithMusicId:self.dataSource[index] indexpath:index inViewController:self];
    }
    return musicView;
}

@end
