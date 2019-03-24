//
//  MLBReadCarouselItem.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadCarouselItem.h"

@implementation MLBReadCarouselItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"itemId" : @"id",
             @"title" : @"title",
             @"cover" : @"cover",
             @"bottomText" : @"bottom_text",
             @"bgColor" : @"bgcolor",
             @"pvURL" : @"pv_url"};
}

@end
