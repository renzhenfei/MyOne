//
//  MLBNoneMessageCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/31.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

FOUNDATION_EXPORT NSString *const KMLNoneMessageCellID;

@interface MLBNoneMessageCell : MLBBaseCell

@property (nonatomic, strong) UIImageView *hintView;

+ (CGFloat)cellHeight;

@end
