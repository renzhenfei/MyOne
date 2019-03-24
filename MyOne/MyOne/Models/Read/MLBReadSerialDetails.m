//
//  MLBReadSerialDetails.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadSerialDetails.h"
#import "MLBAuthor.h"

@implementation MLBReadSerialDetails

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"contentId" : @"id",
             @"serialId" : @"serial_id",
             @"number" : @"number",
             @"title" : @"title",
             @"excerpt" : @"excerpt",
             @"content" : @"content",
             @"chargeEditor" : @"charge_edt",
             @"lastUpdateDate" : @"last_update_date",
             @"audioURL" : @"audio",
             @"webURL" : @"web_url",
             @"inputName" : @"input_name",
             @"lastUpdateName" : @"last_update_name",
             @"readNum" : @"read_num",
             @"makeTime" : @"maketime",
             @"author" : @"author",
             @"praiseNum" : @"praisenum",
             @"commentNum" : @"commentnum",
             @"shareNum" : @"sharenum"};
}

+(NSValueTransformer *)authorJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MLBAuthor class]];
}

@end
