//
//  MLBSearchMusicCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

FOUNDATION_EXPORT NSString *const KMLSearchRelatedMusicID;

@class MLBRelatedMusic;

@interface MLBSearchMusicCell : MLBBaseCell

+(CGFloat)cellHeight;

-(void)configureWithMLBRelatedMusic:(MLBRelatedMusic *)music;

@end
