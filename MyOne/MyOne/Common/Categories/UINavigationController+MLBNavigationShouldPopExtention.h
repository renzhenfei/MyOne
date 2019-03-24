//
//  UINavigationController+MLBNavigationShouldPopExtention.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/19.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UINavigationControllerShouldPop<NSObject>

-(BOOL)navigationControllerShouldPop:(UINavigationController *)navigationContoller;

@optional

-(BOOL)navigationControllerShouldStartInteractivePopGestureRecogizer:(UINavigationController *)navigationController;

@end

@interface UINavigationController (MLBNavigationShouldPopExtention)<UIGestureRecognizerDelegate>

@end
