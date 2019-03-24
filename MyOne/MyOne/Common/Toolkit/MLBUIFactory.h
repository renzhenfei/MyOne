//
//  MLBUIFactory.h
//  MyOne
//
//  Created by zhenfei ren on 2019/1/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLBUIFactory : NSObject

#pragma mark - UIView

+(UIView *)separatorLine;

#pragma mark -UIButton

+(UIButton *)buttonWithImageName : (NSString *)imageName highLightImageName:(NSString *)highLightImageName target:(id)target action:(SEL)action;

+(UIButton *)buttonWithImageName : (NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;

+(UIButton *)buttonWithBackgroundImageName:(NSString *)imageName highLightImageName:(NSString *)highLightImageName target:(id)target action:(SEL)action;

+(UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(NSInteger)fontSize target:(id)target action:(SEL)action;

#pragma mark - MJRefresh

+(void)addMJRefreshTo:(UIScrollView *)scrollView target:(id)target refreshAction:(SEL)refreshAction loadMoreAction:(SEL)loadMoreAction;

+(void)myOne_addMJRefreshTo:(UIScrollView *)scrollView target:(id)target refreshAction:(SEL)refreshAction loadMoreAction:(SEL)loadMoreAction;

#pragma mark - UILable

+(UILabel *)lableWithTextColor:(UIColor *)color font:(UIFont *)font;

+(UILabel *)lableWithTextColor:(UIColor *)color font:(UIFont *)font numberOfLine:(NSInteger)numberOfLine;


@end
