//
//  MLBSerialCCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/27.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

FOUNDATION_EXPORT NSString *const kMLBSerialCCellID;

@interface MLBSerialCCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *numberLabel;

+ (CGSize)cellSize;

@end
