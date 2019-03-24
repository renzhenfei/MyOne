//
//  MLBMovieStory.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"
#import "MLBUser.h"
@interface MLBMovieStory : MLBBaseModel

@property (nonatomic, strong) NSString *storyId;
@property (nonatomic, strong) NSString *movieId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, assign) NSInteger praiseNum;
@property (nonatomic, strong) NSString *inputDate;
@property (nonatomic, strong) NSString *storyType;
@property (nonatomic, strong) MLBUser *user;

@end
