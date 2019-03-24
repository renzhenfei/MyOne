//
//  MLBComment.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBComment.h"

@implementation MLBComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"commentId" : @"id",
             @"quote" : @"quote",
             @"content" : @"content",
             @"praiseNum" : @"praisenum",
             @"inputDate" : @"input_date",
             @"user" : @"user",
             @"toUser" : @"touser",
             @"commentType" : @"type"};
}

+(NSValueTransformer *)userJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MLBUser class]];
}

+(NSValueTransformer *)toUserJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MLBUser class]];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOflines = 0;
    }
    return self;
}

@end
