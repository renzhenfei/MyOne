//
//  MLBReadQuestion.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadQuestion.h"

@implementation MLBReadQuestion

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"questionId" : @"question_id",
             @"questionTitle" : @"question_title",
             @"answerTitle" : @"answer_title",
             @"answerContent" : @"answer_content",
             @"questionMakeTime" : @"question_makettime"};
}

@end
