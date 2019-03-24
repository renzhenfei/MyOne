//
//  MLBReadEssayDetails.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadEssayDetails.h"
#import "MLBAuthor.h"
@implementation MLBReadEssayDetails

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"contentId" : @"content_id",
             @"title" : @"hp_title",
             @"subtitle" : @"sub_title",
             @"authorName" : @"hp_author",
             @"authorDesc" : @"auth_it",
             @"chargeEditor" : @"hp_author_introduce",
             @"content" : @"hp_content",
             @"makeTime" : @"hp_makettime",
             @"wbName" : @"wb_name",
             @"wbImageURL" : @"wb_img_url",
             @"lastUpdateDate" : @"last_update_date",
             @"webURL" : @"web_url",
             @"guideWord" : @"guide_word",
             @"audioURL" : @"audio",
             @"authors" : @"author",
             @"praiseNum" : @"praisenum",
             @"shareNum" : @"sharenum",
             @"commentNum" : @"commentnum"};
}

+(NSValueTransformer *)authorsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MLBAuthor class]];
}

@end
