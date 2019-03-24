//
//  MLBSearchRead.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBSearchRead.h"

@implementation MLBSearchRead

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"readId" : @"id",
             @"title" : @"title",
             @"type" : @"type",
             @"number" : @"number"};
}

+(NSValueTransformer *)numberJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if ([value isKindOfClass:[NSString class]]) {
            return @([value integerValue]);
        }else{
            return value;
        }
    }];
}

@end
