//
//  MLBSerialList.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/27.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSerialList.h"

@implementation MLBSerialList

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"serialId" : @"id",
             @"title" : @"title",
             @"finished" : @"finished",
             @"list" : @"list"};
}

+ (NSValueTransformer *)listJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MLBSearchRead class]];;
}

@end
