//
//  MLBMovieViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/4/7.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBMovieViewController.h"
#import <MJRefresh.h>
#import "MLBMovieCell.h"
#import "MLBhttpRequester.h"
#import "MLBMovieDetailsViewController.h"

@interface MLBMovieViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation MLBMovieViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad{
    self.title = MLBMovieTitle;
    [self addNavigationBarLeftBarItem];
    [self addNavigationBarRightMeItem];
    [self setupViews];
    self.dataSource = @[].mutableCopy;
    [self refreshAction];
}

-(void)setupViews{
    self.tableView = [[UITableView alloc] initWithFrame:[self.view bounds] style:UITableViewStylePlain];
    [self.tableView registerClass:[MLBMovieCell class] forCellReuseIdentifier:KMLMovieCellID];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [MLBUIFactory addMJRefreshTo:self.tableView target:self refreshAction:@selector(refreshAction) loadMoreAction:@selector(loadMoreAction)];
}

-(void)refreshAction{
    [self initData:30 refresh:YES];
}

-(void)loadMoreAction{
    NSInteger offset = self.dataSource.count + (30 - (self.dataSource.count % 30));
    [self initData:offset refresh:NO];
}

-(void)initData:(NSInteger)offset refresh:(BOOL)refresh{
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester requestMovieListWithOffer:offset success:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            NSArray *data = [MTLJSONAdapter modelsOfClass:[MLBMovieListItem class] fromJSONArray:responseObject[@"data"] error:&error];
            if (error) {
                [strongSelf.view showHUDModelTransformFailedWithError:error];
            }else{
                if (refresh) {
                    [strongSelf.dataSource removeAllObjects];
                }
                [strongSelf.dataSource addObjectsFromArray:data];
                [strongSelf.tableView reloadData];
            }
        }else{
            [strongSelf.view showHUDNetError];
        }
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return ;
        }
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.view showHUDServerError];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLBMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLMovieCellID forIndexPath:indexPath];
    [cell configureWithMovie:self.dataSource[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH * 0.4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLBMovieDetailsViewController *controller = [[MLBMovieDetailsViewController alloc] init];
    controller.movieItem = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
