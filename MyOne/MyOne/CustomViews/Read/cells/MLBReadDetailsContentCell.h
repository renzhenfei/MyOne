//
//  MLBReadDetailsContentCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

FOUNDATION_EXPORT NSString *const KMLReadDetailsContentCellID;

@interface MLBReadDetailsContentCell : MLBBaseCell

- (void)configureCellWithContent:(NSString *)content editor:(NSString *)editor;

@end
