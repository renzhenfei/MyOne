//
//  MLBCommentList.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/30.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBCommentList.h"

@implementation MLBCommentList

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"count" : @"count",
             @"comments" : @"data"};
}

+(NSValueTransformer *)commentsJSONTransformer{
    return [MTLJSONAdapter transformerForModelPropertiesOfClass:[MLBComment class]];
}

@end
