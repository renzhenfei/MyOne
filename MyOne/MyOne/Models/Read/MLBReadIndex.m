//
//  MLBReadIndex.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadIndex.h"

@implementation MLBReadIndex

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"essay" : @"essay",
             @"serial" : @"serial",
             @"question" : @"question"};
}

+ (NSValueTransformer *)essayJSONTransformer{
    NSLog(@"essayJSONTransformer ---------->>>");
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MLBReadEssay class]];
}

+ (NSValueTransformer *)serialJSONTransformer{
    NSLog(@"serialJSONTransformer ---------->>>");
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MLBReadSerial class]];
}

+ (NSValueTransformer *)questionJSONTransformer{
    NSLog(@"questionJSONTransformer ---------->>>");
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MLBReadQuestion class]];
}

@end
