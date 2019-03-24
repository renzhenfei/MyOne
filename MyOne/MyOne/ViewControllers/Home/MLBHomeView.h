//
//  MLBHomeView.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/15.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseView.h"
FOUNDATION_EXTERN NSString *const KMLHomeViewId;

@class MLBHomeItem;

@interface MLBHomeView : MLBBaseView

@property(nonatomic,copy) void(^clickButton)(MLBActionType type);

-(void)configireViewWithHomeItem:(MLBHomeItem *)homeItem atIndex:(NSInteger)index;

-(void)configureViewWithHomeItem:(MLBHomeItem *)homeItem atIndex:(NSInteger)index inViewController:(MLBBaseViewController *)viewController;

@end
