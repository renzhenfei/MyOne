//
//  MLBReadQuestionDetails.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadQuestionDetails.h"

@implementation MLBReadQuestionDetails

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"questionId" : @"question_id",
             @"questionTitle" : @"question_title",
             @"questionContent" : @"question_content",
             @"answerTitle" : @"answer_title",
             @"answerContent" : @"answer_content",
             @"questionMakeTime" : @"question_makettime",
             @"recommendFlag" : @"recommend_flag",
             @"chargeEditor" : @"charge_edt",
             @"lastUpdateDate" : @"last_update_date",
             @"webURL" : @"web_url",
             @"praiseNum" : @"praisenum",
             @"readNum" : @"read_num",
             @"guideWord" : @"guide_word",
             @"shareNum" : @"sharenum",
             @"commentNum" : @"commentnum"};
}

@end
