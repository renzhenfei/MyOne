//
//  MLBMusicContentCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/30.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

@class MLBMusicDetail;

FOUNDATION_EXPORT NSString *const KMLMusicContentCellID;

@interface MLBMusicContentCell : MLBBaseCell

@property(nonatomic,copy) void(^contentTypeButtonSelected)(MLBMusicDetailsType buttonType);

-(void)configurCellWithMusicetail:(MLBMusicDetail *)musicDetail;

@end
