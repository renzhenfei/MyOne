//
//  MLBReadBaseCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/20.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

FOUNDATION_EXPORT NSString *const KMLReadBaseCellID;

@class MLBReadEssay;
@class MLBReadQuestion;
@class MLBReadSerial;
@class MLBBaseModel;

@interface MLBReadBaseCell : MLBBaseCell

-(void)configureCellWithBaseModel:(MLBBaseModel *)model;

-(void)configureCellWithReadEssay:(MLBReadEssay *)model;

-(void)configureCellWithReadSerial:(MLBReadSerial *)model;

-(void)configureCellWithReadQuestion:(MLBReadQuestion *)model;

@end
