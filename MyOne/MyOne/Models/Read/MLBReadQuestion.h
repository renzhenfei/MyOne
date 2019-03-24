//
//  MLBReadQuestion.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"

@interface MLBReadQuestion : MLBBaseModel

@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *questionTitle;
@property (nonatomic, strong) NSString *answerTitle;
@property (nonatomic, strong) NSString *answerContent;
@property (nonatomic, strong) NSString *questionMakeTime;

@end
