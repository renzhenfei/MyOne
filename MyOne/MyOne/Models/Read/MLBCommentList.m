//
//  MLBCommentList.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBCommentList.h"
#import "MLBComment.h"
@implementation MLBCommentList

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"count" : @"count",
             @"comments" : @"data"};
}

+(NSValueTransformer *)commentsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MLBComment class]];
}

@end
