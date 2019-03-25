//
//  MLBBaseView.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLBBaseViewController;

@interface MLBBaseView : UIView

@property(nonatomic,weak) MLBBaseViewController *parentViewController;

@property(nonatomic,assign) NSInteger viewIndex;

@end
