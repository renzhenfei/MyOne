//
//  UIScrollView+MLBEndMJRefreshing.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MLBEndMJRefreshing)


/**
 添加下拉和上拉加载

 @param target 目标
 @param refreshAction 下拉刷新方法
 @param loadMoreDataAction 上拉加载更多方法
 */
-(void)mlb_addRefreshingWithTarget:(id)target refreshAction:(SEL)refreshAction loadMoreDataAction:(SEL)loadMoreDataAction;

/**
 结束刷新

 @param hasMoreData 是否有更多数据
 */
-(void)mlb_endRefreshingHasMoreData:(BOOL)hasMoreData;

@end
