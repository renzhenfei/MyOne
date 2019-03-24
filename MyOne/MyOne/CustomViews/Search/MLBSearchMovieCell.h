//
//  MLBSearchMovieCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"
@class MLBMovieListItem;
FOUNDATION_EXPORT NSString *const KMLSearchMovieCellID;

@interface MLBSearchMovieCell : MLBBaseCell

+(CGFloat)cellHeight;

-(void)configureWithMovieItem:(MLBMovieListItem *)movieItem;

@end
