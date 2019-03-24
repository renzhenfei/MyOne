//
//  MLBBaseViewController.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLBBaseViewController : UIViewController

@property(nonatomic,assign) BOOL hideNavigationBar;

-(CGFloat)navigationBarHeight;

#pragma mark  -UI

-(void)addNavigationBarLeftBarItem;

-(void)addNavigationBarRightMeItem;

#pragma mark - Action

-(void)presentLoginOptionsViewController;

@end
