//
//  MLBPreviousViewController.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/15.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseViewController.h"

typedef NS_ENUM(NSUInteger, MLBPreviousType) {
    MLBPreviousTypeHome,
    MLBPreviousTypeRead,
    MLBPreviousTypeMusic,
};

@interface MLBPreviousViewController : MLBBaseViewController

@property(nonatomic,assign)MLBPreviousType previousType;

@end
