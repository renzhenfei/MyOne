//
//  MLBReadViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/15.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadViewController.h"
#import "MLBReadIndex.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "MLBReadBaseView.h"
#import "MLBReadCarouselItem.h"
#import "MLBhttpRequester.h"
#import "MLBPreviousViewController.h"
#import "MLBTopTenArticalViewController.h"
#import "MLBReadDetailsViewController.h"

@interface MLBReadViewController ()<GMCPagingScrollViewDataSource,GMCPagingScrollViewDelegate>{
    AAPullToRefresh *pullToRefreshLeft;
    AAPullToRefresh *pullToRefreshRight;
}

@property(strong,nonatomic) SDCycleScrollView *carouselView;
@property(strong,nonatomic) GMCPagingScrollView *pagingScrollView;

@property(strong,nonatomic) NSArray *carousels;
@property(strong,nonatomic) MLBReadIndex *readIndex;

@end

@implementation MLBReadViewController{
    NSMutableArray *carouselCovers;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = MLBReadTitle;
    [self addNavigationBarLeftBarItem];
    [self addNavigationBarRightMeItem];
    
    [self initDatas];
    [self setupViews];
    [self loadCache];
    [self requestCarousel];
    [self requestIndex];
}

#pragma mark - Private Method

-(void)initDatas{
    carouselCovers = [NSMutableArray array];
}

-(void)setupViews{
    __weak typeof(self) weakSelf = self;
    self.carouselView = ({
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView new];
        cycleScrollView.backgroundColor = MLBColorAAAAAA;
        cycleScrollView.placeholderImage = [UIImage imageNamed:@"top10"];
        cycleScrollView.autoScrollTimeInterval = 5;
        cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            [weakSelf showTopTenAeticalWithIndex:currentIndex];
        };
        [self.view addSubview:cycleScrollView];
        [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.mas_equalTo(143.5);
        }];
        cycleScrollView;
    });
    
    self.pagingScrollView = ({
        GMCPagingScrollView *pagingScrollView = [GMCPagingScrollView new];
        pagingScrollView.backgroundColor = MLBViewControllerBGColor;
        [pagingScrollView registerClass:[MLBReadBaseView class] forReuseIdentifier:KMLReadBaseViewID];
        pagingScrollView.dataSource = self;
        pagingScrollView.delegate = self;
        pagingScrollView.pageInsets = UIEdgeInsetsZero;
        pagingScrollView.interpageSpacing = 0;
        pullToRefreshLeft = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionLeft actionHandler:^(AAPullToRefresh *v){
            [weakSelf refreshReadIndex];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToRefreshLeft.threshold = 100;
        pullToRefreshLeft.borderColor = MLBAppThemeColor;
        pullToRefreshLeft.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRefreshLeft.imageIcon = [UIImage new];
        
        pullToRefreshRight = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionRight actionHandler:^(AAPullToRefresh *v) {
            [weakSelf loadMoreReadIndex];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToRefreshRight.borderColor = MLBAppThemeColor;
        pullToRefreshRight.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRefreshRight.imageIcon = [UIImage new];
        
        [self.view addSubview:pagingScrollView];
        [pagingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.top.equalTo(self.carouselView.mas_bottom);
        }];
        pagingScrollView.hidden = YES;
        pagingScrollView;
    });
}

-(void)refreshReadIndex{
    [self.pagingScrollView setCurrentPageIndex:0 reloadData:NO];
}

-(void)loadCache{
    id cacheCarousels = [NSKeyedUnarchiver unarchiveObjectWithFile:MLBCacheReadCarouselFilePath];
    if (cacheCarousels) {
        self.carousels = cacheCarousels;
        [self setupCarouselViewDataSource];
    }
    id cacheReadIndex = [NSKeyedUnarchiver unarchiveObjectWithFile:MLBCacheReadIndexFilePath];
    if (cacheReadIndex) {
        self.readIndex = cacheReadIndex;
        self.pagingScrollView.hidden = NO;
        [self.pagingScrollView reloadData];
    }
}

-(void)setupCarouselViewDataSource{
    [carouselCovers removeAllObjects];
    for (MLBReadCarouselItem *carouse in self.carousels) {
        [carouselCovers addObject:carouse.cover];
    }
    self.carouselView.imageURLStringsGroup = carouselCovers;
}

#pragma mark -NetWork Request

-(void)requestCarousel{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestReadCarouseWithSuccess:^(id responseObject) {
       __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            NSArray *carouselArray = [MTLJSONAdapter modelsOfClass:[MLBReadCarouselItem class] fromJSONArray:responseObject[@"data"] error:&error];
            if (!error) {
                strongSelf.carousels = carouselArray.copy;
                [strongSelf setupCarouselViewDataSource];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [NSKeyedArchiver archiveRootObject:strongSelf.carousels toFile:MLBCacheReadCarouselFilePath];
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

-(void)requestIndex{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestReadIndexWithSuccess:^(id responseObject) {
       __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            NSLog(@"%@",responseObject);
            strongSelf.readIndex = [MTLJSONAdapter modelOfClass:[MLBReadIndex class] fromJSONDictionary:responseObject[@"data"] error:&error];
            if (!error) {
                strongSelf.pagingScrollView.hidden = NO;
                [strongSelf.pagingScrollView reloadData];
                
                [strongSelf.pagingScrollView setCurrentPageIndex:0];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [NSKeyedArchiver archiveRootObject:strongSelf.readIndex toFile:MLBCacheReadIndexFilePath];
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

-(void)loadMoreReadIndex{
    [self.pagingScrollView setCurrentPageIndex:0 reloadData:NO];
    //显示往期列表
    MLBPreviousViewController *previousViewController = [[MLBPreviousViewController alloc] init];
    previousViewController.previousType = MLBPreviousTypeRead;
    [self.navigationController pushViewController:previousViewController animated:YES];
}

-(NSInteger)numberOfMaxIndex{
    return MAX(MAX(self.readIndex.essay.count, self.readIndex.serial.count), self.readIndex.question.count);
}

-(void)openReadDetailsViewControllerWithReadType:(MLBReadType)type index:(NSInteger)index{
    MLBReadDetailsViewController *readDetailViewController = [[MLBReadDetailsViewController alloc] init];
    readDetailViewController.dataSource = type == MLBReadTypeEssay ? self.readIndex.essay : (type == MLBReadTypeSerial ? self.readIndex.serial : self.readIndex.question);
    readDetailViewController.index = index;
    [self.navigationController pushViewController:readDetailViewController animated:YES];
}

#pragma mark - Action

-(void)showTopTenAeticalWithIndex:(NSInteger)index{
    MLBTopTenArticalViewController *controller = [[MLBTopTenArticalViewController alloc] init];
    controller.carouselItem = self.carousels[index];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Lifecycle

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


#pragma mark - Delegate

- (NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView{
    return [self numberOfMaxIndex];
}

- (UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index{
    MLBReadBaseView *view = [pagingScrollView dequeueReusablePageWithIdentifier:KMLReadBaseViewID];
    [view configureViewWithReadEssay:self.readIndex.essay[index] readSerial:self.readIndex.serial[index] readQuestion:self.readIndex.question[index] atIndex:index];
    if (!view.readSelected) {
        __weak typeof(self) weakSelf = self;
        view.readSelected = ^(MLBReadType type, NSInteger index) {
          __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf openReadDetailsViewControllerWithReadType:type index:index];
        };
    }
    return view;
}

-(void)willDealloc{}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
