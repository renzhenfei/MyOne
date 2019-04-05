//
//  MLBCommentList.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"
@class MLBComment;

@interface MLBCommentList : MLBBaseModel

@property(assign,nonatomic) NSInteger count;
@property(strong,nonatomic) NSMutableArray<MLBComment *> *hotComments;
@property(strong,nonatomic) NSMutableArray<MLBComment *> *comments;

@end
