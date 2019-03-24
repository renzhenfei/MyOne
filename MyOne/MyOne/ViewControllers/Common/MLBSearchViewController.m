//
//  MLBSearchViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/25.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSearchViewController.h"
#import "DZNSegmentedControl.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "MLBhttpRequester.h"
#import "MTLModel+MANullableScalar.h"
#import "MLBUser.h"
#import "MLBHomeItem.h"
#import "MLBRelatedMusic.h"
#import "MLBMovieListItem.h"
#import "MLBSearchRead.h"
#import "MLBSearchPictureCell.h"
#import "MLBSearchReadCell.h"
#import "MLBSearchMusicCell.h"
#import "MLBSearchMovieCell.h"
#import "MLBSearchAuthorCell.h"
@interface MLBSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource>

@property(strong,nonatomic) UISearchBar *searchBar;
@property(strong,nonatomic) UIImageView *hintView;
@property(strong,nonatomic) DZNSegmentedControl *segmentedControl;
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation MLBSearchViewController{
    MLBSearchType searchType;
    NSMutableDictionary *dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDatas];
    [self setupViews];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [_searchBar becomeFirstResponder];
}

-(void)initDatas{
    dataSource = [NSMutableDictionary dictionaryWithCapacity:5];
    searchType = MLBSearchTypeHome;
}

-(void)setupViews{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    _searchBar = [UISearchBar new];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.tintColor = MLBLightGrayTextColor;
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
    DZNSegmentedControl *segmentedControl = [[DZNSegmentedControl alloc] initWithItems:@[@"插图", @"阅读", @"音乐", @"影视", @"作者/音乐人"]];
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
    segmentedControl.showsCount = NO;
    segmentedControl.font = FontWithSize(12);
    [segmentedControl setTitleColor:MLBColor7F7F7F forState:UIControlStateNormal];
    segmentedControl.tintColor = MLBAppThemeColor;
    segmentedControl.hairlineColor = nil;
    [segmentedControl addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.left.top.right.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    _segmentedControl = segmentedControl;
    _segmentedControl.hidden = YES;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView registerClass:mlbsearchp forCellReuseIdentifier:<#(nonnull NSString *)#>
    tableView.tableFooterView = [UIView new];
    tableView.emptyDataSetSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    _tableView = tableView;
    _tableView.hidden = YES;
    UIImageView *hintView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_all"]];
    hintView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:hintView];
    [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(165, 110));
        make.top.equalTo(self.view).offset(114);
        make.centerX.equalTo(self.view);
    }];
    _hintView = hintView;
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.hidesWhenStopped = YES;
    [self.view addSubview:indicatorView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

-(void)selectedSegment:(DZNSegmentedControl *)control{
    switch ([control selectedSegmentIndex]) {
        case 0:
            searchType = MLBSearchTypeHome;
            break;
        case 1:
            searchType = MLBSearchTypeRead;
            break;
        case 2:
            searchType = MLBSearchTypeMusic;
            break;
        case 3:
            searchType = MLBSearchTypeMovie;
            break;
        case 4:
            searchType = MLBSearchTypeAuthor;
            break;
            
        default:
            break;
    }
    
}

#pragma mark - NerWork Request
-(void)searching{
    [self.activityIndicatorView startAnimating];
    __weak typeof(self) weakSelf = self;
    [MLBhttpRequester searchWithType:[MLBhttpRequester apiStringForSearchWithSearchType:searchType] kekywords:self.searchBar.text ssuccess:^(id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf processWithResponseObject:responseObject];
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
//        strongSelf.view sho
    }];
}

