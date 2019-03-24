//
//  MLBReadDetailsAuthorInfoCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"
@class MLBAuthor;
FOUNDATION_EXPORT NSString *const KMLReadDetailsAuthorInfoCellID;

@interface MLBReadDetailsAuthorInfoCell : MLBBaseCell

- (void)configureCellWithAuthor:(MLBAuthor *)author;

@end
