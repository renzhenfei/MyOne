//
//  MLBReadDetailsViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/18.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadDetailsViewController.h"
#import "MLBReadEssay.h"
#import "MLBReadSerial.h"
#import "MLBReadQuestion.h"
#import "MLBReadDetailsView.h"

@interface MLBReadDetailsViewController ()<GMCPagingScrollViewDataSource,GMCPagingScrollViewDelegate>{
    AAPullToRefresh *pullToRefreshLeft;
    AAPullToRefresh *pullToRefreshRight;
}

@property(strong,nonatomic) GMCPagingScrollView *pagingScrollView;
@property(assign,nonatomic) MLBReadType readType;

@end

@implementation MLBReadDetailsViewController

#pragma mark lifecycle

- (void)dealloc
{
    pullToRefreshLeft.showPullToRefresh = NO;
    pullToRefreshRight.showPullToRefresh = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MLBBaseModel *model = [self.dataSource firstObject];
    if (model) {
        if ([model isKindOfClass:[MLBReadEssay class]]) {
            self.title = @"短篇";
            self.readType = MLBReadTypeEssay;
        }else if ([model isKindOfClass:[MLBReadSerial class]]){
            self.title = @"连载";
            self.readType = MLBReadTypeSerial;
        }else if ([model isKindOfClass:[MLBReadQuestion class]]){
            self.title = @"问题";
            self.readType = MLBReadTypeQuestion;
        }else{
            return;
        }
        [self initDatas];
        [self setupViews];
        [self.pagingScrollView setCurrentPageIndex:self.index reloadData:YES];
    }
}

-(void)setupViews{
    __weak typeof(self) weakSelf = self;
    self.pagingScrollView = ({
        GMCPagingScrollView *pagingScrollView = [[GMCPagingScrollView alloc] init];
        pagingScrollView.backgroundColor = [UIColor whiteColor];
        [pagingScrollView registerClass:[MLBReadDetailsView class] forReuseIdentifier:KMLReadDetailsID];
        pagingScrollView.dataSource = self;
        pagingScrollView.delegate = self;
        pagingScrollView.interpageSpacing = 0;
        pagingScrollView.scrollView.alwaysBounceVertical = NO;
        pagingScrollView.numberOfPreloadedPagesOnEachSide = 1;
        
        pullToRefreshLeft = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionLeft actionHandler:^(AAPullToRefresh *v) {
            [weakSelf refresh];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToRefreshLeft.threshold = 100;
        pullToRefreshLeft.borderColor = MLBAppThemeColor;
        pullToRefreshLeft.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRefreshLeft.imageIcon = [UIImage new];
        
        pullToRefreshRight = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionRight actionHandler:^(AAPullToRefresh *v) {
            [weakSelf loadMore];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToRefreshRight.borderColor = MLBAppThemeColor;
        pullToRefreshRight.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRefreshRight.imageIcon = [UIImage new];
        [self.view addSubview:pagingScrollView];
        [pagingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        pagingScrollView;
    });
}

#pragma mark - Private Method

-(void)initDatas{
    if (!(self.index >= 0 && self.index < self.dataSource.count)) {
        self.index = 0;
    }
}

-(void)refresh{
    [self.pagingScrollView setCurrentPageIndex:0 reloadData:NO];
}

-(void)loadMore{
    [self.pagingScrollView setCurrentPageIndex:self.dataSource.count - 1 reloadData:NO];
}

#pragma mark - GMCPagingScrollViewDataSource

- (NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView{
    return self.dataSource.count;
}

- (UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index{
    MLBReadDetailsView *view = [pagingScrollView dequeueReusablePageWithIdentifier:KMLReadDetailsID];
    if (view.viewIndex != index) {
        [view prepareForReuseWithViewType:self.readType];
        if (index == self.index) {
            [view configureViewWithReadModel:_dataSource[index] type:self.readType atIndex:index inViewController:self];
        }
    }
    return view;
}

#pragma mark - GMCPagingScrollViewDelegate

- (void)pagingScrollViewDidScroll:(GMCPagingScrollView *)pagingScrollView {
    if (_pagingScrollView.isDragging) {
        CGPoint contentOffset = pagingScrollView.scrollView.contentOffset;
        pagingScrollView.scrollView.contentOffset = CGPointMake(contentOffset.x, 0);
    }
}

- (void)pagingScrollView:(GMCPagingScrollView *)pagingScrollView didScrollToPageAtIndex:(NSUInteger)index {
    if (index != self.index && (!pagingScrollView.scrollView.isTracking || !pagingScrollView.scrollView.isDecelerating)) {
        MLBReadDetailsView *view = [pagingScrollView pageAtIndex:index];
        if (view.viewIndex != index) {
            [view configureViewWithReadModel:_dataSource[index] type:self.readType atIndex:index inViewController:self];
        }
    }
}

- (void)pagingScrollView:(GMCPagingScrollView *)pagingScrollView didEndDisplayingPage:(UIView *)page atIndex:(NSUInteger)index {
    if (page && [page isKindOfClass:[MLBReadDetailsView class]]) {
        ((MLBReadDetailsView *)page).viewIndex = -1;
    }
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