-(void)processWithResponseObject:(id)responseObject{
    if ([responseObject[@"res"] integerValue] == 0) {
        NSError *error;
        NSArray *results;
        NSArray *data = responseObject[@"data"];
        switch (searchType) {
            case MLBSearchTypeHome:
                results = [MTLJSONAdapter modelsOfClass:[MLBHomeItem class] fromJSONArray:data error:&error];
                break;
            case MLBSearchTypeRead:
                results = [MTLJSONAdapter modelsOfClass:[MLBSearchRead class] fromJSONArray:data error:&error];
                break;
            case MLBSearchTypeMusic:
                results = [MTLJSONAdapter modelsOfClass:[MLBRelatedMusic class] fromJSONArray:data error:&error];
                break;
            case MLBSearchTypeMovie:
                results = [MTLJSONAdapter modelsOfClass:[MLBMovieListItem class] fromJSONArray:data error:&error];
                break;
            case MLBSearchTypeAuthor:
                results = [MTLJSONAdapter modelsOfClass:[MLBUser class] fromJSONArray:data error:&error];
                break;
            default:
                break;
        }
        if (!error) {
            if (results) {
                [dataSource setObject:results forKey:[@(searchType) stringValue]];
                self.segmentedControl.hidden = NO;
                self.tableView.hidden = NO;
                self.hintView.hidden = YES;
                [self.tableView reloadData];
            }else{
                self.hintView.hidden = NO;
            }
            [self.activityIndicatorView stopAnimating];
        }else{
            [self.view showHUDModelTransformFailedWithError:error];
        }
    }
}

-(void)cancel{
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark View Lifecycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self searching];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = dataSource[[@(searchType) stringValue]];
    return arr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (searchType) {
        case MLBSearchTypeHome:
            return [tableView dequeueReusableCellWithIdentifier:kMLBSearchPictureCellID forIndexPath:indexPath];
            break;
        case MLBSearchTypeRead:
            return [tableView dequeueReusableCellWithIdentifier:KMLSearchReadCellID forIndexPath:indexPath];
            break;
        case MLBSearchTypeMusic:
            return [tableView dequeueReusableCellWithIdentifier:KMLSearchRelatedMusicID forIndexPath:indexPath];
            break;
        case MLBSearchTypeMovie:
            return [tableView dequeueReusableCellWithIdentifier:KMLSearchMovieCellID forIndexPath:indexPath];
            break;
        case MLBSearchTypeAuthor:
            return [tableView dequeueReusableCellWithIdentifier:KMLSearchAuthorID forIndexPath:indexPath];
            break;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (searchType) {
        case MLBSearchTypeHome:
            return [MLBSearchPictureCell cellHeight];
            break;
        case MLBSearchTypeRead:
            return [MLBSearchReadCell cellHeight];
            break;
        case MLBSearchTypeMovie:
            return [MLBSearchMovieCell cellHeight];
            break;
        case MLBSearchTypeMusic:
            return [MLBSearchMusicCell cellHeight];
            break;
        case MLBSearchTypeAuthor:
            return [MLBSearchAuthorCell cellHeight];
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *datas =  dataSource[[@(searchType) stringValue]];
    MLBBaseModel *model = datas[indexPath.row];
    switch (searchType) {
        case MLBSearchTypeAuthor:
            [((MLBSearchAuthorCell *)cell) configureCellWithUser:(MLBUser *)model];
            break;
        case MLBSearchTypeMusic:
            [((MLBSearchMusicCell *)cell) configureWithMLBRelatedMusic:(MLBRelatedMusic *)model];
            break;
        case MLBSearchTypeMovie:
            [((MLBSearchMovieCell *)cell) configureWithMovieItem:(MLBMovieListItem *)model];
            break;
        case MLBSearchTypeRead:
            [((MLBSearchReadCell *)cell) configureCellWithSearchRead:(MLBSearchRead *)model];
            break;
        case MLBSearchTypeHome:
            [((MLBSearchPictureCell *)cell) configureCellWithHomeItem:(MLBHomeItem *)model];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (searchType) {
        case MLBSearchTypeAuthor:
//            [((MLBSearchAuthorCell *)cell) configureCellWithUser:(MLBUser *)model];
            break;
        case MLBSearchTypeMusic:
//            [((MLBSearchMusicCell *)cell) configureWithMLBRelatedMusic:(MLBRelatedMusic *)model];
            break;
        case MLBSearchTypeMovie:
//            [((MLBSearchMovieCell *)cell) configureWithMovieItem:(MLBMovieListItem *)model];
            break;
        case MLBSearchTypeRead:
//            [((MLBSearchReadCell *)cell) configureCellWithSearchRead:(MLBSearchRead *)model];
            break;
        case MLBSearchTypeHome:
//            [((MLBSearchPictureCell *)cell) configureCellWithHomeItem:(MLBHomeItem *)model];
            break;
    }
}

#pragma mark - DZNEmptyDataSetSource

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"search_null_image"];
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
