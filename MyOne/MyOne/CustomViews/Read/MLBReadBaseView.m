//
//  MLBReadBaseView.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadBaseView.h"
#import "MLBReadEssay.h"
#import "MLBReadSerial.h"
#import "MLBReadQuestion.h"
#import "MLBReadBaseCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

NSString *const KMLReadBaseViewID = @"KMLReadBaseViewID";

@interface MLBReadBaseView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) MLBReadEssay *readEssay;
@property (copy, nonatomic) MLBReadSerial *readSerial;
@property (copy, nonatomic) MLBReadQuestion *readQuestion;
@property (strong, nonatomic) MASConstraint *tableViewHeightConstraint;
@property (strong, nonatomic) NSMutableArray *rowHeights;

@end

@implementation MLBReadBaseView

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Public Method

- (void)configureViewWithReadEssay:(MLBReadEssay *)readEssay readSerial:(MLBReadSerial *)readSerial readQuestion:(MLBReadQuestion *)readQuestion atIndex:(NSInteger)index{
    [self configireViewWithReadEssay:readEssay readSerial:readSerial readQuestion:readQuestion atIndex:index inViewController:nil];
}

-(void)configireViewWithReadEssay:(MLBReadEssay *)readEssay readSerial:(MLBReadSerial *)readSerial readQuestion:(MLBReadQuestion *)readQuestion atIndex:(NSInteger)index inViewController:(MLBBaseViewController *)parentViewController{
    self.viewIndex = index;
    self.parentViewController = parentViewController;
    self.readEssay = readEssay;
    self.readSerial = readSerial;
    self.readQuestion = readQuestion;
    self.rowHeights = @[@0,@0,@0].mutableCopy;
    self.scrollView.contentOffset = CGPointZero;
    [self.tableView reloadData];
}

#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLBReadBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:KMLReadBaseCellID forIndexPath:indexPath];
    [self configureCell:cell indexPath:indexPath];
    return cell;
}

-(void)configureCell:(MLBReadBaseCell *)cell indexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [cell configureCellWithReadEssay:self.readEssay];
    }else if(indexPath.row == 1){
        [cell configureCellWithReadSerial:self.readSerial];
    }else{
        [cell configureCellWithReadQuestion:self.readQuestion];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.readSelected){
        self.readSelected(indexPath.row == 0 ? MLBReadTypeEssay : (indexPath.row == 1 ? MLBReadTypeSerial : MLBReadTypeQuestion), self.viewIndex);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:KMLReadBaseCellID configuration:^(MLBReadBaseCell *cell) {
        [self configureCell:cell indexPath:indexPath];
    }];
    self.rowHeights[indexPath.row] = @(ceil(height));
    if (indexPath.row == self.rowHeights.count - 1) {
        NSInteger tableViewHeight = 0;
        for (NSNumber *cellHeight in self.rowHeights) {
            tableViewHeight += [cellHeight integerValue];
        }
        self.tableViewHeightConstraint.equalTo(@(tableViewHeight));
    }
    return ceil(height);
}

#pragma mark - Private Method

-(void)setupViews{
    if (self.scrollView) {
        return;
    }
    self.scrollView = ({
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        scrollView;
    });
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(12, 12, SCREEN_WIDTH, 450)];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[MLBReadBaseCell class] forCellReuseIdentifier:KMLReadBaseCellID];
        tableView.tableFooterView = [UIView new];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        tableView.scrollsToTop = NO;
        tableView.translatesAutoresizingMaskIntoConstraints = YES;
        tableView.layer.masksToBounds = NO;
        tableView.layer.shadowColor = MLBShadowColor.CGColor;
        tableView.layer.shadowRadius = 2;
        tableView.layer.shadowOffset = CGSizeZero;
        tableView.layer.shadowOpacity = 0.5;
        tableView.layer.cornerRadius = 5;
        [self.scrollView addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView).insets(UIEdgeInsetsMake(12, 12, 12, 12));
            make.width.mas_equalTo(SCREEN_WIDTH - 24);
            self.tableViewHeightConstraint = make.height.mas_equalTo(450);
        }];
        tableView;
    });
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}

@end
