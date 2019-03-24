//
//  MLBReadDetailsTitleAndOperationCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

FOUNDATION_EXPORT NSString *const KMLReadDetailsTitleAndOperationCellID;

@interface MLBReadDetailsTitleAndOperationCell : MLBBaseCell

@property(strong,nonatomic) UILabel *titleLable;
@property(strong,nonatomic) UIButton *serialsButton;

@property(copy,nonatomic) void(^serialsClicked)(void);

@end
