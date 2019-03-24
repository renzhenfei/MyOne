//
//  MLBReadDetailsQuestionAnswerCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

#import "MLBReadQuestionDetails.h"

FOUNDATION_EXPORT NSString *const KMLReadDetailsQuestionAnswerCellID;

@interface MLBReadDetailsQuestionAnswerCell : MLBBaseCell

- (void)configureCellWithQuestionDetails:(MLBReadQuestionDetails *)questionDetails;

@end
