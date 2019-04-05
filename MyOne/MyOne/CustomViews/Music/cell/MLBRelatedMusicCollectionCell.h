//
//  MLBRelatedMusicCollectionCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/31.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

#import "MLBRelatedMusic.h"

FOUNDATION_EXPORT NSString *const KMLRelatedMusicCollectionCellID;

@interface MLBRelatedMusicCollectionCell : MLBBaseCell

+(CGFloat)cellHeight;

-(void)configureCellWithRelatedMusic:(NSArray<MLBRelatedMusic *> *)musics;

@end
