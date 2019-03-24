//
//  MLBRelatedMusic.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBRelatedMusic.h"

@implementation MLBRelatedMusic

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"musicId" : @"id",
             @"title" : @"title",
             @"cover" : @"cover",
             @"platform" : @"platform",
             @"musicLongId" : @"music_id",
             @"author" : @"author"};
}

+(NSValueTransformer *)authorJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MLBAuthor class]];
}

@end
