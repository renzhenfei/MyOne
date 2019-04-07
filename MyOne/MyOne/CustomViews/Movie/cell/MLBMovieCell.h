//
//  MLBMovieCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/4/7.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"
#import "MLBMovieListItem.h"
FOUNDATION_EXPORT NSString *const KMLMovieCellID;

@interface MLBMovieCell : MLBBaseCell

-(void)configureWithMovie:(MLBMovieListItem *)movitItem indexPath:(NSIndexPath *)indexPath;

-(void)stopCountDownIfNeed;

@end
