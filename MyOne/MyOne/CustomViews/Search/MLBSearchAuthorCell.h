//
//  MLBSearchAuthorCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"
@class MLBUser;
FOUNDATION_EXPORT NSString *const KMLSearchAuthorID;

@interface MLBSearchAuthorCell : MLBBaseCell

+(CGFloat)cellHeight;

-(void)configureCellWithUser:(MLBUser *)user;

@end
