//
//  MLBReadSerial.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadSerial.h"
#import "MLBAuthor.h"

@implementation MLBReadSerial

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"contentId" : @"id",
             @"serialId" : @"serial_id",
             @"number" : @"number",
             @"title" : @"title",
             @"excerpt" : @"excerpt",
             @"readNum" : @"read_num",
             @"makeTime" : @"maketime",
             @"author" : @"author",
             @"hasAudio" : @"has_audio"};
}

+ (NSValueTransformer *)authorJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MLBAuthor class]];
}


@end
