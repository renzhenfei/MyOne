//
//  MLBSearchPictureCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"
@class MLBHomeItem;

FOUNDATION_EXPORT NSString *const kMLBSearchPictureCellID;

@interface MLBSearchPictureCell : MLBBaseCell

+(CGFloat)cellHeight;

-(void)configureCellWithHomeItem:(MLBHomeItem *)item;

@end
