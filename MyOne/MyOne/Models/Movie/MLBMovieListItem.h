//
//  MLBMovieListItem.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"

@interface MLBMovieListItem : MLBBaseModel

@property (nonatomic, strong) NSString *movieId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *verse;
@property (nonatomic, strong) NSString *verseEn;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *revisedScore;
@property (nonatomic, strong) NSString *releaseTime;
@property (nonatomic, strong) NSString *scoreTime;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, assign) NSTimeInterval serverTime;

@end
