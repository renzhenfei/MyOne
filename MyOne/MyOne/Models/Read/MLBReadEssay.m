//
//  MLBReadEssay.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadEssay.h"
#import "MLBAuthor.h"
@implementation MLBReadEssay

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"contentId" : @"content_id",
             @"title" : @"hp_title",
             @"makeTime" : @"hp_makettime",
             @"guideWord" : @"guide_word",
             @"authors" : @"author",
             @"hasAudio" : @"has_audio"
             };
}

+ (NSValueTransformer *)authorsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MLBAuthor class]];
}

@end
