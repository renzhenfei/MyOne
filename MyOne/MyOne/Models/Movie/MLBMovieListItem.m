//
//  MLBMovieListItem.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBMovieListItem.h"

@implementation MLBMovieListItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"movieId" : @"id",
             @"title" : @"title",
             @"verse" : @"verse",
             @"verseEn" : @"verse_en",
             @"score" : @"score",
             @"revisedScore" : @"revisedscore",
             @"releaseTime" : @"releasetime",
             @"scoreTime" : @"scoretime",
             @"cover" : @"cover",
             @"serverTime" : @"servertime"};
}

@end
