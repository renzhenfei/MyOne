//
//  MLBUser.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBUser.h"

@implementation MLBUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"userId":@"user_id",
             @"username":@"user_name",
             @"webURL":@"web_url",
             @"desc":@"desc"};
}

@end
