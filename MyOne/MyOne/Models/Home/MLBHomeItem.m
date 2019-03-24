//
//  MLBHomeItem.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBHomeItem.h"

@implementation MLBHomeItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"contentId" : @"hpcontent_id",
             @"content" : @"hp_content",
             @"title" : @"hp_title",
             @"imageURL" : @"hp_img_url",
             @"imageOriginalURL" : @"hp_img_original_url",
             @"authorId" : @"author_id",
             @"authorName" : @"hp_author",
             @"iPadURL" : @"ipad_url",
             @"makeTime" : @"hp_makettime",
             @"lastUpdateDate" : @"last_update_date",
             @"webURL" : @"web_url",
             @"wbImageURL" : @"wb_img_url",
             @"praiseNum" : @"praisenum",
             @"shareNum" : @"sharenum",
             @"commentNum" : @"commentnum"};
}

@end
