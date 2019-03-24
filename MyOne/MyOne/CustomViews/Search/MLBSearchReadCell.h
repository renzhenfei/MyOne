//
//  MLBSearchReadCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

FOUNDATION_EXPORT NSString *const KMLSearchReadCellID;

@class MLBSearchRead;

@interface MLBSearchReadCell : MLBBaseCell

+(CGFloat)cellHeight;

-(void)configureCellWithSearchRead:(MLBSearchRead *)read;

@end
