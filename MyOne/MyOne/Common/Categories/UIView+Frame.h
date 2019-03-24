//
//  UIView+Frame.h
//  MyOne
//
//  Created by zhenfei ren on 2019/1/27.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property(nonatomic,assign) CGFloat x;
@property(nonatomic,assign) CGFloat y;
@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;
@property(nonatomic,assign) CGFloat with;
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,assign) CGSize size;

@property(nonatomic,assign) CGFloat top;
@property(nonatomic,assign) CGFloat bottom;
@property(nonatomic,assign) CGFloat left;
@property(nonatomic,assign) CGFloat right;

@end
