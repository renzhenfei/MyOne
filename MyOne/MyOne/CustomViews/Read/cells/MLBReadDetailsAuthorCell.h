//
//  MLBReadDetailsAuthorCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

FOUNDATION_EXPORT NSString *const KMLReadDetailsAuthorCellID;

@class MLBReadEssayDetails;
@class MLBReadSerialDetails;

@interface MLBReadDetailsAuthorCell : MLBBaseCell

- (void)configureCellWithEssayDetails:(MLBReadEssayDetails *)essayDetails;

- (void)configureCellWithSerialDetails:(MLBReadSerialDetails *)serialDetails;

@end
