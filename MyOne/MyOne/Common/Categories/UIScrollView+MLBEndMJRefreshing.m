//
//  UIScrollView+MLBEndMJRefreshing.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "UIScrollView+MLBEndMJRefreshing.h"
#import <MJRefresh.h>

@implementation UIScrollView (MLBEndMJRefreshing)

/**
 添加下拉和上拉加载
 
 @param target 目标
 @param refreshAction 下拉刷新方法
 @param loadMoreDataAction 上拉加载更多方法
 */
-(void)mlb_addRefreshingWithTarget:(id)target refreshAction:(SEL)refreshAction loadMoreDataAction:(SEL)loadMoreDataAction{
    if (!target) {
        NSException *exception = [NSException exceptionWithName:@"error" reason:@"nil error" userInfo:nil];
        @throw exception;
        return;
    }
    if (refreshAction) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:refreshAction];
        self.mj_header = header;
    }
    if (loadMoreDataAction) {
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:loadMoreDataAction];
        self.mj_footer = footer;
    }
}

/**
 结束刷新
 
 @param hasMoreData 是否有更多数据
 */
-(void)mlb_endRefreshingHasMoreData:(BOOL)hasMoreData{
    if (self.mj_header && self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
        [self.mj_footer resetNoMoreData];
    }
    if (hasMoreData) {
        [self.mj_footer endRefreshing];
    }else{
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

@end
