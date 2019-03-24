//
//  MLBSingleReadDetailsViewController.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseViewController.h"
#import "MLBBaseModel.h"

@interface MLBSingleReadDetailsViewController : MLBBaseViewController

@property(nonatomic,strong) MLBBaseModel *readModel;
@property(nonatomic,assign) MLBReadType readType;

@end
