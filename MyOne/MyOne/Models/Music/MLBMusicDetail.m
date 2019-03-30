//
//  MLBMusicDetail.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/30.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBMusicDetail.h"

@implementation MLBMusicDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"musicId" : @"id",
             @"title" : @"title",
             @"cover" : @"cover",
             @"isFirst" : @"isfirst",
             @"storyTitle" : @"story_title",
             @"story" : @"story",
             @"lyric" : @"lyric",
             @"info" : @"info",
             @"platform" : @"platform",
             @"musicURL" : @"music_id",
             @"chargeEditor" : @"charge_edt",
             @"relatedTo" : @"related_to",
             @"webURL" : @"web_url",
             @"praiseNum" : @"praisenum",
             @"sort" : @"sort",
             @"makeTime" : @"maketime",
             @"lastUpdateDate" : @"last_update_date",
             @"author" : @"author",
             @"storyAuthor" : @"story_author",
             @"commentNum" : @"commentnum",
             @"readNum" : @"read_num",
             @"shareNum" : @"sharenum"};
}

+(NSValueTransformer *)authorJSONTransformer{
    return [MTLJSONAdapter transformerForModelPropertiesOfClass:[MLBAuthor class]];
}

+(NSValueTransformer *)storyAuthorJSONTransformer{
    return [MTLJSONAdapter transformerForModelPropertiesOfClass:[MLBAuthor class]];
}

@end
