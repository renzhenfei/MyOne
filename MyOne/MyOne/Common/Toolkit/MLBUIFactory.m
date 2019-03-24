//
//  MLBUIFactory.m
//  MyOne
//
//  Created by zhenfei ren on 2019/1/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBUIFactory.h"
#import <MJRefresh/MJRefresh.h>
@implementation MLBUIFactory

#pragma mark - UIView

+(UIView *)separatorLine{
    UIView *line = [UIView new];
    line.backgroundColor = MLBSeparatorColor;
    return line;
}

#pragma mark -UIButton

+(UIButton *)buttonWithImageName : (NSString *)imageName highLightImageName:(NSString *)highLightImageName target:(id)target action:(SEL)action{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IsStringNotEmpty(imageName)) {
        [bt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (IsStringNotEmpty(highLightImageName)) {
        [bt setImage:[UIImage imageNamed:highLightImageName] forState:UIControlStateHighlighted];
    }
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return bt;
}

+(UIButton *)buttonWithImageName : (NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IsStringNotEmpty(imageName)) {
        [bt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (IsStringNotEmpty(selectedImageName)) {
        [bt setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return bt;
}

+(UIButton *)buttonWithBackgroundImageName:(NSString *)imageName highLightImageName:(NSString *)highLightImageName target:(id)target action:(SEL)action{
    UIButton *bt = [self buttonWithImageName:nil highLightImageName:highLightImageName target:target action:action];
    if (IsStringNotEmpty(imageName)) {
        [bt setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    return bt;
}

+(UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(NSInteger)fontSize target:(id)target action:(SEL)action{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.titleLabel.text = title;
    bt.titleLabel.font = FontWithSize(fontSize);
    if (titleColor) {
        [bt setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (target) {
        [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return bt;
}

#pragma mark - MJRefresh

+(void)addMJRefreshTo:(UIScrollView *)scrollView target:(id)target refreshAction:(SEL)refreshAction loadMoreAction:(SEL)loadMoreAction{
    if (refreshAction) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:refreshAction];
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开立即刷新数据" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新中..." forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        scrollView.mj_header = header;
    }
    if (loadMoreAction) {
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:loadMoreAction];
        [footer setTitle:@"上拉可以加载更多" forState:MJRefreshStateIdle];
        [footer setTitle:@"松开立即加载更多" forState:MJRefreshStatePulling];
        [footer setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"到底了" forState:MJRefreshStateNoMoreData];
        scrollView.mj_footer = footer;
    }
}

+(void)myOne_addMJRefreshTo:(UIScrollView *)scrollView target:(id)target refreshAction:(SEL)refreshAction loadMoreAction:(SEL)loadMoreAction{
    if (refreshAction) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:refreshAction];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        scrollView.mj_header = header;
    }
    if (loadMoreAction) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:loadMoreAction];
        [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
        [footer setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"没有更多啦" forState:MJRefreshStateNoMoreData];
        scrollView.mj_footer = footer;
    }
}

#pragma mark - UILable

+(UILabel *)lableWithTextColor:(UIColor *)color font:(UIFont *)font{
    return [self lableWithTextColor:color font:font numberOfLine:1];
}

+(UILabel *)lableWithTextColor:(UIColor *)color font:(UIFont *)font numberOfLine:(NSInteger)numberOfLine{
    UILabel *lable = [UILabel new];
    lable.backgroundColor = [UIColor whiteColor];
    lable.textColor = color;
    lable.font = font;
    lable.numberOfLines = numberOfLine;
    return lable;
}
@end
