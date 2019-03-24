//
//  MLBAuthor.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBAuthor.h"

@implementation MLBAuthor

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"userId" : @"user_id",
             @"username" : @"user_name",
             @"webURL" : @"web_url",
             @"wbName" : @"wb_name",
             @"desc" : @"desc"};
}

@end
