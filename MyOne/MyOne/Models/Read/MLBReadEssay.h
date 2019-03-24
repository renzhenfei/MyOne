//
//  MLBReadEssay.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"

@interface MLBReadEssay : MLBBaseModel

@property (nonatomic, strong) NSString *contentId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *makeTime;
@property (nonatomic, strong) NSString *guideWord;
@property (nonatomic, strong) NSArray *authors;
@property (nonatomic, assign) BOOL hasAudio;

@end
